//
//  OnBoardingCell.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 25/04/25.
//

import UIKit

public class OnBoardingCell: UICollectionViewCell {
    
    public static let identifier = String(describing: OnBoardingCell.self)
    
    @IBOutlet var ivSlide: UIImageView!
    
    public func setup(_ image: UIImage?) {
        ivSlide.image = image
        ivSlide.contentMode = .scaleAspectFill
    }
}
