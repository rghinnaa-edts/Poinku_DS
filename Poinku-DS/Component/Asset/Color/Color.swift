//
//  Color.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 23/01/25.
//

import UIKit

extension UIColor {
    
    struct Neutral {
        static let white = UIColor(named: "White") ?? .white
        static let black = UIColor(named: "Black") ?? .black
    }
    
    struct Grey {
        static let grey10 = UIColor(named: "Grey-10") ?? .gray
        static let grey20 = UIColor(named: "Grey-20") ?? .gray
        static let grey30 = UIColor(named: "Grey-30") ?? .gray
        static let grey40 = UIColor(named: "Grey-40") ?? .gray
        static let grey50 = UIColor(named: "Grey-50") ?? .gray
        static let grey60 = UIColor(named: "Grey-60") ?? .gray
        static let grey70 = UIColor(named: "Grey-70") ?? .gray
        static let grey80 = UIColor(named: "Grey-80") ?? .gray
    }
    
    struct Blue {
        static let blue10 = UIColor(named: "Blue-10") ?? .blue
        static let blue20 = UIColor(named: "Blue-20") ?? .blue
        static let blue30 = UIColor(named: "Blue-30") ?? .blue
        static let blue40 = UIColor(named: "Blue-40") ?? .blue
        static let blue50 = UIColor(named: "Blue-50") ?? .blue
    }
    
    struct Yellow {
        static let yellow10 = UIColor(named: "Yellow-10") ?? .yellow
        static let yellow20 = UIColor(named: "Yellow-20") ?? .yellow
        static let yellow30 = UIColor(named: "Yellow-30") ?? .yellow
        static let yellow40 = UIColor(named: "Yellow-40") ?? .yellow
        static let yellow50 = UIColor(named: "Yellow-50") ?? .yellow
    }
    
    struct Red {
        static let red10 = UIColor(named: "Red-10") ?? .red
        static let red20 = UIColor(named: "Red-20") ?? .red
        static let red30 = UIColor(named: "Red-30") ?? .red
        static let red40 = UIColor(named: "Red-40") ?? .red
        static let red50 = UIColor(named: "Red-50") ?? .red
    }
    
    struct Green {
        static let green10 = UIColor(named: "Green-10") ?? .green
        static let green20 = UIColor(named: "Green-20") ?? .green
        static let green30 = UIColor(named: "Green-30") ?? .green
        static let green40 = UIColor(named: "Green-40") ?? .green
        static let green50 = UIColor(named: "Green-50") ?? .green
    }
    
    struct Orange {
        static let orange10 = UIColor(named: "Orange-10") ?? .orange
        static let orange20 = UIColor(named: "Orange-20") ?? .orange
        static let orange30 = UIColor(named: "Orange-30") ?? .orange
        static let orange40 = UIColor(named: "Orange-40") ?? .orange
        static let orange50 = UIColor(named: "Orange-50") ?? .orange
    }
    
    struct Button {
        static let blueDefault = UIColor(named: "Blue-Default") ?? .blue
        static let bluePressed = UIColor(named: "Blue-Pressed") ?? .blue
        static let greyDefault = UIColor(named: "Grey-Default") ?? .blue
        static let greyPressed = UIColor(named: "Grey-Pressed") ?? .blue
        static let greyText = UIColor(named: "Grey-Text") ?? .blue
        static let cartDefault = UIColor(named: "Cart-Default") ?? .blue
        static let cartPressed = UIColor(named: "Cart-Pressed") ?? .blue
        static let disabled = UIColor(named: "Disabled") ?? .gray
    }
    
    struct Support {
        static let errorStrong = UIColor(named: "Error-Strong") ?? .red
        static let errorWeak = UIColor(named: "Error-Weak") ?? .red
        static let successStrong = UIColor(named: "Success-Strong") ?? .green
        static let successWeak = UIColor(named: "Success-Weak") ?? .green
        static let warningStrong = UIColor(named: "Warning-Strong") ?? .yellow
        static let warningWeak = UIColor(named: "Warning-Weak") ?? .yellow
        static let highlightStrong = UIColor(named: "Highlight-Strong") ?? .yellow
        static let highlightWeak = UIColor(named: "Highlight-Weak") ?? .yellow
        static let primaryHighlightStrong = UIColor(named: "Primary-Highlight-Strong") ?? .blue
        static let primaryHighlightWeak = UIColor(named: "Primary-Highlight-Weak") ?? .blue
    }
    
    struct Gradient {
            static func sunset() -> CAGradientLayer {
                return createGradientLayer(
                    colors: [UIColor(named: "Sunset-Start")!, UIColor(named: "Sunset-End")!]
                )
            }
            
            static func skyblue() -> CAGradientLayer {
                return createGradientLayer(
                    colors: [UIColor(named: "Skyblue-Start")!, UIColor(named: "Skyblue-End")!]
                )
            }
            
            static func greenforest() -> CAGradientLayer {
                return createGradientLayer(
                    colors: [UIColor(named: "Greenforest-Start")!, UIColor(named: "Greenforest-End")!]
                )
            }
            
            static func sunflower() -> CAGradientLayer {
                return createGradientLayer(
                    colors: [UIColor(named: "Sunflower-Start")!, UIColor(named: "Sunflower-End")!]
                )
            }
            
            private static func createGradientLayer(colors: [UIColor]) -> CAGradientLayer {
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = colors.map { $0.cgColor }
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                return gradientLayer
            }
        }
}
