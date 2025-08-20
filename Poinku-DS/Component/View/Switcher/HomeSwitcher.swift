//
//  HomeSwitcher.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 23/01/25.
//

import UIKit

public class HomeSwitcher: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews() {
        self.addSubview(btnTab)
    }
    
    public let btnTab: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let title = UITextView()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.layer.backgroundColor = UIColor.grey20.cgColor
        return view
    }()
    
}
