//
//  StampBrand.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 04/03/25.
//

import UIKit

public class StampBrand: UICollectionViewCell {
    
    @IBOutlet var stampBrand: UIView!
    @IBOutlet var ivBrand: UIImageView!
    @IBOutlet var lblTotalStamp: UILabel!
    @IBOutlet var lblStamp: UILabel!
    
    public var isActive = false
    public var isSelectedState: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStampBrand()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStampBrand()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupStampBrand() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("StampBrand", owner: self, options: nil),
           let view = nib.first as? UIView {
            stampBrand = view
            stampBrand.frame = bounds
            stampBrand.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(stampBrand)
            
            setupUI()
        } else {
            print("Failed to load StampBrand XIB")
        }
    }
    
    private func setupUI() {
        stampBrand.backgroundColor = .white
        stampBrand.layer.cornerRadius = 8
        stampBrand.layer.borderWidth = if isActive {
            1.5
        } else {
            1
        }
        stampBrand.layer.borderColor = if isActive {
            UIColor.blue30.cgColor
        } else {
            UIColor.grey30.cgColor
        }
        
        lblTotalStamp.font = Font.B1.Medium.font
        lblTotalStamp.text = "32"
        lblTotalStamp.textColor = UIColor.blue30
        
        lblStamp.font = Font.B4.Small.font
        lblStamp.text = "Stamp"
        lblStamp.textColor = UIColor.blue30
        
        ivBrand.contentMode = .scaleAspectFit
    }
    
    private func updateAppearance() {
        stampBrand.layer.borderWidth = if isSelectedState {
            1.5
        } else {
            1
        }
        
        stampBrand.layer.borderColor = if isSelectedState {
            UIColor.blue30.cgColor
        } else {
            UIColor.grey30.cgColor
        }
    }
    
    public func loadBrand(
        brandImage: UIImage?,
        totalStamps: String
    ) {
        ivBrand.image = brandImage
        lblTotalStamp.text = totalStamps
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public func calculateHeight(for width: CGFloat) -> CGFloat {
        stampBrand.layoutIfNeeded()
        
        let widthConstraint = stampBrand.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        
        let size = stampBrand.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        widthConstraint.isActive = false
        
        return size.height
    }

    public func calculateWidth() -> CGFloat {
        stampBrand.layoutIfNeeded()
        return stampBrand.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    }
    
}
