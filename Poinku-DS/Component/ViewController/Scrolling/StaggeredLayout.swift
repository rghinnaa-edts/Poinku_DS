//
//  StraggeredLayout.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 10/02/25.
//

import UIKit

protocol StaggeredLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat
}

class StaggeredLayout: UICollectionViewFlowLayout {
    private let numberOfColumns: Int = 2
    private var contentHeight: CGFloat = 0
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
    private var columnHeights: [CGFloat] = []
    private var cachedHeights = [IndexPath: CGFloat]()
    
    private let interColumnSpacing: CGFloat = 16
    
    weak var delegate: StaggeredLayoutDelegate?
    
    private func getHeightForCell(at indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let cacheKey = IndexPath(item: indexPath.item, section: indexPath.section)
        
        if let cachedHeight = cachedHeights[cacheKey] {
            return cachedHeight
        }
        
        if let delegate = delegate {
            let height = delegate.collectionView(collectionView!, heightForItemAt: indexPath, width: width)
            cachedHeights[cacheKey] = height
            return height
        }
        
        return 270
    }
    
    override func prepare() {
        super.prepare()
        
        sectionInset.left = 16
        sectionInset.right = 16
        
        guard let collectionView = collectionView else { return }
        
        cachedAttributes.removeAll()
        columnHeights = Array(repeating: 0, count: numberOfColumns)
        contentHeight = 0
        
        let contentWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right
        let totalSpacing = interColumnSpacing * CGFloat(numberOfColumns - 1)
        let columnWidth = (contentWidth - totalSpacing) / CGFloat(numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let columnIndex = columnHeights.firstIndex(of: columnHeights.min() ?? 0) ?? 0
            
            let xOffset = sectionInset.left + (CGFloat(columnIndex) * (columnWidth + interColumnSpacing))
            let yOffset = columnHeights[columnIndex]
            
            let itemHeight = getHeightForCell(at: indexPath, width: columnWidth)
            
            let frame = CGRect(x: xOffset,
                             y: yOffset,
                             width: columnWidth,
                             height: itemHeight)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            
            cachedAttributes.append(attributes)
            
            columnHeights[columnIndex] = frame.maxY + minimumLineSpacing
            contentHeight = max(contentHeight, frame.maxY)
        }
    }
        
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight + sectionInset.bottom)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.item < cachedAttributes.count else { return nil }
        return cachedAttributes[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return collectionView.bounds.width != newBounds.width
    }
}
