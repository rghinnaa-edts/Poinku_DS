//
//  ExtensionUIColor.swift
//  KlikIDM_DS
//
//  Created by Rizka Ghinna Auliya on 29/07/25.
//

import UIKit

extension UIColor {
    
    // Neutral
    
    static var white: UIColor {
        return UIColor(named: "White") ?? UIColor.white
    }
    
    static var black: UIColor {
        return UIColor(named: "Black") ?? UIColor.white
    }
    
    
    // Grey
    
    static var grey10: UIColor {
        return UIColor(named: "10Grey") ?? UIColor.gray
    }
    
    static var grey20: UIColor {
        return UIColor(named: "20Grey") ?? UIColor.gray
    }
    
    static var grey30: UIColor {
        return UIColor(named: "30Grey") ?? UIColor.gray
    }
    
    static var grey40: UIColor {
        return UIColor(named: "40Grey") ?? UIColor.gray
    }
    
    static var grey50: UIColor {
        return UIColor(named: "50Grey") ?? UIColor.gray
    }
    
    static var grey60: UIColor {
        return UIColor(named: "60Grey") ?? UIColor.gray
    }
    
    static var grey70: UIColor {
        return UIColor(named: "70Grey") ?? UIColor.gray
    }
    
    static var grey80: UIColor {
        return UIColor(named: "80Grey") ?? UIColor.gray
    }
    
    
    // Blue
    
    static var blue10: UIColor {
        return UIColor(named: "10Blue") ?? UIColor.blue
    }
    
    static var blue20: UIColor {
        return UIColor(named: "20Blue") ?? UIColor.blue
    }
    
    static var blue30: UIColor {
        return UIColor(named: "30Blue") ?? UIColor.blue
    }
    
    static var blue40: UIColor {
        return UIColor(named: "40Blue") ?? UIColor.blue
    }
    
    static var blue50: UIColor {
        return UIColor(named: "50Blue") ?? UIColor.blue
    }
    
    
    // Yellow
    
    static var yellow10: UIColor {
        return UIColor(named: "10Yellow") ?? UIColor.yellow
    }
    
    static var yellow20: UIColor {
        return UIColor(named: "20Yellow") ?? UIColor.yellow
    }
    
    static var yellow30: UIColor {
        return UIColor(named: "30Yellow") ?? UIColor.yellow
    }
    
    static var yellow40: UIColor {
        return UIColor(named: "40Yellow") ?? UIColor.yellow
    }
    
    static var yellow50: UIColor {
        return UIColor(named: "50Yellow") ?? UIColor.yellow
    }
    
    
    // Red
    
    static var red10: UIColor {
        return UIColor(named: "10Red") ?? UIColor.red
    }
    
    static var red20: UIColor {
        return UIColor(named: "20Red") ?? UIColor.red
    }
    
    static var red30: UIColor {
        return UIColor(named: "30Red") ?? UIColor.red
    }
    
    static var red40: UIColor {
        return UIColor(named: "40Red") ?? UIColor.red
    }
    
    static var red50: UIColor {
        return UIColor(named: "50Red") ?? UIColor.red
    }
    
    
    // Green
    
    static var green10: UIColor {
        return UIColor(named: "10Green") ?? UIColor.green
    }
    
    static var green20: UIColor {
        return UIColor(named: "20Green") ?? UIColor.green
    }
    
    static var green30: UIColor {
        return UIColor(named: "30Green") ?? UIColor.green
    }
    
    static var green40: UIColor {
        return UIColor(named: "40Green") ?? UIColor.green
    }
    
    static var green50: UIColor {
        return UIColor(named: "50Green") ?? UIColor.green
    }
    
    
    // Orange
    
    static var orange10: UIColor {
        return UIColor(named: "10Orange") ?? UIColor.orange
    }
    
    static var orange20: UIColor {
        return UIColor(named: "20Orange") ?? UIColor.orange
    }
    
    static var orange30: UIColor {
        return UIColor(named: "30Orange") ?? UIColor.orange
    }
    
    static var orange40: UIColor {
        return UIColor(named: "40Orange") ?? UIColor.orange
    }
    
    static var orange50: UIColor {
        return UIColor(named: "50Orange") ?? UIColor.orange
    }
    
    
    // Button
    
    static var blueDefault: UIColor {
        return UIColor(named: "DefaultBlue") ?? UIColor.blue
    }
    
    static var bluePressed: UIColor {
        return UIColor(named: "PressedBlue") ?? UIColor.blue
    }
    
    static var greyDefault: UIColor {
        return UIColor(named: "DefaultGrey") ?? UIColor.gray
    }
    
    static var greyPressed: UIColor {
        return UIColor(named: "PressedGrey") ?? UIColor.gray
    }
    
    static var greyText: UIColor {
        return UIColor(named: "TextGrey") ?? UIColor.gray
    }
    
    static var cartDefault: UIColor {
        return UIColor(named: "DefaultCart") ?? UIColor.orange
    }
    
    static var cartPressed: UIColor {
        return UIColor(named: "PressedCart") ?? UIColor.orange
    }
    
    static var disabled: UIColor {
        return UIColor(named: "Disable") ?? UIColor.gray
    }
    
    struct Support {
        static let errorStrong = UIColor(named: "Error-Strong")
        static let errorWeak = UIColor(named: "Error-Weak")
        static let successStrong = UIColor(named: "Success -Strong")
        static let successWeak = UIColor(named: "Success-Weak")
        static let warningStrong = UIColor(named: "Warning-Strong")
        static let warningWeak = UIColor(named: "Warning-Weak")
    }
    
    struct Brand {
        static let xtra = UIColor(named: "Xtra")
        static let xpress = UIColor(named: "Xpress")
    }
    
    struct Gradient {
        static let sunset = UIKitGradient(
            colors: [
                UIColor(named: "Sunset-Leading") ?? .systemOrange,
                UIColor(named: "Sunset-Trailing") ?? .systemRed
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        static let skyblue = UIKitGradient(
            colors: [
                UIColor(named: "Skyblue-Leading") ?? .systemBlue,
                UIColor(named: "Skyblue-Trailing") ?? .systemTeal
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        static let greenforest = UIKitGradient(
            colors: [
                UIColor(named: "Greenforest-Leading") ?? .systemGreen,
                UIColor(named: "Greenforest-Trailing") ?? .systemGreen
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        static let sunflower = UIKitGradient(
            colors: [
                UIColor(named: "Sunflower-Leading") ?? .systemYellow,
                UIColor(named: "Sunflower-Trailing") ?? .systemOrange
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    struct UIKitGradient {
        let colors: [UIColor]
        let startPoint: GradientPoint
        let endPoint: GradientPoint
        
        enum GradientPoint {
            case leading, trailing, top, bottom
            case topLeading, topTrailing, bottomLeading, bottomTrailing
            case center
            case custom(x: CGFloat, y: CGFloat)
            
            var cgPoint: CGPoint {
                switch self {
                case .leading:
                    return CGPoint(x: 0, y: 0.5)
                case .trailing:
                    return CGPoint(x: 1, y: 0.5)
                case .top:
                    return CGPoint(x: 0.5, y: 0)
                case .bottom:
                    return CGPoint(x: 0.5, y: 1)
                case .topLeading:
                    return CGPoint(x: 0, y: 0)
                case .topTrailing:
                    return CGPoint(x: 1, y: 0)
                case .bottomLeading:
                    return CGPoint(x: 0, y: 1)
                case .bottomTrailing:
                    return CGPoint(x: 1, y: 1)
                case .center:
                    return CGPoint(x: 0.5, y: 0.5)
                case .custom(let x, let y):
                    return CGPoint(x: x, y: y)
                }
            }
        }
    }
}
