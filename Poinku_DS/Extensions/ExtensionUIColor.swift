//
//  ExtensionUIColor.swift
//  KlikIDM_DS
//
//  Created by Rizka Ghinna Auliya on 29/07/25.
//

import UIKit

public extension UIColor {
    
    // Neutral
    
    static var white: UIColor {
        return UIColor(hex: "#FFFFFF") ?? UIColor.blue
    }
    
    static var black: UIColor {
        return UIColor(hex: "#000000") ?? UIColor.blue
    }
    
    
    // Grey
    
    static var grey10: UIColor {
        return UIColor(hex: "#F8FBFC") ?? UIColor.gray
    }
    
    static var grey20: UIColor {
        return UIColor(hex: "#EFF3F6") ?? UIColor.gray
    }
    
    static var grey30: UIColor {
        return UIColor(hex: "#DCDEE3") ?? UIColor.gray
    }
    
    static var grey40: UIColor {
        return UIColor(hex: "#C3C7CF") ?? UIColor.gray
    }
    
    static var grey50: UIColor {
        return UIColor(hex: "#9C9DA6") ?? UIColor.gray
    }
    
    static var grey60: UIColor {
        return UIColor(hex: "#70727D") ?? UIColor.gray
    }
    
    static var grey70: UIColor {
        return UIColor(hex: "#434755") ?? UIColor.gray
    }
    
    static var grey80: UIColor {
        return UIColor(hex: "#151823") ?? UIColor.gray
    }
    
    
    // Blue
    
    static var blue10: UIColor {
        return UIColor(hex: "#6CA5E0") ?? UIColor.blue
    }
    
    static var blue20: UIColor {
        return UIColor(hex: "#368BE2") ?? UIColor.blue
    }
    
    static var blue30: UIColor {
        return UIColor(hex: "#1178D4") ?? UIColor.blue
    }
    
    static var blue40: UIColor {
        return UIColor(hex: "#0958AA") ?? UIColor.blue
    }
    
    static var blue50: UIColor {
        return UIColor(hex: "#044B95") ?? UIColor.blue
    }
    
    
    // Yellow
    
    static var yellow10: UIColor? {
        return UIColor(hex: "#FEF9D3") ?? UIColor.yellow
    }
    
    static var yellow20: UIColor {
        return UIColor(hex: "#FDE67B") ?? UIColor.yellow
    }
    
    static var yellow30: UIColor {
        return UIColor(hex: "#F9CA24") ?? UIColor.yellow
    }
    
    static var yellow40: UIColor {
        return UIColor(hex: "#D6A81A") ?? UIColor.yellow
    }
    
    static var yellow50: UIColor {
        return UIColor(hex: "#B38812") ?? UIColor.yellow
    }
    
    
    // Red
    
    static var red10: UIColor {
        return UIColor(hex: "#FFEDEE") ?? UIColor.red
    }
    
    static var red20: UIColor {
        return UIColor(hex: "#FD474A") ?? UIColor.red
    }
    
    static var red30: UIColor {
        return UIColor(hex: "#EE2B2E") ?? UIColor.red
    }
    
    static var red40: UIColor {
        return UIColor(hex: "#DC1013") ?? UIColor.red
    }
    
    static var red50: UIColor {
        return UIColor(hex: "#BB0000") ?? UIColor.red
    }
    
    
    // Green
    
    static var green10: UIColor {
        return UIColor(hex: "#EBFFD0") ?? UIColor.green
    }
    
    static var green20: UIColor {
        return UIColor(hex: "#CEEE8E") ?? UIColor.green
    }
    
    static var green30: UIColor {
        return UIColor(hex: "#8FC742") ?? UIColor.green
    }
    
    static var green40: UIColor {
        return UIColor(hex: "#72AB30") ?? UIColor.green
    }
    
    static var green50: UIColor {
        return UIColor(hex: "#578F21") ?? UIColor.green
    }
    
    
    // Orange
    
    static var orange10: UIColor {
        return UIColor(hex: "#EEC787") ?? UIColor.orange
    }
    
    static var orange20: UIColor {
        return UIColor(hex: "#F0AF42") ?? UIColor.orange
    }
    
    static var orange30: UIColor {
        return UIColor(hex: "#F29D0D") ?? UIColor.orange
    }
    
    static var orange40: UIColor {
        return UIColor(hex: "#DA8D0B") ?? UIColor.orange
    }
    
    static var orange50: UIColor {
        return UIColor(hex: "#CC8000") ?? UIColor.orange
    }
    
    
    // Button
    
    static var blueDefault: UIColor {
        return UIColor(hex: "#1178D4") ?? UIColor.blue
    }
    
    static var bluePressed: UIColor {
        return UIColor(hex: "#0958AA") ?? UIColor.blue
    }
    
    static var greyDefault: UIColor {
        return UIColor(hex: "#DCDEE3") ?? UIColor.gray
    }
    
    static var greyPressed: UIColor {
        return UIColor(hex: "#9C9DA6") ?? UIColor.gray
    }
    
    static var greyText: UIColor {
        return UIColor(hex: "#434755") ?? UIColor.gray
    }
    
    static var cartDefault: UIColor {
        return UIColor(hex: "#F9CA24") ?? UIColor.orange
    }
    
    static var cartPressed: UIColor {
        return UIColor(hex: "#D6A81A") ?? UIColor.orange
    }
    
    static var disabled: UIColor {
        return UIColor(hex: "#DCDEE3") ?? UIColor.gray
    }
    
    static var errorStrong: UIColor {
        return UIColor(hex: "#EE2B2E") ?? UIColor.red
    }
    
    static var errorWeak: UIColor {
        return UIColor(hex: "#FFEDEE") ?? UIColor.red
    }
    
    static var successStrong: UIColor {
        return UIColor(hex: "#8FC742") ?? UIColor.green
    }
    
    static var successWeak: UIColor {
        return UIColor(hex: "#EBFFD0") ?? UIColor.green
    }
    
    static var warningStrong: UIColor {
        return UIColor(hex: "#FF7D1D") ?? UIColor.yellow
    }
    
    static var warningWeak: UIColor {
        return UIColor(hex: "#FFF0E6") ?? UIColor.yellow
    }
    
    static var highlightStrong: UIColor {
        return UIColor(hex: "#F29D0D") ?? UIColor.orange
    }
    
    static var highlightWeak: UIColor {
        return UIColor(hex: "#FEFBF5") ?? UIColor.orange
    }
    
    static var primaryHighlightStrong: UIColor {
        return UIColor(hex: "#1178D4") ?? UIColor.blue
    }
    
    static var primaryHighlightWeak: UIColor? {
        return UIColor(hex: "#E7F1FD") ?? UIColor.blue
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
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        let length = hexSanitized.count
        let r, g, b, a: CGFloat
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
