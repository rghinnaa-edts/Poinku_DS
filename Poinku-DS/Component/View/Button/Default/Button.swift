//
//  ButtonIcon.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 24/02/25.
//

import UIKit

enum Style {
    case primary
    case outline
    case text
}

class Button: UIButton {
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private var defaultStyle: Style = .primary
    private var startIcon: UIImage?
    private var endIcon: UIImage?
    private let iconPadding: CGFloat = 8
    private var startImageView: UIImageView?
    private var endImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(style: Style = .primary, title: String, startIcon: UIImage? = nil, endIcon: UIImage? = nil) {
        self.init(frame: .zero)
        self.defaultStyle = style
        self.startIcon = startIcon
        self.endIcon = endIcon
        
        setTitle(title, for: .normal)
        setStyleState(style)
        setupIcons()
    }
    
    private func setup() {
        self.titleLabel?.font = Font.Button.Big.font
        self.layer.cornerRadius = 8
        self.setStyleState(self.defaultStyle)
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupIcons() {
        self.setImage(nil, for: .normal)
        self.semanticContentAttribute = .unspecified
        self.titleEdgeInsets = .zero
        self.imageEdgeInsets = .zero
        
        startImageView?.removeFromSuperview()
        endImageView?.removeFromSuperview()
        startImageView = nil
        endImageView = nil
        
        if startIcon != nil && endIcon != nil {
            setupBothIcons()
        } else if let startIcon = startIcon {
            self.setImage(startIcon, for: .normal)
            self.semanticContentAttribute = .forceLeftToRight
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -iconPadding/2, bottom: 0, right: iconPadding/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: iconPadding/2, bottom: 0, right: -iconPadding/2)
        } else if let endIcon = endIcon {
            self.setImage(endIcon, for: .normal)
            self.semanticContentAttribute = .forceRightToLeft
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: iconPadding/2, bottom: 0, right: -iconPadding/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -iconPadding/2, bottom: 0, right: iconPadding/2)
        }
    }
    
    private func setupBothIcons() {
        guard let startIcon = startIcon, let endIcon = endIcon else { return }
        
        let startImgView = UIImageView(image: startIcon)
        startImgView.contentMode = .scaleAspectFit
        startImgView.translatesAutoresizingMaskIntoConstraints = false
        startImgView.tintColor = self.tintColor
        
        let endImgView = UIImageView(image: endIcon)
        endImgView.contentMode = .scaleAspectFit
        endImgView.translatesAutoresizingMaskIntoConstraints = false
        endImgView.tintColor = self.tintColor
        
        self.startImageView = startImgView
        self.endImageView = endImgView
        
        self.addSubview(startImgView)
        self.addSubview(endImgView)
        
        NSLayoutConstraint.activate([
            startImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            startImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startImgView.widthAnchor.constraint(equalToConstant: 20),
            startImgView.heightAnchor.constraint(equalToConstant: 20),
            
            endImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            endImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            endImgView.widthAnchor.constraint(equalToConstant: 20),
            endImgView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func setIcons(startIcon: UIImage? = nil, endIcon: UIImage? = nil) {
        self.startIcon = startIcon
        self.endIcon = endIcon
        setupIcons()
    }
    
    func setStyleState(_ style: Style) {
        switch style {
        case .outline:
            self.backgroundColor = .white
            self.layer.cornerRadius = 8
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.blue30.cgColor
            self.setTitleColor(UIColor.blue30, for: .normal)
            self.titleLabel?.font = Font.Button.Big.font
            self.tintColor = UIColor.blue30
        case .text:
            self.backgroundColor = .clear
            self.layer.cornerRadius = 0
            self.layer.borderWidth = 0
            self.setTitleColor(UIColor.blue30, for: .normal)
            self.titleLabel?.font = Font.Button.Big.font
            self.tintColor = UIColor.blue30
        default:
            self.backgroundColor = UIColor.blue30
            self.layer.cornerRadius = 8
            self.layer.borderWidth = 0
            self.setTitleColor(.white, for: .normal)
            self.titleLabel?.font = Font.Button.Big.font
            self.tintColor = .white
        }
        
        startImageView?.tintColor = self.tintColor
        endImageView?.tintColor = self.tintColor
    }
    
}
