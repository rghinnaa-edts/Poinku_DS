//
//  BasicAnimation.swift
//  Poinku_DS
//
//  Created by Rizka Ghinna Auliya on 27/10/25.
//

import UIKit

class BasicAnimationViewController: UIViewController {
    
    @IBOutlet var btnBasic: UIButton!
    @IBOutlet var btnSpring: UIButton!
    @IBOutlet var btnKeyframe: UIButton!
    @IBOutlet var btnTransition: UIButton!
    @IBOutlet var btnCoreAnimation: UIButton!
    @IBOutlet var btnProperty: UIButton!
    
    private var initialFrameOrigin: CGPoint = .zero
    private var initialCenterPoint: CGPoint = .zero
    
    private var isFlipped = false
    private var isAnimated = false
    private var animator: UIViewPropertyAnimator?
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
    }
    
    private func animateBasicScale() {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            self.btnBasic.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.btnBasic.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.8) {
                self.btnBasic.transform = .identity
                self.btnBasic.alpha = 1.0
            }
        }
    }
    
    private func animateBasicFrame() {
        btnBasic.translatesAutoresizingMaskIntoConstraints = true
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            var newFrame = self.btnBasic.frame
            newFrame.origin.x -= 15
            newFrame.origin.y -= 15
            newFrame.size.width += 30
            newFrame.size.height += 30
            self.btnBasic.frame = newFrame
        }) { _ in
            UIView.animate(withDuration: 0.8) {
                var originalFrame = self.btnBasic.frame
                originalFrame.origin.x += 15
                originalFrame.origin.y += 15
                originalFrame.size.width -= 30
                originalFrame.size.height -= 30
                self.btnBasic.frame = originalFrame
            }
        }
    }
    
    private func animateBasicBounds() {
        btnBasic.translatesAutoresizingMaskIntoConstraints = true
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            var newBounds = self.btnBasic.bounds
            newBounds.size.width += 40
            newBounds.size.height += 40
            self.btnBasic.bounds = newBounds
        }) { _ in
            UIView.animate(withDuration: 0.8) {
                var originalBounds = self.btnBasic.bounds
                originalBounds.size.width -= 40
                originalBounds.size.height -= 40
                self.btnBasic.bounds = originalBounds
            }
        }
    }
    
    private func animateBasicCenter() {
        btnBasic.translatesAutoresizingMaskIntoConstraints = true
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            self.btnBasic.center = CGPoint(
                x: self.btnBasic.center.x + 50,
                y: self.btnBasic.center.y + 50
            )
        }) { _ in
            UIView.animate(withDuration: 0.8) {
                self.btnBasic.center = self.initialCenterPoint
            }
        }
    }
    
    private func animateBasicAlpha() {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            self.btnBasic.alpha = 0.2
        }) { _ in
            UIView.animate(withDuration: 0.8) {
                self.btnBasic.alpha = 1.0
            }
        }
    }
    
    private func animateBasicColor() {
        UIView.transition(with: btnBasic, duration: 0.8, options: .transitionCrossDissolve, animations: {
            self.btnBasic.tintColor = .systemYellow
        }) { _ in
            UIView.transition(with: self.btnBasic, duration: 0.8, options: .transitionCrossDissolve) {
                self.btnBasic.tintColor = .systemBlue
            }
        }
    }
    
    private func animateBasicTransform() {
//        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse]) {
//            self.btnBasic.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
//        }

        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
            self.btnBasic.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.btnBasic.transform = .identity
            }
        })
    }
    
    private func animateSpring() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1.0,
                       options: [.autoreverse, .repeat],
                       animations: {
            self.btnSpring.transform = CGAffineTransform(translationX: 50, y: 0)
        }, completion: nil)
    }
    
    private func animateKeyframe() {
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.btnKeyframe.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.btnKeyframe.transform = .identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.btnKeyframe.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.btnKeyframe.transform = .identity
            }
        })
    }
    
    
    private func animateTransition() {
        UIView.transition(with: btnTransition,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: {
            self.btnTransition.tintColor = self.isFlipped ? .systemBlue : .systemPurple
            self.btnTransition.setTitle(self.isFlipped ? "Tap Me" : "Tapped!", for: .normal)
        }, completion: { _ in
            self.isFlipped.toggle()
        })
    }
    
    private func animationCA() {
        let animation = CABasicAnimation(keyPath: "opacity")

        animation.fromValue = 1.0
        animation.toValue = 0.0

        animation.duration = 2.0
        animation.beginTime = CACurrentMediaTime() + 1.0

        animation.repeatCount = 3
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        btnCoreAnimation.layer.add(animation, forKey: "fadeOut")
    }
    
    private func animateProperty() {
        let animator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.6) {
            if self.isAnimated {
                self.btnProperty.transform = .identity
                self.btnProperty.tintColor = .systemBlue
            } else {
                self.btnProperty.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.btnProperty.tintColor = .systemPurple
            }
        }
        
        animator.addCompletion { _ in
            self.isAnimated.toggle()
        }
        
        animator.startAnimation()
    }
    
    private func animateProperty2() {
        animator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.5) {
            self.btnProperty.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.btnProperty.alpha = 0.5
        }
        
        animator?.startAnimation()
    }
    
    private func stopAnimation() {
        isAnimating = false
        animator?.stopAnimation(true)
        animator = nil
        
        UIView.animate(withDuration: 0.3) {
            self.btnProperty.transform = .identity
            self.btnProperty.alpha = 1.0
        }
    }
    
    @IBAction func actionBasic(_ sender: Any) {
        animateBasicAlpha()
        stopAnimation()
    }
    
    @IBAction func actionSpring(_ sender: Any) {
        animateSpring()
    }
    
    @IBAction func actionKeyframe(_ sender: Any) {
        animateKeyframe()
    }
    
    @IBAction func actionTransition(_ sender: Any) {
        animateTransition()
    }
    
    @IBAction func btnCoreAnimation(_ sender: Any) {
        animationCA()
    }
    
    @IBAction func btnProperty(_ sender: Any) {
        animateProperty2()
    }
}
