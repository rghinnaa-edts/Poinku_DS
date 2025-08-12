//
//  CouponCardCell.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 10/02/25.
//

import UIKit

class CouponCardCell: UICollectionViewCell {
    
    @IBOutlet var couponCard: UIView!
    @IBOutlet var ivCouponCard: UIImageView!
    @IBOutlet var vAvailable: UIView!
    @IBOutlet var lblAvailable: UILabel!
    @IBOutlet var ivAvailable: UIImageView!
    @IBOutlet var lblCouponCard: UILabel!
    @IBOutlet var vIKupon: UIView!
    @IBOutlet var ivIKupon: UIImageView!
    @IBOutlet var lblIKupon: UILabel!
    @IBOutlet var btnExchange: UIButton!
    
    var id: String = ""
    var title: String = ""
    var imageURL: String = ""
    var coupon: Int = 0
    var stampCount: Int = 0
    var price: Int = 0
    var isNew: Bool = false
    var isHotProduct: Bool = false
    var isDiscount: Bool = false
    var discountImp: Int = 0
    var size: Size = .fullSize
    
    enum Size {
        case fullSize
        case rewardWidget
        case stampPage
    }
    
    struct Product {
        let id: String
        let title: String
        let imageURL: String
        let coupon: Int
        let stampCount: Int
        let price: Int
        let isNew: Bool
        let isHotProduct: Bool
        let isDiscount: Bool
        let discountImp: Int
        let Size: Size
    }
    
    func configure(with product: Product) {
        id = product.id
        title = product.title
        imageURL = product.imageURL
        coupon = product.coupon
        stampCount = product.stampCount
        price = product.price
        isNew = product.isNew
        isHotProduct = product.isHotProduct
        isDiscount = product.isDiscount
        discountImp = product.discountImp
        size = product.Size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCouponCard()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCouponCard()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupCouponCard() {
        if let nib = Bundle.main.loadNibNamed("CouponCard", owner: self, options: nil),
           let card = nib.first as? UIView {
            couponCard = card
            couponCard.frame = contentView.bounds
            couponCard.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.addSubview(couponCard)
            
            setupUI()
        } else {
            print("Failed to load CouponCard XIB")
        }
    }
    
    private func setupUI() {
        UIStampCard()
        UIAvailable()
        UIikupon()
        UIRibbonHotProduct()
    }
    
    private func UIStampCard() {
        couponCard.layer.cornerRadius = 8
        couponCard.layer.masksToBounds = true
        
        couponCard.backgroundColor = .white
        couponCard.layer.shadowColor = UIColor.black.cgColor
        couponCard.layer.shadowOpacity = 0.15
        couponCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        couponCard.layer.shadowRadius = 3.0
        couponCard.layer.masksToBounds = false
        
        lblCouponCard.textColor = UIColor.grey70
        lblCouponCard.font = Font.Body.B3.Small.font
        
        btnExchange.backgroundColor = UIColor.blue30
        btnExchange.layer.cornerRadius = 4
        btnExchange.titleLabel?.textColor = .white
        btnExchange.titleLabel?.font = Font.Button.Small.font
        
        lblCouponCard.text = "Diskon Rp2.000 Lifebuoy Red Fresh"
        ivCouponCard.image = UIImage(named: "placeholder")
    }
    
    private func UIAvailable() {
        ivAvailable.image = if coupon < 10 && coupon > 0 {
            UIImage(named: "exclamation")
        } else {
            UIImage(named: "product-empty")
        }
        ivAvailable.image = ivAvailable.image?.withRenderingMode(.alwaysTemplate)
        
        ivAvailable.tintColor = if coupon < 10 && coupon > 0 {
            UIColor.warningStrong
        } else {
            UIColor.errorStrong
        }
        
        vAvailable.backgroundColor = if coupon < 10 && coupon > 0 {
            UIColor.warningWeak
        } else {
            UIColor.errorWeak
        }
        
        lblAvailable.textColor = if coupon < 10 && coupon > 0 {
            UIColor.warningStrong
        } else {
            UIColor.errorStrong
        }
        
        lblAvailable.text = if coupon < 10 && coupon > 0 {
            "Kupon Mau Habis"
        } else {
            "Kupon Habis"
        }
        lblAvailable.font = Font.B4.Small.font
    }
    
    private func UIikupon() {
        ivIKupon.image = UIImage(named: "store-01")
        ivIKupon.image = ivIKupon.image?.withRenderingMode(.alwaysTemplate)
        ivIKupon.tintColor = UIColor.primaryHighlightStrong
        
        vIKupon.backgroundColor = UIColor.primaryHighlightWeak
        vIKupon.layer.cornerRadius = 8
        vIKupon.layer.borderWidth = 1
        vIKupon.layer.borderColor = UIColor.primaryHighlightStrong.cgColor
        
        lblIKupon.textColor = UIColor.primaryHighlightStrong
        lblIKupon.font = Font.B4.Small.font
        lblIKupon.text = "i-Kupon"
    }
    
    private func UIRibbonHotProduct() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "Hot Product!"
        ribbonView.triangleColor = UIColor.red50
        ribbonView.containerStartColor = UIColor.red20
        ribbonView.containerEndColor = UIColor.red50
        ribbonView.textColor = .white
        ribbonView.gravity = .start

        ribbonView.anchorToView(
            rootParent: couponCard,
            targetView: couponCard
        )
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
        let widthConstraint = couponCard.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        
        let size = couponCard.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        widthConstraint.isActive = false
        
        return size.height
    }
}
