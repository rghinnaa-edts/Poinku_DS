//
//  TabModel.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 21/01/25.
//

public struct Tab {
    let icon: String
    let title: String
    let badge: String
    
    public init(icon: String, title: String, badge: String = "") {
        self.icon = icon
        self.title = title
        self.badge = badge
    }
}
