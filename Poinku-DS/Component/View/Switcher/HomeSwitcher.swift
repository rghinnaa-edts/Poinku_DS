//
//  HomeSwitcher.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 23/01/25.
//

import UIKit

class HomeSwitcher: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(btnTab)
    }
    
    let btnTab: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let title = UITextView()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.layer.backgroundColor = UIColor.Grey.grey20.cgColor
        return view
    }()
    
}
