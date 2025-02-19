//
//  StampCardCell.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 10/02/25.
//

import UIKit

class StampCardCell: UICollectionViewCell {
    
    @IBOutlet var stampCard: UIView!
    @IBOutlet var ivStampCard: UIImageView!
    @IBOutlet var vCoupon: UIView!
    @IBOutlet var lblCoupon: UILabel!
    @IBOutlet var ivCoupon: UIImageView!
    @IBOutlet var lblStampCard: UILabel!
    @IBOutlet var vStamp: UIView!
    @IBOutlet var lblStamp: UILabel!
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
        setupStampCard()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStampCard()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupStampCard() {
        if let nib = Bundle.main.loadNibNamed("StampCard", owner: self, options: nil),
           let card = nib.first as? UIView {
            stampCard = card
            stampCard.frame = contentView.bounds
            stampCard.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.addSubview(stampCard)
            
            setupUI()
        } else {
            print("Failed to load StampCard XIB")
        }
    }
    
    private func setupUI() {
        UIStampCard()
        UICoupon()
        UIStamp()
        UIRibbonHotProduct()
        UIRibbonNew()
    }
    
    private func UIStampCard() {
        stampCard.layer.cornerRadius = 8
        stampCard.layer.masksToBounds = true
        
        stampCard.backgroundColor = .white
        stampCard.layer.shadowColor = UIColor.blackIDM.cgColor
        stampCard.layer.shadowOpacity = 0.15
        stampCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        stampCard.layer.shadowRadius = 3.0
        stampCard.layer.masksToBounds = false
        
        lblStampCard.textColor = .grey70
        lblStampCard.font = Font.Body.B3.Small.font
        
        btnExchange.backgroundColor = .blue30
        btnExchange.layer.cornerRadius = 4
        btnExchange.titleLabel?.textColor = .white
        btnExchange.titleLabel?.font = Font.Button.Small.font
        
        lblStampCard.text = "Diskon Rp2.000 Lifebuoy Red Fresh"
        ivStampCard.image = UIImage(named: "placeholder")
    }
    
    private func UICoupon() {
        ivCoupon.image = if coupon < 10 && coupon > 0 {
            UIImage(named: "exclamation")
        } else {
            UIImage(named: "product-empty")
        }
        ivCoupon.image = ivCoupon.image?.withRenderingMode(.alwaysTemplate)
        
        ivCoupon.tintColor = if coupon < 10 && coupon > 0 {
            .warningStrong
        } else {
            .errorStrong
        }
        
        vCoupon.backgroundColor = if coupon < 10 && coupon > 0 {
            .warningWeak
        } else {
            .errorWeak
        }
        
        lblCoupon.textColor = if coupon < 10 && coupon > 0 {
            .warningStrong
        } else {
            .errorStrong
        }
        
        lblCoupon.text = if coupon < 10 && coupon > 0 {
            "Kupon Mau Habis"
        } else {
            "Kupon Habis"
        }
        lblCoupon.font = Font.Body.B4.Small.font
    }
    
    private func UIStamp() {
        vStamp.backgroundColor = .highlightWeak
        vStamp.layer.cornerRadius = 8
        vStamp.layer.borderWidth = 1
        vStamp.layer.borderColor = UIColor.warningStrong.cgColor
        
        lblStamp.textColor = .warningStrong
        lblStamp.font = Font.Body.B4.Small.font
        lblStamp.text = "24 Stamp"
    }
    
    private func UIRibbonHotProduct() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "Hot Product!"
        ribbonView.triangleColor = .red50
        ribbonView.containerStartColor = .red20
        ribbonView.containerEndColor = .red50
        ribbonView.textColor = .white
        ribbonView.gravity = .start

        ribbonView.anchorToView(
            rootParent: stampCard,
            targetView: stampCard
        )
    }
    
    private func UIRibbonNew() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "Baru!"
        ribbonView.triangleColor = .orange30
        ribbonView.containerStartColor = .yellow30
        ribbonView.containerEndColor = .orange30
        ribbonView.textColor = .white
        ribbonView.gravity = .end

        ribbonView.anchorToView(
            rootParent: stampCard,
            targetView: vCoupon,
            verticalAlignment: .top,
            offsetX: 21
        )
    }
}
