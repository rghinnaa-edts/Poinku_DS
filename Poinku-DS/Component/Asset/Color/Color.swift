//
//  Color.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 23/01/25.
//

import UIKit

extension UIColor {
    
    struct Neutral {
        static let whiteIDM = UIColor(named: "WhiteIDM")
        static let blackIDM = UIColor(named: "BlackIDM")
    }
    
    struct Grey {
        static let grey10 = UIColor(named: "Grey-10")
        static let grey20 = UIColor(named: "Grey-20")
        static let grey30 = UIColor(named: "Grey-30")
        static let grey40 = UIColor(named: "Grey-40")
        static let grey50 = UIColor(named: "Grey-50")
        static let grey60 = UIColor(named: "Grey-60")
        static let grey70 = UIColor(named: "Grey-70")
    }
    
    struct Blue {
        static let blue10 = UIColor(named: "Blue-10")
        static let blue20 = UIColor(named: "Blue-20")
        static let blue30 = UIColor(named: "Blue-30")
        static let blue40 = UIColor(named: "Blue-40")
        static let blue50 = UIColor(named: "Blue-50")
        static let blue60 = UIColor(named: "Blue-60")
        static let blue70 = UIColor(named: "Blue-70")
        static let blueTab = UIColor(named: "BlueTab")
    }
    
    struct Yellow {
        static let yellow10 = UIColor(named: "Yellow-10")
        static let yellow20 = UIColor(named: "Yellow-20")
        static let yellow30 = UIColor(named: "Yellow-30")
        static let yellow40 = UIColor(named: "Yellow-40")
        static let yellow50 = UIColor(named: "Yellow-50")
    }
    
    struct Red {
        static let red10 = UIColor(named: "Red-10")
        static let red20 = UIColor(named: "Red-20")
        static let red30 = UIColor(named: "Red-30")
        static let red40 = UIColor(named: "Red-40")
        static let red50 = UIColor(named: "Red-50")
    }
    
    struct Green {
        static let green10 = UIColor(named: "Green-10")
        static let green20 = UIColor(named: "Green-20")
        static let green30 = UIColor(named: "Green-30")
        static let green40 = UIColor(named: "Green-40")
        static let green50 = UIColor(named: "Green-50")
    }
    
    struct Orange {
        static let orange10 = UIColor(named: "Orange-10")
        static let orange20 = UIColor(named: "Orange-20")
        static let orange30 = UIColor(named: "Orange-30")
        static let orange40 = UIColor(named: "Orange-40")
        static let orange50 = UIColor(named: "Orange-50")
    }
    
    struct Button {
        static let blueDefault = UIColor(named: "Blue-Default")
        static let bluePressed = UIColor(named: "Blue-Pressed")
        static let greyDefault = UIColor(named: "Grey-Default")
        static let greyPressed = UIColor(named: "Grey-Pressed")
        static let greyText = UIColor(named: "Grey-Text")
        static let cartDefault = UIColor(named: "Cart-Default")
        static let cartPressed = UIColor(named: "Cart-Pressed")
        static let disabled = UIColor(named: "Disabled")
    }
    
    struct Support {
        static let errorStrong = UIColor(named: "Error-Strong")
        static let errorWeak = UIColor(named: "Error-Weak")
        static let successStrong = UIColor(named: "Success-Strong")
        static let successWeak = UIColor(named: "Success-Weak")
        static let warningStrong = UIColor(named: "Warning-Strong")
        static let warningWeak = UIColor(named: "Warning-Weak")
        static let highlightStrong = UIColor(named: "Highlight-Strong")
        static let highlightWeak = UIColor(named: "Highlight-Weak")
    }
    
    struct Brand {
        static let xtra = UIColor(named: "Xtra")
        static let xpress = UIColor(named: "Xpress")
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
