# Search Bar Animation
The `Search Bar Animation` is interactive visual effects that enhance the user experience when engaging with search functionality.

## Preview
![Search Bar Animation Preview](https://res.cloudinary.com/dr6cm6n5f/video/upload/v1744624375/WhatsApp_Video_2025-04-14_at_16.51.01_oxhnps.mp4)

## Installation
To use the `Search Bar Animation`, add this following code to the 'button Search' action.

this is for show the search bar
``` Show Search Bar
    @IBAction func btnSearch(_ sender: Any) {
        originalSearchBarAnchorPoint = searchBar.layer.anchorPoint
        
        searchBar.alpha = 0
        searchBar.isHidden = false
        
        let buttonPositionInWindow = btnSearch.convert(btnSearch.bounds.origin, to: searchBar.superview)
        
        let buttonCenterX = buttonPositionInWindow.x + btnSearch.bounds.width/2
        let buttonCenterY = buttonPositionInWindow.y + btnSearch.bounds.height/2
        
        let originX = (buttonCenterX - searchBar.center.x) / searchBar.bounds.width + 0.5
        let originY = (buttonCenterY - searchBar.center.y) / searchBar.bounds.height + 0.5
        
        searchBar.layer.anchorPoint = CGPoint(x: originX, y: originY)
        searchBar.center = CGPoint(
            x: searchBar.center.x + (originX - 0.5) * searchBar.bounds.width,
            y: searchBar.center.y + (originY - 0.5) * searchBar.bounds.height
        )
        
        searchBar.transform = CGAffineTransform(scaleX: 0.1, y: 1)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.viewNavBar.alpha = 0
        }, completion: { _ in
            self.viewNavBar.isHidden = true
            self.viewNavBar.transform = .identity
        })
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.searchBar.alpha = 1
            self.searchBar.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.searchBar.transform = .identity
            }, completion: { _ in
                self.searchBar.becomeFirstResponder()
                self.addTapGestureToHideSearchBar()
            })
        })
    }
```

this is for hide the search bar
``` Hide Search Bar
    private func hideSearchBar() {
        searchBar.resignFirstResponder()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.searchBar.alpha = 0
        }, completion: { _ in
            self.searchBar.isHidden = true
            self.searchBar.transform = .identity
            self.searchBar.layer.anchorPoint = self.originalSearchBarAnchorPoint
            
            if let superview = self.searchBar.superview {
                self.searchBar.center = CGPoint(
                    x: superview.bounds.midX,
                    y: self.searchBar.center.y
                )
            }
            
            self.removeTapGesture()
            
            self.viewNavBar.isHidden = false
            self.viewNavBar.alpha = 0
            
            UIView.animate(withDuration: 0.2, animations: {
                self.viewNavBar.alpha = 1
            })
        })
    }

    private func removeTapGesture() {
        if let existingGesture = tapGestureRecognizer {
            view.removeGestureRecognizer(existingGesture)
            tapGestureRecognizer = nil
        }
    }
    
    @objc private func handleTapOutsideSearchBar(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        
        if !searchBar.frame.contains(location) && searchBar.text?.isEmpty ?? true {
            hideSearchBar()
        }
    }
```
* * *

For further customization or to extend this animation, you can ask UX Engineer or Inherit the `Search Bar` and override its methods or add additional functionality as required.
