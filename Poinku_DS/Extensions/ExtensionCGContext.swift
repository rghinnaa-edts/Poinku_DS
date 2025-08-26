//
//  ExtensionCGContext.swift
//  Poinku_DS
//
//  Created by Rizka Ghinna Auliya on 26/08/25.
//

import UIKit

extension CGContext {
    func fillRoundedRect(rect: CGRect, cornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        addPath(path.cgPath)
        fillPath()
    }
}
