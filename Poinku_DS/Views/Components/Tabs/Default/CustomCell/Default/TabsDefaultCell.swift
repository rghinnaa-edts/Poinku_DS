//
//  TabsDefaultCell.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 16/05/25.
//

import UIKit

public class TabsDefaultCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var lblTab: UILabel!
    @IBOutlet var vIndicator: UIView!
    @IBOutlet var ivIcon: UIImageView!
    
    private var lblTabLeadingToIcon: NSLayoutConstraint?
    private var lblTabLeadingToSuperview: NSLayoutConstraint?
    
    public var isSelectedState: Bool = false {
        didSet {
            setupBackground()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTab()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTab()
    }
    
    public func loadData(_ data: TabsDefaultModel) {
        lblTab.text = data.title
        
        let hasIcon = !(data.icon == nil)
                
        if hasIcon {
            ivIcon.isHidden = false
            ivIcon.image = data.icon?.withRenderingMode(.alwaysTemplate)
        } else {
            ivIcon.isHidden = true
        }
        
        updateLabelConstraints(hasIcon: hasIcon)
    }
    
    private func setupTab() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("TabsDefaultCell", owner: self, options: nil),
           let view = nib.first as? UIView {
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        } else {
            print("Failed to load TabsDefaultCell nib")
        }
        
        setupUI()
    }
    
    private func setupUI() {
        setupBackground()
    }
    
    private func setupBackground() {
        vIndicator.isHidden = !isSelectedState
        
        if isSelectedState {
            lblTab.textColor = UIColor.blue30
            ivIcon.tintColor = UIColor.blue30
        } else {
            lblTab.textColor = UIColor.grey40
            ivIcon.tintColor = UIColor.grey40
        }
    }
    
    private func setupConstraints() {
        lblTab.translatesAutoresizingMaskIntoConstraints = false
        
        lblTabLeadingToIcon = lblTab.leadingAnchor.constraint(equalTo: ivIcon.trailingAnchor, constant: 8)
        lblTabLeadingToSuperview = lblTab.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        
        lblTabLeadingToIcon?.priority = UILayoutPriority(999)
        lblTabLeadingToSuperview?.priority = UILayoutPriority(999)
    }
    
    private func updateLabelConstraints(hasIcon: Bool) {
        lblTabLeadingToIcon?.isActive = false
        lblTabLeadingToSuperview?.isActive = false
        
        if hasIcon {
            lblTabLeadingToIcon?.isActive = true
        } else {
            lblTabLeadingToSuperview?.isActive = true
        }
    }
    
}

extension TabsDefaultCell: TabsDefaultCellProtocol {
    public func loadData(item: TabsDefaultModelProtocol) {
        if let data = item as? TabsDefaultModel {
            loadData(data)
        } else {
            let data = TabsDefaultModel(
                id: item.id,
                title: "",
                icon: nil,
            )
            loadData(data)
        }
    }
}
