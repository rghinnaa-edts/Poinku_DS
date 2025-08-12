# Poin Loyalty Animation
The `Poin Loyalty Animation` that transitions from a top widget to sticky position and show/hide the view of list chips is a UI pattern that enhances user experience when displaying loyalty points.

## Preview
![Poin Loyalty Animation Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1753332893/poinloyalty_qpiy4h.gif)

## Installation
To use the `Poin Loyalty Animation`, please follow this step.
- create view of list chips and named the IBOutlet as viewChip
![View Chip Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1753333002/Screenshot_2025-07-24_at_11.56.37_dv9vyr.png)

- create layout of poin loyalty widget and named the IBOutlet as viewPoin
![View Poin Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1744626444/Screenshot_2025-04-14_at_17.27.17_upwtup.png)

- create layout of sticky poin loyalty widget and named the IBOutlet as viewPoinTop
![View Poin Top Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1744626530/Screenshot_2025-04-14_at_17.28.42_nszej4.png)

### Usage
- Add this variable to class
```Example Hide View Poin and View Chip
    private var viewPoinTopConstraints: [NSLayoutConstraint] = []
    
    private var lastScrollOffset: CGFloat = 0
    private var isViewChipVisible = true
```
  
- Add this line of View Poin Top when first open page of Poin Loyalty
```Example Hide View Poin
  viewPoinTopConstraints = viewPoinTop.constraints
        
  NSLayoutConstraint.deactivate(viewPoinTopConstraints)
  viewPoinTop.isHidden = true
```

- Create function scrollDidViewScroll to add behavior of view when scrolling
```Scroll Behavior
  extension PoinLoyaltyPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        let scrollPosition = scrollOffset - lastScrollOffset
        
        setupViewChipVisibility(scrollOffset: scrollOffset, scrollPosition: scrollPosition)
        
        let transitionStart: CGFloat = 0
        let transitionEnd: CGFloat = 100
        
        let progress = max(0, min(1, scrollOffset / transitionEnd))
        
        UIView.animate(withDuration: 0.1) {
            self.viewPoin.alpha = 1 - progress
            self.viewPoinTop.alpha = progress
            
            if scrollOffset > transitionStart {
                self.viewChip.layer.shadowOpacity = 0
            } else {
                self.viewChip.layer.shadowOpacity = 0.15
            }
        }
        
        if scrollOffset <= transitionStart {
            viewPoinTop.isHidden = true
            NSLayoutConstraint.deactivate(viewPoinTopConstraints)
        } else if scrollOffset >= transitionEnd {
            viewPoinTop.isHidden = false
            NSLayoutConstraint.activate(viewPoinTopConstraints)
            
            let chipTransform = viewChip.transform
            let chipY = chipTransform.ty
            
            viewPoinTop.transform = CGAffineTransform(translationX: 0, y: chipY)
        } else {
            viewPoin.isHidden = false
            viewPoinTop.isHidden = false
            NSLayoutConstraint.activate(viewPoinTopConstraints)
            
            let chipTransform = viewChip.transform
            let chipY = chipTransform.ty
            
            let targetY = chipY * progress
            viewPoinTop.transform = CGAffineTransform(translationX: 0, y: targetY)
        }
        
        lastScrollOffset = scrollOffset
    }
    
    private func setupViewChipVisibility(scrollOffset: CGFloat, scrollPosition: CGFloat) {
        let scrollThreshold: CGFloat = 10
        
        guard abs(scrollPosition) > scrollThreshold && scrollOffset > 50 else { return }
        
        if scrollPosition > 0 && isViewChipVisible {
            isViewChipVisible = false
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.viewChip.transform = CGAffineTransform(translationX: 0, y: -self.viewChip.frame.height)
                
                if !self.viewPoinTop.isHidden && self.viewPoinTop.alpha > 0 {
                    self.viewPoinTop.transform = CGAffineTransform(translationX: 0, y: -self.viewChip.frame.height)
                }
                
                self.view.layoutIfNeeded()
            })
        } else if scrollPosition < 0 && !isViewChipVisible {
            isViewChipVisible = true
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.viewChip.transform = .identity
                
                if !self.viewPoinTop.isHidden && self.viewPoinTop.alpha > 0 {
                    let scrollOffset = self.scrollView.contentOffset.y
                    let endOffset: CGFloat = 100
                    
                    if scrollOffset >= endOffset {
                        self.viewPoinTop.transform = .identity
                    } else {
                        let progress = max(0, min(1, scrollOffset / endOffset))
                        let targetY = 0 * progress
                        self.viewPoinTop.transform = CGAffineTransform(translationX: 0, y: targetY)
                    }
                }
                
                self.view.layoutIfNeeded()
            })
        }
    }
}
```
* * *

For further customization or to extend this animation, you can ask UX Engineer or Inherit the `Poin Loyalty Animation` and override its methods or add additional functionality as requi
