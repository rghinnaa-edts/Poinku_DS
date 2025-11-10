//
//  StampBrandProduct.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 04/03/25.
//

import UIKit

public class StampBrandProduct: UICollectionViewCell {
    
    @IBOutlet var stampBrandProduct: UIView!
    @IBOutlet var ivBrand: UIImageView!
    @IBOutlet var lblBrand: UILabel!
    @IBOutlet var lblStamp: UILabel!
    @IBOutlet var lblTotalStamp: UILabel!
    @IBOutlet var lblCoupon: UILabel!
    @IBOutlet var btnSeeAll: UIButton!
    @IBOutlet var collectionStampCard: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStampBrandProduct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStampBrandProduct()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupStampBrandProduct() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("StampBrandProduct", owner: self, options: nil),
           let view = nib.first as? UIView {
            stampBrandProduct = view
            stampBrandProduct.frame = bounds
            stampBrandProduct.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(stampBrandProduct)
            
            setupUI()
        } else {
            print("Failed to load StampBrandProduct XIB")
        }
    }
    
    private func setupUI() {
        stampBrandProduct.layer.cornerRadius = 8
        stampBrandProduct.layer.masksToBounds = true
        
        stampBrandProduct.backgroundColor = .white
        stampBrandProduct.layer.shadowColor = UIColor.grey60.cgColor
        stampBrandProduct.layer.shadowOpacity = 0.15
        stampBrandProduct.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        stampBrandProduct.layer.shadowRadius = 3.0
        stampBrandProduct.layer.masksToBounds = false
        
        ivBrand.layer.cornerRadius = 8
        ivBrand.layer.borderWidth = 1
        ivBrand.layer.borderColor = UIColor.grey30.cgColor
        ivBrand.contentMode = .scaleAspectFit
        ivBrand.clipsToBounds = true
        
        lblBrand.font = Font.H2.font
        lblBrand.textColor = UIColor.grey80
        
        lblStamp.text = "Kamu Punya:"
        lblStamp.font = Font.B3.Small.font
        lblStamp.textColor = UIColor.grey50
        
        lblTotalStamp.text = "80 Stamp"
        lblTotalStamp.font = Font.B3.Large.font
        lblTotalStamp.textColor = UIColor.orange30
        
        lblCoupon.text = "Kupon yang bisa ditukar:"
        lblCoupon.font = Font.B3.Small.font
        lblCoupon.textColor = UIColor.grey80
        
        let attributedSkip = NSAttributedString(string: "Lihat Semua", attributes: [
            .font: Font.B3.Small.font,
            .foregroundColor: UIColor.blue30
        ])
        btnSeeAll.setAttributedTitle(attributedSkip, for: .normal)
        
        setupProductView()
    }
    
    private func setupProductView() {
        let productFlowLayout = UICollectionViewFlowLayout()
        productFlowLayout.scrollDirection = .horizontal
        productFlowLayout.minimumInteritemSpacing = 12
        productFlowLayout.minimumLineSpacing = 12
        productFlowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let cellWidth: CGFloat = 125
        let cellHeight: CGFloat = 180
        
        productFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        collectionStampCard.collectionViewLayout = productFlowLayout
        collectionStampCard.backgroundColor = UIColor.primaryHighlightWeak
        collectionStampCard.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionStampCard.showsHorizontalScrollIndicator = false
        collectionStampCard.alwaysBounceHorizontal = true
        collectionStampCard.decelerationRate = .normal
        collectionStampCard.register(StampCardSmall.self, forCellWithReuseIdentifier: "StampCardSmall")
        
        let totalHeight = cellHeight + productFlowLayout.sectionInset.top + productFlowLayout.sectionInset.bottom
            
        collectionStampCard.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
        
        collectionStampCard.delegate = self
        collectionStampCard.dataSource = self
    }
    
    public func calculateHeight(for width: CGFloat) -> CGFloat {
        let widthConstraint = stampBrandProduct.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        
        let size = stampBrandProduct.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        widthConstraint.isActive = false
        
        return size.height
    }
    
    public func calculateWidth() -> CGFloat {
        return UIScreen.main.bounds.width - 32
    }
    
    public func loadBrandProduct(
        brandName: String,
        brandImage: UIImage?,
        totalStamps: String
    ) {
        lblBrand.text = brandName
        ivBrand.image = brandImage
        lblTotalStamp.text = totalStamps
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}

extension StampBrandProduct: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampCardSmall", for: indexPath) as! StampCardSmall
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = StampCardSmall()
        
        let width = 125
        let height = cell.calculateHeight(for: CGFloat(width))
    
        return CGSize(width: width, height: Int(height))
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
