//
//  Skeleton.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 17/02/25.
//

import UIKit

class SkeletonView: UIView {
    private let gradientLayer = CAGradientLayer()
    private let shimmerAnimation: CABasicAnimation
    
    override init(frame: CGRect) {
        shimmerAnimation = CABasicAnimation(keyPath: "locations")
        shimmerAnimation.fromValue = [-1.0, -0.5, 0.0]
        shimmerAnimation.toValue = [1.0, 1.5, 2.0]
        shimmerAnimation.repeatCount = .infinity
        shimmerAnimation.duration = 1.5
        
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        shimmerAnimation = CABasicAnimation(keyPath: "locations")
        shimmerAnimation.fromValue = [-1.0, -0.5, 0.0]
        shimmerAnimation.toValue = [1.0, 1.5, 2.0]
        shimmerAnimation.repeatCount = .infinity
        shimmerAnimation.duration = 1.5
        
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.Grey.grey20.cgColor,
            UIColor.Grey.grey30.cgColor,
            UIColor.Grey.grey20.cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradientLayer)
        
        gradientLayer.add(shimmerAnimation, forKey: "shimmerAnimation")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func startShimmer() {
        gradientLayer.add(shimmerAnimation, forKey: "shimmerAnimation")
    }
    
    func stopShimmer() {
        gradientLayer.removeAnimation(forKey: "shimmerAnimation")
    }
}
