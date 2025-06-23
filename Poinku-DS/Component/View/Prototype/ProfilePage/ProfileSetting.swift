//
//  ProfileSetting.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 02/05/25.
//

import UIKit

class ProfileSetting: UICollectionViewCell {
    
    @IBOutlet var profileSetting: UIView!
    @IBOutlet var ivSetting: UIImageView!
    @IBOutlet var lblSetting: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileSetting()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProfileSetting()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupProfileSetting() {
        if let nib = Bundle.main.loadNibNamed("ProfileSetting", owner: self, options: nil),
           let card = nib.first as? UIView {
            profileSetting = card
            profileSetting.frame = contentView.bounds
            profileSetting.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.addSubview(profileSetting)
            
            setupUI()
        } else {
            print("Failed to load StampBrand XIB")
        }
    }
    
    private func setupUI() {
        lblSetting.font = Font.B2.Small.font
        lblSetting.textColor = UIColor.grey70
    }
    
    func loadProfileSetting(
        icon: String,
        title: String
    ) {
        ivSetting.image = UIImage(named: icon)
        lblSetting.text = title
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
        profileSetting.layoutIfNeeded()
        
        let widthConstraint = profileSetting.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        
        let size = profileSetting.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        widthConstraint.isActive = false
        
        return size.height
    }

    func calculateWidth() -> CGFloat {
        profileSetting.layoutIfNeeded()
        return profileSetting.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    }
    
}
