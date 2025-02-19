//
//  StraggeredLayout.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 10/02/25.
//

import UIKit

class StaggeredLayout: UICollectionViewFlowLayout {
    private let numberOfColumns: Int = 2
    private var contentHeight: CGFloat = 0
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
    private var columnHeights: [CGFloat] = []
    
    private let interColumnSpacing: CGFloat = 16
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        cachedAttributes.removeAll()
        columnHeights = Array(repeating: 0, count: numberOfColumns)
        contentHeight = 0
        
        let contentWidth = collectionView.bounds.width-12 - sectionInset.left - sectionInset.right
        
        let totalSpacing = interColumnSpacing * CGFloat(numberOfColumns - 1)
        
        let columnWidth = (contentWidth - totalSpacing) / CGFloat(numberOfColumns)
        
        var currentIndex = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let columnIndex = columnHeights.enumerated().min { $0.element < $1.element }?.offset ?? 0
            
            let xOffset = sectionInset.left + (CGFloat(columnIndex) * (columnWidth + interColumnSpacing))
            let yOffset = columnHeights[columnIndex]
            
            let itemHeight: CGFloat = 259
            
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: itemHeight)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            
            cachedAttributes.append(attributes)
            
            columnHeights[columnIndex] = frame.maxY + minimumLineSpacing
            contentHeight = max(contentHeight, frame.maxY)
            
            currentIndex += 1
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
}
