//
//  OnBoarding2Cell.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 23/06/25.
//

import UIKit

public class OnBoarding2Cell: UICollectionViewCell {
    
    @IBOutlet var ivSlide: UIImageView!
    
    public static let identifier = String(describing: OnBoarding2Cell.self)

    public func setup(_ image: UIImage?) {
        ivSlide.image = image
        ivSlide.contentMode = .scaleAspectFill
    }
}
