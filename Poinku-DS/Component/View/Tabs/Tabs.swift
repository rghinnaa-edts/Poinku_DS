//
//  Tabs.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 09/01/25.
//

import UIKit

public class Tabs: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabStackView: UIStackView!
    @IBOutlet weak var selectedIndicatorView: UIView!
    @IBOutlet weak var bottomRoundedView: UIView!
    @IBOutlet weak var indicatorLeadingConstraint: NSLayoutConstraint!
    
    weak public var delegate: TabsDelegate?
    private var tabs: [Tab] = []
    private var selectedIndex: Int = 0
    private var tabButtons: [UIButton] = []
    private let animationDuration: TimeInterval = 0.3
    
    public enum TabType {
        case cart
        case home
        case category
        case promo
        case homeNew
        case home_new2
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    private func setupFromNib() {
        let nib = UINib(nibName: "Tabs", bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            containerView = view
            setupInitialUI()
        }
    }
    
    private func setupInitialUI() {
        selectedIndicatorView.backgroundColor = .white
        selectedIndicatorView.layer.cornerRadius = 12
        selectedIndicatorView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bottomRoundedView.backgroundColor = .white
        bottomRoundedView.layer.cornerRadius = 28
        updateBottomCorners()
    }
    
    public func configure(with tabs: [Tab], selectedIndex: Int = 0) {
        self.tabs = tabs
        self.selectedIndex = selectedIndex
        setupTabs()
        updateSelectedTab(animated: false)
    }
    
    private func setupTabs() {
        tabStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        tabButtons.removeAll()
        
        for (index, tab) in tabs.enumerated() {
            let button = createTabButton(with: tab, at: index)
            tabStackView.addArrangedSubview(button)
            tabButtons.append(button)
        }
    }
    
    private func createTabButton(with tab: Tab, at index: Int) -> UIButton {
        let button = UIButton()
        button.tag = index
        
        let iconImage = UIImage(named: tab.icon)?.withRenderingMode(.alwaysTemplate)
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = tab.title
        titleLabel.font = UIFont(name: "Arial", size: 16) // Replace with your actual font
        titleLabel.textColor = .blue
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        
        button.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        selectTab(at: sender.tag)
    }
    
    public func selectTab(at index: Int) {
        guard index != selectedIndex else { return }
        selectedIndex = index
        updateSelectedTab(animated: true)
        delegate?.tabSelected(index)
    }
    
    private func updateSelectedTab(animated: Bool) {
        let tabWidth = bounds.width / CGFloat(tabs.count)
        let newLeadingConstraint = tabWidth * CGFloat(selectedIndex)
        
        if animated {
            UIView.animate(withDuration: animationDuration) {
                self.indicatorLeadingConstraint.constant = newLeadingConstraint
                self.layoutIfNeeded()
                self.updateColors()
                self.updateBottomCorners()
            }
        } else {
            indicatorLeadingConstraint.constant = newLeadingConstraint
            updateColors()
            updateBottomCorners()
        }
    }
    
    private func updateColors() {
        tabButtons.enumerated().forEach { index, button in
            let isSelected = index == selectedIndex
            if let stackView = button.subviews.first as? UIStackView,
               let imageView = stackView.arrangedSubviews.first as? UIImageView,
               let label = stackView.arrangedSubviews.last as? UILabel {
                imageView.tintColor = isSelected ? .blue : .white
                label.textColor = isSelected ? .blue : .blue
            }
        }
    }
    
    private func updateBottomCorners() {
        let corners: CACornerMask
        if selectedIndex == 0 {
            corners = [.layerMaxXMinYCorner]
        } else if selectedIndex == tabs.count - 1 {
            corners = [.layerMinXMinYCorner]
        } else {
            corners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        bottomRoundedView.layer.maskedCorners = corners
    }
}

public protocol TabsDelegate: AnyObject {
    func tabSelected(_ index: Int)
}

