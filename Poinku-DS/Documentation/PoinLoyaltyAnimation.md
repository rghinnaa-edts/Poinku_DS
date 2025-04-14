# Poin Loyalty Animation
The `Poin Loyalty Animation` that transitions from a top widget to sticky position is a UI pattern that enhances user experience when displaying loyalty points.

## Features
-  Customizable text title, description, spotlight radius, button color
-  Option to adjust the text appearance with a custom style
-  Provides step-by-step coachmark by using Arrays
-  Provides an option to attach/anchor to a specific view in the layout

## Preview
![Coachmark Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1744626828/WhatsAppVideo2025-04-14at16.51.04-ezgif.com-video-to-gif-converter_mgfwym.gif)

## Methods
- `configure(title: String, description: String, targetView: UIView, spotlightRadius: CGFloat, tintColor: UIView)`
- `configureSteps(steps: [Coachmark.StepConfiguration])`
  `Coachmark.StepConfiguration(title: String, description: String, targetView: UIView, spotlightRadius: CGFloat, tintColor: UIView)`

## Installation
To use the `Poin Loyalty Animation`, please follow this step.
- create layout of poin loyalty widget and named the IBOutlet as viewPoin
![View Poin Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1744626444/Screenshot_2025-04-14_at_17.27.17_upwtup.png)

- create layout of sticky poin loyalty widget and named the IBOutlet as viewPoinTop\
![View Poin Top Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1744626530/Screenshot_2025-04-14_at_17.28.42_nszej4.png)

### Usage
- Add this line to View Poin Top when first open page of Poin Loyalty
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
        
        let transitionStartOffset: CGFloat = 0
        let transitionEndOffset: CGFloat = 100
        
        let progress = max(0, min(1, scrollOffset / transitionEndOffset))
        
        UIView.animate(withDuration: 0.1) {
            
            self.viewPoin.alpha = 1 - progress
            self.viewPoinTop.alpha = progress
            self.viewChip.layer.shadowOpacity = 0
            
            let slideTransform = CGAffineTransform(
                translationX: 0,
                y: -self.viewPoinTop.frame.height * (1 - progress)
            )
            
            NSLayoutConstraint.activate(self.viewPoinTopConstraints)
            self.viewPoinTop.transform = slideTransform
        }
        
        if scrollOffset <= transitionStartOffset {
            viewPoinTop.isHidden = true
            NSLayoutConstraint.deactivate(viewPoinTopConstraints)
            
            viewChip.layer.shadowOpacity = 0.15
        } else if scrollOffset >= transitionEndOffset {
            viewChip.layer.shadowOpacity = 0
            NSLayoutConstraint.activate(viewPoinTopConstraints)
        } else {
            viewChip.layer.shadowOpacity = 0
            viewPoin.isHidden = false
            viewPoinTop.isHidden = false
        }
    }
}
```
* * *

For further customization or to extend this animation, you can ask UX Engineer or Inherit the `Poin Loyalty Animation` and override its methods or add additional functionality as required.
