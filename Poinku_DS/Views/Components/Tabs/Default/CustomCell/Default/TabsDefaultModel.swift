//
//  TabsDefaultModel.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 10/05/25.
//

import UIKit

public struct TabsDefaultModel: TabsDefaultModelProtocol {
    public var id: String
    public var title: String
    public var icon: UIImage?
    
    public init(id: String, title: String, icon: UIImage? = nil) {
        self.id = id
        self.title = title
        self.icon = icon
    }
}
