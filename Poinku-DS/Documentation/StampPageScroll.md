# Stamp Page Scroll Behavior
The `Stamp Page Scroll Behavior` is a scroll behavior of position the chip bucket and the product.

## Features
-  Auto centered chip bucket when clicked
-  Auto selected and centered chip bucket when product is scrolling
-  Auto scroll to selected bucket where product refer to

## Preview
![Stamp Page Scroll Behavior Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_200/v1741579637/scroll_k4vug5.gif)

## Methods
- `selectDefaultChipBucket()`
- `selectChipBucketWithId(_ bucketId: ScenterInView: Bool)`
- `scrollToSelectedProduct(for bucket: ChipBucketModel)`
- `updateBrandSelectionScrollProducts()`

## Installation
To use the `Stamp Page Scroll Behavior`, please follow the `usage` step. 
or you can see full of Example implementation at `Poinku-DS/ViewController/Prototype/StampPage/StampPageViewController.swift`

### Usage
```Stamp Page Scroll Behavior

@IBOutlet var collectionBucket: UICollectionView! //example collection view of chip buckets
@IBOutlet var collectionProduct: UICollectionView! //exampe collection view of products

var products: [Product] = [] //example product list
var bucket: [ChipBucket] = [] //example chip bucket list
var currentlySelectedBucketId: String? = nil //selected bucket id
var isUserSelectingBucket: Bool = false //for fix glitch and difference between clicked bucket and scrolled product

Class StampPage: UIViewController {

// your other code

// configuration of selected default chip bucket
func selectDefaultChipBucket() {
  guard !bucket.isEmpty else { return }
        
  let defaultSelectedIndexPath = IndexPath(item: 0, section: 0)
  currentlySelectedBucketId = bucket[0].id
        
  if let cell = collectionBucket.cellForItem(at: defaultSelectedIndexPath) as? StampBrand {
    for index in 0..<bucket.count {
        let indexPath = IndexPath(item: index, section: 0)
        if let otherCell = collectionBucket.cellForItem(at: indexPath) as? StampBrand {
          otherCell.isSelectedState = false
        }
    }
              
    cell.isSelectedState = true //isSelectedState is variable in your ChipBucket class to update UI of ChipBucket
  }


// configuration of selected chip bucket
func selectChipBucketWithId(_ bucketId: String, centerInView: Bool = true) {
  if currentlySelectedBucketId == bucketId {
    return
  }
        
  currentlySelectedBucketId = bucketId

  if let bucketIndex = bucket.firstIndex(where: { $0.id == bucketId }) {
    let bucketIndexPath = IndexPath(item: bucketIndex, section: 0)
            
    for index in 0..<bucket.count {
      let indexPath = IndexPath(item: index, section: 0)
      if let cell = collectionBucket.cellForItem(at: indexPath) as? StampBrand {
        cell.isSelectedState = (index == bucketIndex)
      }
    }
            
    if centerInView && !isUserSelectingBrand {
        if let flowLayout = collectionBucket.collectionViewLayout as? UICollectionViewFlowLayout {
          let cellFrame = flowLayout.layoutAttributesForItem(at: bucketIndexPath)?.frame ?? .zero
          let contentOffsetX = cellFrame.midX - (collectionBucket.bounds.width / 2)
          let adjustedOffsetX = max(0, min(contentOffsetX,
                                    collectionBucket.contentSize.width - collectionBucket.bounds.width))
          collectionBucket.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: true)
        }
      }
    }
  }

}

extension StampPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

// your other code

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == collectionBucket {

      //your other code
      
      cell.isSelectedState = (bucket.id == currentlySelectedBucketId) //update chip bucket UI when chip bucket is selected

      //your rest code
    }
    else {
      // your other code
    }
  }

  // configuration for handling selection events in a collection view
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == collectionBucket {
      isUserSelectingBucket = true
            
      for index in 0..<bucket.count {
        let deselectIndexPath = IndexPath(item: index, section: 0)
        if let cell = collectionBucket.cellForItem(at: deselectIndexPath) as? StampBrand {
          cell.isSelectedState = false
        }
      }
            
      if let cell = collectionBucket.cellForItem(at: indexPath) as? StampBrand {
        cell.isSelectedState = true
      }
            
      let selectedBucket = bucket[indexPath.item]
      currentlySelectedBucketId = selectedBucket.id
            
      if let flowLayout = collectionBucket.collectionViewLayout as? UICollectionViewFlowLayout {
        let cellFrame = flowLayout.layoutAttributesForItem(at: indexPath)?.frame ?? .zero 
        let contentOffsetX = cellFrame.midX - (collectionBucket.bounds.width / 2)
        let adjustedOffsetX = max(0, min(contentOffsetX,
                                         collectionBucket.contentSize.width - collectionBucket.bounds.width))
                
        collectionBucket.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: true)
      }
        
      scrollToSelectedProduct(for: selectedBucket)

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
         self.isUserSelectingBucket = false
      }
    }
    else {
      _ = products[indexPath.item]
      // your rest code
    }
  }


  //function is called whenever any scroll view in the app is scrolled
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //It specifically checks if the scroll is happening in the collectionProduct view AND the user is not actively selecting a bucket
    if scrollView == collectionProduct && !isUserSelectingBucket {
      //If both conditions are true, it will update the selected category based on what products are currently visible
      updateBrandSelectionScrollProducts()
    }
  }

  //function scrolls the product collection to show products related to a selected bucket/category
  private func scrollToSelectedProduct(for bucket: ChipBucket) {
    if let firstMatchingProductIndex = products.firstIndex(where: { $0.id == bucket.id }) {
      let firstProductIndexPath = IndexPath(item: firstMatchingProductIndex, section: 0)
            
      DispatchQueue.main.async {
        self.collectionProduct.scrollToItem(at: firstProductIndexPath, at: .top, animated: true)
      }
    } else {
      DispatchQueue.main.async {
        self.collectionProduct.setContentOffset(.zero, animated: true)
      }
    }
  }

  //function determines which bucket/category should be selected based on which products are currently visible on screen
  private func updateBrandSelectionScrollProducts() {
    guard let visibleCells = collectionProduct.visibleCells as? [StampBrandProduct],
    !visibleCells.isEmpty else {
      return
    }
        
    let cell = visibleCells.sorted { (cell1, cell2) -> Bool in
      let cellFrame1 = collectionProduct.convert(cell1.frame, to: collectionProduct.superview)
      let cellFrame2 = collectionProduct.convert(cell2.frame, to: collectionProduct.superview)
        return cellFrame1.origin.y < cellFrame2.origin.y
      }
        
      if let topCell = cell.first,
        let indexPath = collectionProduct.indexPath(for: topCell) {
          let topProduct = products[indexPath.item]
            
          if let matchingBrand = bucket.first(where: { $0.id == topProduct.id }) {
            selectChipBucketWithId(matchingBrand.id, centerInView: true)
          }
      }
  }

}


```

* * *

For further customization or to extend this scroll behavior, you can ask UX Engineer or Inherit the `Stamp Page Scroll Behavior` and override its methods or add additional functionality as required.
