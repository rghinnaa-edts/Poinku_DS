//
//  Coachmark.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 26/02/25.
//

import UIKit

@IBDesignable
public class Coachmark: UIView {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var lblCurrentStep: UILabel!
    @IBOutlet var lblTotalStep: UILabel!
    @IBOutlet var btnSkip: UIButton!
    @IBOutlet var btnNext: UIButton!
   
    private var contentView: UIView?
    private var targetView: UIView?
    private var endTargetView: UIView?
    private var targetFrame: CGRect = .zero
    private var endTargetFrame: CGRect = .zero
    private var spotlightRadius: CGFloat = 10
    private var dimColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    private var currentStep = 0
    private var totalSteps = 0
    private var spotlightLayer: CAShapeLayer?
    private var spotlightFrame: CGRect = .zero
    private var endSpotlightFrame: CGRect = .zero
    private var triangleView: UIView?
    private let triangleHeight: CGFloat = 8
    private let triangleWidth: CGFloat = 12
    private let triangleTopRadius: CGFloat = 1
    private var stepConfigurations: [StepConfiguration] = []
    private let contentViewWidth: CGFloat = 320
    private var arrowPosition: ArrowPosition = .top
    public var onDismiss: (() -> Void)?

    public struct StepConfiguration {
        let title: String
        let description: String
        let targetView: UIView
        let endTargetView: UIView?
        let spotlightRadius: CGFloat
        let tintColor: UIColor
        let isBtnSkipHide: Bool
        let isBtnNextHide: Bool
        let btnSkipText: String
        let btnNextText: String
        let offsetMargin: CGFloat
        let isListTarget: Bool
        let listSpacing: CGFloat
        let listSpacingLeft: CGFloat?
        let listSpacingRight: CGFloat?

        init(title: String, description: String, targetView: UIView, endTargetView: UIView? = nil, spotlightRadius: CGFloat = 4, tintColor: UIColor = UIColor.blue30, isBtnNextHide: Bool = false, isBtnSkipHide: Bool = false, btnSkipText: String = "Tutup", btnNextText: String = "Berikutnya", offsetMargin: CGFloat = 16, isListTarget: Bool = false, listSpacing: CGFloat = 8, listSpacingLeft: CGFloat? = nil, listSpacingRight: CGFloat? = nil) {
            self.title = title
            self.description = description
            self.targetView = targetView
            self.endTargetView = endTargetView
            self.spotlightRadius = spotlightRadius
            self.tintColor = tintColor
            self.isBtnSkipHide = isBtnSkipHide
            self.isBtnNextHide = isBtnNextHide
            self.btnSkipText = btnSkipText
            self.btnNextText = btnNextText
            self.offsetMargin = offsetMargin
            self.isListTarget = isListTarget
            self.listSpacing = listSpacing
            self.listSpacingLeft = listSpacingLeft
            self.listSpacingRight = listSpacingRight
        }
    }

    public enum Position {
        case left
        case center
        case right
    }

    public enum ArrowPosition {
        case top
        case bottom
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    public func configureSteps(steps: [StepConfiguration]) {
        self.stepConfigurations = steps
        self.totalSteps = steps.count

        if !steps.isEmpty {
            self.currentStep = 1
            updateCurrentStepUI()
        }
    }

    public func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

        self.frame = window.bounds

        if animated {
            self.alpha = 0
        }

        window.addSubview(self)

        if let targetView = self.targetView {
            targetFrame = targetView.convert(targetView.bounds, to: window)
            spotlightFrame = CGRect(
                x: targetFrame.midX - 1,
                y: targetFrame.midY - 1,
                width: 2,
                height: 2
            )
        }

        if let endTargetView = self.endTargetView {
            endTargetFrame = endTargetView.convert(endTargetView.bounds, to: window)
            endSpotlightFrame = CGRect(
                x: endTargetFrame.midX - 1,
                y: endTargetFrame.midY - 1,
                width: 2,
                height: 2
            )
        }

        ensureContentViewWidth()
        updateContentViewPosition()
        
        createSpotlight()
        createTriangleArrow()
        
        updateTrianglePosition()

        contentView?.alpha = 0
        triangleView?.alpha = 0

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if animated {
                UIView.animate(withDuration: 0.1, animations: {
                    self.alpha = 1
                })

                self.animateSpotlight(completion: {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.contentView?.alpha = 1
                        self.triangleView?.alpha = 1
                    }, completion: { _ in
                        completion?()
                    })
                })
            } else {
                self.alpha = 1
                self.contentView?.alpha = 1
                self.triangleView?.alpha = 1
                completion?()
            }
        }
    }

    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.contentView?.alpha = 0
                self.triangleView?.alpha = 0
            }, completion: { _ in
                self.animateSpotlightClose {
                    self.removeFromSuperview()
                    self.onDismiss?()
                    completion?()
                }
            })
        } else {
            self.removeFromSuperview()
            self.onDismiss?()
            completion?()
        }
    }
    
    public func setupCoachmarkButton(
        isBtnLeftHide: Bool = false,
        isBtnRightHide: Bool = false,
        textBtnLeft: String = "",
        textBtnRight: String = "",
        btnLeftColor: UIColor? = nil,
        btnRightColor: UIColor? = nil
    ) {
        
        btnSkip.isHidden = isBtnLeftHide
        btnNext.isHidden = isBtnRightHide
        
        if !textBtnLeft.isEmpty {
            btnSkip.titleLabel?.text = textBtnLeft
        }
        
        if !textBtnRight.isEmpty {
            btnNext.titleLabel?.text = textBtnRight
        }
    }
    
    private func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            contentView.frame = CGRect(x: 0, y: 0, width: contentViewWidth, height: 0)
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 8
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
            contentView.layer.shadowRadius = 4
            contentView.layer.shadowOpacity = 0.1

            contentView.translatesAutoresizingMaskIntoConstraints = true
            contentView.autoresizingMask = []

            self.contentView = contentView
            addSubview(contentView)
        }

        setupUI()
    }

    private func setupUI() {
        lblTitle.font = Font.H3.font
        lblTitle.textColor = UIColor.grey80

        lblDescription.font = Font.Paragraph.P2.Small.font
        lblDescription.textColor = UIColor.grey70

        lblTotal.font = Font.Body.B3.Small.font
        lblTotal.textColor = UIColor.grey50
        
        lblCurrentStep.font = Font.Body.B3.Small.font
        lblCurrentStep.textColor = UIColor.grey50
        
        lblTotalStep.font = Font.Body.B3.Small.font
        lblTotalStep.textColor = UIColor.grey50

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    private func ensureContentViewWidth() {
        calculateContentViewHeight()

        guard let contentView = self.contentView else { return }
        let desiredWidth = min(contentViewWidth, self.bounds.width - 32)
        if contentView.frame.width != desiredWidth {
            var frame = contentView.frame
            frame.size.width = desiredWidth
            contentView.frame = frame
        }
    }

    private func getCurrentStepConfig() -> StepConfiguration? {
        guard currentStep > 0, currentStep <= stepConfigurations.count else { return nil }
        return stepConfigurations[currentStep - 1]
    }

    private func updateCurrentStepUI() {
        guard currentStep > 0, currentStep <= stepConfigurations.count else { return }

        let stepIndex = currentStep - 1
        let stepConfig = stepConfigurations[stepIndex]

        self.lblTitle.text = stepConfig.title
        self.lblDescription.text = stepConfig.description
        self.lblCurrentStep.text = "\(currentStep)"
        self.lblTotalStep.text = "\(totalSteps)"
        
        let oldTargetView = self.targetView
        let oldEndTargetView = self.endTargetView
        
        self.targetView = stepConfig.targetView
        self.endTargetView = stepConfig.endTargetView
        self.spotlightRadius = stepConfig.spotlightRadius
        
        btnSkip.isHidden = stepConfig.isBtnSkipHide
        let skip = btnSkip.title(for: .normal) ?? stepConfig.btnSkipText
        let attributedSkip = NSAttributedString(string: skip, attributes: [
            .font: Font.Button.Small.font,
            .foregroundColor: stepConfig.tintColor
        ])
        btnSkip.setAttributedTitle(attributedSkip, for: .normal)
        
        btnNext.isHidden = stepConfig.isBtnNextHide
        let nextText = stepConfig.btnNextText
        let attributedNext = NSAttributedString(string: nextText, attributes: [
            .font: Font.Button.Small.font,
            .foregroundColor: UIColor.white
        ])
        btnNext.setAttributedTitle(attributedNext, for: .normal)
        btnNext.backgroundColor = stepConfig.tintColor
        btnNext.tintColor = stepConfig.tintColor
        btnNext.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnNext.layer.cornerRadius = 4
        
        if stepConfig.isBtnSkipHide == false && stepConfig.isBtnNextHide == false {
            btnSkip.isHidden = (currentStep == totalSteps)
        }
        
        if currentStep == totalSteps {
            let nextText = "Tutup"
            let attributedNext = NSAttributedString(string: nextText, attributes: [
                .font: Font.Button.Small.font,
                .foregroundColor: UIColor.white
            ])
            btnNext.setAttributedTitle(attributedNext, for: .normal)
        }

        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
           let targetView = self.targetView {
            targetFrame = targetView.convert(targetView.bounds, to: window)
            
            if let endTargetView = self.endTargetView {
                endTargetFrame = endTargetView.convert(endTargetView.bounds, to: window)
            }

            if self.alpha == 1 {
                updateSpotlight(previousTarget: oldTargetView, previousEndTarget: oldEndTargetView)
                updateContentViewPosition(offsetMargin: stepConfig.offsetMargin)
                updateTrianglePosition()
            }
        }

        ensureContentViewWidth()
    }
    
    private func createSpotlight() {
        spotlightLayer?.removeFromSuperlayer()

        let spotlightLayer = CAShapeLayer()
        self.layer.insertSublayer(spotlightLayer, at: 0)
        self.spotlightLayer = spotlightLayer

        let path = UIBezierPath(rect: self.bounds)

        if spotlightFrame == .zero && targetFrame != .zero {
            spotlightFrame = CGRect(
                x: targetFrame.midX - 1,
                y: targetFrame.midY - 1,
                width: 2,
                height: 2
            )
        }

        if self.endTargetView != nil {
            let unifiedSpotlightFrame = createUnifiedSpotlightFrame()
            let spot = UIBezierPath(ovalIn: unifiedSpotlightFrame)
            path.append(spot)
        } else {
            let spot = UIBezierPath(ovalIn: spotlightFrame)
            path.append(spot)
        }

        path.usesEvenOddFillRule = true

        spotlightLayer.path = path.cgPath
        spotlightLayer.fillRule = .evenOdd
        spotlightLayer.fillColor = dimColor.cgColor
        spotlightLayer.frame = self.bounds
    }

    private func createUnifiedSpotlightFrame() -> CGRect {
        let unifiedFrame = targetFrame.union(endTargetFrame)
        
        let paddingX: CGFloat = spotlightRadius + 8
        let paddingY: CGFloat = spotlightRadius + 8
        
        let unifiedSpotlightFrame = CGRect(
            x: unifiedFrame.minX - paddingX,
            y: unifiedFrame.minY - paddingY,
            width: unifiedFrame.width + (paddingX * 2),
            height: unifiedFrame.height + (paddingY * 2)
        )
        
        return unifiedSpotlightFrame
    }

    private func createListSpotlightFrame() -> CGRect {
        guard let stepConfig = getCurrentStepConfig(), stepConfig.isListTarget else {
            return targetFrame.insetBy(dx: -spotlightRadius, dy: -spotlightRadius)
        }
        
        let listSpacing = stepConfig.listSpacing
        let listSpacingLeft = stepConfig.listSpacingLeft ?? listSpacing
        let listSpacingRight = stepConfig.listSpacingRight ?? listSpacing
        let containerFrame = targetFrame
        
        let listSpotlightFrame = CGRect(
            x: containerFrame.minX + listSpacingLeft,
            y: containerFrame.minY - spotlightRadius,
            width: containerFrame.width - (listSpacingLeft + listSpacingRight),
            height: containerFrame.height + (spotlightRadius * 2)
        )
        
        return listSpotlightFrame
    }

    private func updateSpotlight(previousTarget: UIView?, previousEndTarget: UIView?) {
        guard let spotlightLayer = self.spotlightLayer, let targetView = self.targetView else { return }

        let targetsChanged = (previousTarget != nil && previousTarget !== targetView) ||
                           (previousEndTarget != nil && previousEndTarget !== endTargetView)

        if targetsChanged {
            let path = UIBezierPath(rect: self.bounds)
            
            if self.endTargetView != nil {
                let unifiedFrame = targetFrame.union(endTargetFrame)
                let paddingX: CGFloat = spotlightRadius + 8
                let paddingY: CGFloat = spotlightRadius + 8
                
                let unifiedSpotlightRect = CGRect(
                    x: unifiedFrame.minX - paddingX,
                    y: unifiedFrame.minY - paddingY,
                    width: unifiedFrame.width + (paddingX * 2),
                    height: unifiedFrame.height + (paddingY * 2)
                )
                
                let finalSpotPath = UIBezierPath(roundedRect: unifiedSpotlightRect, cornerRadius: spotlightRadius)
                path.append(finalSpotPath)
            } else {
                let spotlightRect = createListSpotlightFrame()
                let finalSpotPath = UIBezierPath(roundedRect: spotlightRect, cornerRadius: spotlightRadius)
                path.append(finalSpotPath)
            }
            
            path.usesEvenOddFillRule = true

            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = 0.3
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.fromValue = spotlightLayer.path
            animation.toValue = path.cgPath

            spotlightLayer.add(animation, forKey: "pathUpdateAnimation")
            spotlightLayer.path = path.cgPath

            UIView.animate(withDuration: 0.3) {
                self.updateContentViewPosition()
                self.updateTrianglePosition()
            }
        }
    }

    private func updateSpotlightPosition() {
        guard let targetView = targetView, let spotlightLayer = spotlightLayer else { return }

        if let window = self.window {
            targetFrame = targetView.convert(targetView.bounds, to: window)
            
            if let endTargetView = self.endTargetView {
                endTargetFrame = endTargetView.convert(endTargetView.bounds, to: window)
            }
        }

        if spotlightLayer.animation(forKey: "pathAnimation") == nil &&
           spotlightLayer.animation(forKey: "closePathAnimation") == nil {
            let path = UIBezierPath(rect: self.bounds)

            if self.endTargetView != nil {
                let unifiedFrame = targetFrame.union(endTargetFrame)
                let paddingX: CGFloat = spotlightRadius + 8
                let paddingY: CGFloat = spotlightRadius + 8
                
                let unifiedSpotlightRect = CGRect(
                    x: unifiedFrame.minX - paddingX,
                    y: unifiedFrame.minY - paddingY,
                    width: unifiedFrame.width + (paddingX * 2),
                    height: unifiedFrame.height + (paddingY * 2)
                )
                
                let spotlightPath = UIBezierPath(roundedRect: unifiedSpotlightRect, cornerRadius: spotlightRadius)
                path.append(spotlightPath)
            } else {
                let spotlightRect = createListSpotlightFrame()
                let spotlightPath = UIBezierPath(roundedRect: spotlightRect, cornerRadius: spotlightRadius)
                path.append(spotlightPath)
            }

            path.usesEvenOddFillRule = true

            spotlightLayer.path = path.cgPath
            spotlightLayer.frame = self.bounds
        }
    }

    private func animateSpotlight(completion: (() -> Void)? = nil) {
        let path = UIBezierPath(rect: self.bounds)
        
        if self.endTargetView != nil {
            let unifiedFrame = targetFrame.union(endTargetFrame)
            let centerPoint = CGPoint(x: unifiedFrame.midX, y: unifiedFrame.midY)
            let initialSpotFrame = CGRect(x: centerPoint.x - 1, y: centerPoint.y - 1, width: 2, height: 2)
            let spotPath = UIBezierPath(ovalIn: initialSpotFrame)
            path.append(spotPath)
        } else {
            let spotPath = UIBezierPath(ovalIn: spotlightFrame)
            path.append(spotPath)
        }

        path.usesEvenOddFillRule = true
        spotlightLayer?.path = path.cgPath

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }

        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.215, 0.610, 0.355, 1.000)

        animation.fromValue = path.cgPath

        let finalPath = UIBezierPath(rect: self.bounds)
        
        if self.endTargetView != nil {
            let unifiedFrame = targetFrame.union(endTargetFrame)
            let paddingX: CGFloat = spotlightRadius + 8
            let paddingY: CGFloat = spotlightRadius + 8
            
            let unifiedSpotlightRect = CGRect(
                x: unifiedFrame.minX - paddingX,
                y: unifiedFrame.minY - paddingY,
                width: unifiedFrame.width + (paddingX * 2),
                height: unifiedFrame.height + (paddingY * 2)
            )
            
            let finalSpotPath = UIBezierPath(roundedRect: unifiedSpotlightRect, cornerRadius: spotlightRadius)
            finalPath.append(finalSpotPath)
        } else {
            let spotlightRect = createListSpotlightFrame()
            let finalSpotPath = UIBezierPath(roundedRect: spotlightRect, cornerRadius: spotlightRadius)
            finalPath.append(finalSpotPath)
        }

        finalPath.usesEvenOddFillRule = true

        animation.toValue = finalPath.cgPath

        spotlightLayer?.path = finalPath.cgPath
        spotlightLayer?.add(animation, forKey: "pathAnimation")

        CATransaction.commit()
    }

    private func animateSpotlightClose(completion: (() -> Void)? = nil) {
        guard let currentPath = spotlightLayer?.path else {
            completion?()
            return
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }

        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.4
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.550, 0.055, 0.675, 0.190)

        animation.fromValue = currentPath

        let finalPath = UIBezierPath(rect: self.bounds)
        
        if self.endTargetView != nil {
            let unifiedFrame = targetFrame.union(endTargetFrame)
            let centerPoint = CGPoint(x: unifiedFrame.midX, y: unifiedFrame.midY)
            let finalSpotPath = UIBezierPath(arcCenter: centerPoint,
                                             radius: 0,
                                             startAngle: 0,
                                             endAngle: 2 * CGFloat.pi,
                                             clockwise: true)
            finalPath.append(finalSpotPath)
        } else {
            let centerPoint = CGPoint(x: targetFrame.midX, y: targetFrame.midY)
            let finalSpotPath = UIBezierPath(arcCenter: centerPoint,
                                             radius: 0,
                                             startAngle: 0,
                                             endAngle: 2 * CGFloat.pi,
                                             clockwise: true)
            finalPath.append(finalSpotPath)
        }

        finalPath.usesEvenOddFillRule = true

        animation.toValue = finalPath.cgPath

        spotlightLayer?.path = finalPath.cgPath
        spotlightLayer?.add(animation, forKey: "closePathAnimation")

        CATransaction.commit()
    }

    private func updateContentViewPosition(offsetMargin: CGFloat = 16) {
        guard let contentView = self.contentView else { return }

        ensureContentViewWidth()

        let padding: CGFloat = 12
        let contentHeight = contentView.frame.height
        let triangleMargin: CGFloat = 8
        let containerMargin: CGFloat = offsetMargin

        let referenceFrame: CGRect
        if self.endTargetView != nil {
            let combinedFrame = targetFrame.union(endTargetFrame)
            let paddingX: CGFloat = spotlightRadius + 8
            let paddingY: CGFloat = spotlightRadius + 8
            
            referenceFrame = CGRect(
                x: combinedFrame.minX - paddingX,
                y: combinedFrame.minY - paddingY,
                width: combinedFrame.width + (paddingX * 2),
                height: combinedFrame.height + (paddingY * 2)
            )
        } else {
            referenceFrame = createListSpotlightFrame()
        }

        let spaceBelow = self.bounds.height - referenceFrame.maxY - padding - contentHeight - triangleHeight - triangleMargin

        if spaceBelow < 0 {
            arrowPosition = .bottom
            contentView.frame.origin.y = referenceFrame.minY - contentHeight - triangleMargin - triangleHeight
        } else {
            arrowPosition = .top
            contentView.frame.origin.y = referenceFrame.maxY + triangleHeight + triangleMargin
        }

        let desiredX = referenceFrame.midX - contentView.frame.width / 2
        contentView.frame.origin.x = max(containerMargin, min(self.bounds.width - contentView.frame.width - containerMargin, desiredX))

        self.bringSubviewToFront(contentView)
    }

    private func calculateContentViewHeight() {
        guard let contentView = self.contentView else { return }

        contentView.layoutIfNeeded()

        var totalHeight: CGFloat = 8

        if let title = lblTitle, !title.isHidden {
            totalHeight += title.frame.height
        }

        totalHeight += 8

        if let description = lblDescription, !description.isHidden && description.text?.isEmpty == false {
            totalHeight += description.frame.height
        }

        totalHeight += 8

        var bottomHeight: CGFloat = 0
        if let nextButton = btnNext {
            bottomHeight = max(bottomHeight, nextButton.frame.height)
        }
        if let skipButton = btnSkip, !skipButton.isHidden {
            bottomHeight = max(bottomHeight, skipButton.frame.height)
        }
        if let totalLabel = lblTotal {
            bottomHeight = max(bottomHeight, totalLabel.frame.height)
        }

        totalHeight += bottomHeight
        totalHeight += 12
        totalHeight = max(totalHeight, 95)

        var frame = contentView.frame
        frame.size.height = totalHeight
        contentView.frame = frame
    }

    private func createTriangleArrow() {
        triangleView?.removeFromSuperview()
        
        let triangleView = UIView(frame: CGRect(x: 0, y: 0, width: triangleWidth, height: triangleHeight))
        triangleView.backgroundColor = .clear
        triangleView.alpha = 0

        self.triangleView = triangleView
        self.addSubview(triangleView)

        let triangleLayer = CAShapeLayer()
        let path = UIBezierPath()

        let bottomLeft = CGPoint(x: 0, y: 0)
        let bottomRight = CGPoint(x: triangleWidth, y: 0)
        let topCenter = CGPoint(x: triangleWidth/2, y: triangleHeight)

        path.move(to: bottomLeft)
        path.addLine(to: bottomRight)

        let leftControl = CGPoint(x: triangleWidth/2 - triangleTopRadius, y: triangleHeight - triangleTopRadius/2)
        let rightControl = CGPoint(x: triangleWidth/2 + triangleTopRadius, y: triangleHeight - triangleTopRadius/2)

        path.addLine(to: rightControl)
        path.addQuadCurve(to: leftControl, controlPoint: topCenter)
        path.addLine(to: bottomLeft)

        triangleLayer.path = path.cgPath
        triangleLayer.fillColor = UIColor.white.cgColor

        triangleView.layer.addSublayer(triangleLayer)
    }

    private func updateTriangleForArrowPosition() {
        guard let triangleView = self.triangleView else { return }

        if arrowPosition == .top {
            triangleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        } else {
            triangleView.transform = CGAffineTransform.identity
        }

        self.bringSubviewToFront(triangleView)
    }

    private func updateTrianglePosition() {
        guard let contentView = self.contentView, let triangleView = self.triangleView else { return }

        let targetCenterX: CGFloat
        
        if self.endTargetView != nil {
            let combinedFrame = targetFrame.union(endTargetFrame)
            targetCenterX = combinedFrame.midX
        } else {
            if let stepConfig = getCurrentStepConfig(), stepConfig.isListTarget {
                let listFrame = createListSpotlightFrame()
                targetCenterX = listFrame.midX
            } else {
                targetCenterX = targetFrame.midX
            }
        }

        let distanceToLeftEdge = abs(targetCenterX - 16)
        let distanceToRightEdge = abs(16 - targetCenterX)

        var triangleX: CGFloat

        let leftThreshold: CGFloat = contentView.frame.width * 0.25
        let rightThreshold: CGFloat = contentView.frame.width * 0.25
        let leftPosition: CGFloat = contentView.frame.width * 0.15
        let rightPosition: CGFloat = contentView.frame.width * 0.85

        if distanceToLeftEdge < distanceToRightEdge && targetCenterX < contentView.frame.minX + leftThreshold {
            triangleX = contentView.frame.minX + leftPosition - (triangleWidth / 2)
        } else if distanceToRightEdge < distanceToLeftEdge && targetCenterX > contentView.frame.maxX - rightThreshold {
            triangleX = contentView.frame.minX + rightPosition - (triangleWidth / 2)
        } else {
            triangleX = targetCenterX - (triangleWidth / 2)
        }

        triangleX = max(contentView.frame.minX + triangleWidth/2, min(triangleX, contentView.frame.maxX - triangleWidth * 1.5))

        let triangleY: CGFloat
        
        if arrowPosition == .top {
            triangleY = contentView.frame.minY - triangleHeight
        } else {
            triangleY = contentView.frame.maxY
        }

        triangleView.frame = CGRect(x: triangleX, y: triangleY, width: triangleWidth, height: triangleHeight)

        updateTriangleForArrowPosition()

        self.bringSubviewToFront(triangleView)
    }

    private func moveToNextStep() {
        if currentStep < totalSteps {
            currentStep += 1
            updateCurrentStepUI()
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc private func handleBackgroundTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)

        var tappedOutside = true
        
        if self.endTargetView != nil {
            let unifiedFrame = targetFrame.union(endTargetFrame)
            let paddingX: CGFloat = spotlightRadius + 8
            let paddingY: CGFloat = spotlightRadius + 8
            
            let unifiedSpotlightRect = CGRect(
                x: unifiedFrame.minX - paddingX,
                y: unifiedFrame.minY - paddingY,
                width: unifiedFrame.width + (paddingX * 2),
                height: unifiedFrame.height + (paddingY * 2)
            )
            
            tappedOutside = !unifiedSpotlightRect.contains(location)
        } else {
            let spotlightRect = createListSpotlightFrame()
            tappedOutside = !spotlightRect.contains(location)
        }

        if tappedOutside {
            // Tapped outside spotlight - decide what to do
            // You can dismiss or move to next step here
        }
    }

    @IBAction func skipButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentStep == totalSteps {
            dismiss(animated: true)
        } else {
            moveToNextStep()
        }
    }
}

