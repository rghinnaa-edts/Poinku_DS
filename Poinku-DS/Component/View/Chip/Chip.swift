//
//  Chip.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 21/03/25.
//

import UIKit

class Chip: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var ivChip: UIImageView!
    @IBOutlet var lblChip: UILabel!
    
    private var ivChipConstraints: [NSLayoutConstraint] = []
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    var onTap: (() -> Void)?
    
    var text = "" {
        didSet {
            lblChip.text = text
        }
    }
    
    var image: UIImage? = nil {
        didSet {
            setupUI()
        }
    }
    
    var isActive: Bool = false {
        didSet {
            setupUI()
        }
    }
    
    var isClickable: Bool = true {
        didSet {
            setupClickability()
        }
    }
    
    var textColorActive: UIColor = UIColor.white {
        didSet {
            if isActive {
                setupUI()
            }
        }
    }
    
    var textColorInactive: UIColor = UIColor.grey80 {
        didSet {
            if !isActive {
                setupUI()
            }
        }
    }
    
    var activeColor: UIColor = UIColor.blue30 {
        didSet {
            if isActive {
                setupUI()
            }
        }
    }
    
    var inactiveColor: UIColor = UIColor.grey20 {
        didSet {
            if !isActive {
                setupUI()
            }
        }
    }
    
    var borderActiveColor: CGColor = UIColor.blue40.cgColor {
        didSet {
            if isActive {
                setupUI()
            }
        }
    }
    
    var borderInactiveColor: CGColor? = nil {
        didSet {
            if !isActive {
                setupUI()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChip()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupChip()
    }
    
    private func setupChip() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("Chip", owner: self, options: nil),
           let view = nib.first as? UIView {
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            setupUI()
            lblChip.text = text
        } else {
            print("Failed to load Chip XIB")
        }
    }
    
    private func setupUI() {
        if image == nil {
            ivChipConstraints = ivChip.constraints
            NSLayoutConstraint.deactivate(ivChipConstraints)
            ivChip.isHidden = true
        } else {
            NSLayoutConstraint.activate(ivChipConstraints)
            ivChip.isHidden = false
            ivChip.image = image?.withRenderingMode(.alwaysTemplate)
        }
        
        containerView?.layer.cornerRadius = 10
        lblChip.font = Font.Body.B3.Small.font
        
        if isActive {
            containerView?.backgroundColor = activeColor
            containerView?.layer.borderWidth = 1
            containerView?.layer.borderColor = borderActiveColor
            
            lblChip.textColor = textColorActive
            ivChip.tintColor = textColorActive
        } else {
            containerView?.backgroundColor = inactiveColor
            if let borderColor = borderInactiveColor {
                containerView?.layer.borderWidth = 1
                containerView?.layer.borderColor = borderColor
            } else {
                containerView?.layer.borderWidth = 0
            }
            
            lblChip.textColor = textColorInactive
            ivChip.tintColor = textColorInactive
        }
    }
    
    private func setupClickability() {
        if let existingGesture = tapGestureRecognizer {
            containerView.removeGestureRecognizer(existingGesture)
            tapGestureRecognizer = nil
        }
        
        if isClickable {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chipTapped))
            containerView.addGestureRecognizer(tapGesture)
            tapGestureRecognizer = tapGesture
            
            containerView.isUserInteractionEnabled = true
            containerView.alpha = 1.0
        } else {
            containerView.isUserInteractionEnabled = false
            containerView.alpha = 0.9
        }
        
        setupUI()
    }
    
    @objc private func chipTapped() {
        if isClickable {
            isActive = !isActive
            
            onTap?()
        }
    }
    
}
