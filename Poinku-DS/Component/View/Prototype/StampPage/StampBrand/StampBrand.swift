//
//  StampBrand.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 04/03/25.
//

import UIKit

class StampBrand: UICollectionViewCell {
    
    @IBOutlet var stampBrand: UIView!
    @IBOutlet var ivBrand: UIImageView!
    @IBOutlet var lblTotalStamp: UILabel!
    @IBOutlet var lblStamp: UILabel!
    
    var isActive = false
    var isSelectedState: Bool = false {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupStampBrand() {
        if let nib = Bundle.main.loadNibNamed("StampBrand", owner: self, options: nil),
           let card = nib.first as? UIView {
            stampBrand = card
            stampBrand.frame = contentView.bounds
            stampBrand.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.addSubview(stampBrand)
            
            setupUI()
        } else {
            print("Failed to load StampBrand XIB")
        }
    }
    
    private func setupUI() {
        stampBrand.backgroundColor = .white
        stampBrand.layer.cornerRadius = 8
        stampBrand.layer.borderWidth = 1
        stampBrand.layer.borderColor = if isActive {
            UIColor.blue30.cgColor
        } else {
            UIColor.grey30.cgColor
        }
        
        lblTotalStamp.font = Font.Body.B1.Medium.font
        lblTotalStamp.text = "32"
        lblTotalStamp.textColor = .blue30
        
        lblStamp.font = Font.Body.B4.Small.font
        lblStamp.text = "Stamp"
        lblStamp.textColor = .blue30
        
        ivBrand.contentMode = .scaleAspectFit
    }
    
    private func updateAppearance() {
        stampBrand.layer.borderColor = if isSelectedState {
            UIColor.blue30.cgColor
        } else {
            UIColor.grey30.cgColor
        }
    }
    
    func loadBrand(
        brandImage: String,
        totalStamps: String
    ) {
        ivBrand.image = UIImage(named: brandImage)
        lblTotalStamp.text = totalStamps
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
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

    func calculateWidth() -> CGFloat {
        stampBrand.layoutIfNeeded()
        return stampBrand.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    }
    
}
