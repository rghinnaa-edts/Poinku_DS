//
//  Coachmark.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 26/02/25.
//

import UIKit

@IBDesignable
class Coachmark: UIView {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var btnSkip: UIButton!
    @IBOutlet var btnNext: UIButton!
   
    private var contentView: UIView?
    private var targetView: UIView?
    private var targetFrame: CGRect = .zero
    private var spotlightRadius: CGFloat = 10
    private var dimColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    private var currentStep = 0
    private var totalSteps = 0
    private var spotlightLayer: CAShapeLayer?
    private var spotlightFrame: CGRect = .zero
    private var triangleView: UIView?
    private let triangleHeight: CGFloat = 8
    private let triangleWidth: CGFloat = 12
    private let triangleTopRadius: CGFloat = 1
    private var stepConfigurations: [StepConfiguration] = []
    private let contentViewWidth: CGFloat = 320
    private var arrowPosition: ArrowPosition = .top
    var onDismiss: (() -> Void)?

    struct StepConfiguration {
        let title: String
        let description: String
        let targetView: UIView
        let spotlightRadius: CGFloat
        let tintColor: UIColor

        init(title: String, description: String, targetView: UIView, spotlightRadius: CGFloat = 4, tintColor: UIColor = UIColor.Blue.blue30) {
            self.title = title
            self.description = description
            self.targetView = targetView
            self.spotlightRadius = spotlightRadius
            self.tintColor = tintColor
        }
    }

    enum Position {
        case left
        case center
        case right
    }

    enum ArrowPosition {
        case top
        case bottom
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            contentView.frame = CGRect(x: 0, y: 0, width: contentViewWidth, height: 0)
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 12
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
        lblTitle.textColor = UIColor.Grey.grey80

        lblDescription.font = Font.Paragraph.P2.Small.font
        lblDescription.textColor = UIColor.Grey.grey70

        lblTotal.font = Font.Body.B3.Small.font
        lblTotal.textColor = UIColor.Grey.grey50

        let skip = btnSkip.title(for: .normal) ?? ""
        let attributedSkip = NSAttributedString(string: skip, attributes: [
            .font: Font.Button.Small.font,
            .foregroundColor: UIColor.Blue.blue30.cgColor
        ])
        btnSkip.setAttributedTitle(attributedSkip, for: .normal)

        btnNext.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnNext.backgroundColor = UIColor.Blue.blue30
        btnNext.tintColor = UIColor.Blue.blue30
        btnNext.layer.cornerRadius = 4

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

    func configure(title: String, description: String, targetView: UIView, spotlightRadius: CGFloat = 4, tintColor: UIColor = UIColor.Blue.blue30) {
        self.lblTitle.text = title
        self.lblDescription.text = description
        self.lblTotal.text = "1/1"
        self.targetView = targetView
        self.spotlightRadius = spotlightRadius

        let skip = btnSkip.title(for: .normal) ?? ""
        let attributedSkip = NSAttributedString(string: skip, attributes: [
            .font: Font.Button.Small.font,
            .foregroundColor: tintColor
        ])
        self.btnSkip.setAttributedTitle(attributedSkip, for: .normal)

        self.btnNext.backgroundColor = tintColor
        self.btnNext.tintColor = tintColor

        updateNavigationButtons()
        ensureContentViewWidth()
    }

    func configureSteps(steps: [StepConfiguration]) {
        self.stepConfigurations = steps
        self.totalSteps = steps.count

        if !steps.isEmpty {
            self.currentStep = 1
            updateCurrentStepUI()
        }
    }

    func show(animated: Bool = true, completion: (() -> Void)? = nil) {
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

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
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

    private func updateCurrentStepUI() {
        guard currentStep > 0, currentStep <= stepConfigurations.count else { return }

        let stepIndex = currentStep - 1
        let stepConfig = stepConfigurations[stepIndex]

        self.lblTitle.text = stepConfig.title
        self.lblDescription.text = stepConfig.description
        self.lblTotal.text = "\(currentStep)/\(totalSteps)"

        let oldTargetView = self.targetView
        self.targetView = stepConfig.targetView
        self.spotlightRadius = stepConfig.spotlightRadius

        let skip = btnSkip.title(for: .normal) ?? ""
        let attributedSkip = NSAttributedString(string: skip, attributes: [
            .font: Font.Button.Small.font,
            .foregroundColor: stepConfig.tintColor
        ])
        btnSkip.setAttributedTitle(attributedSkip, for: .normal)

        btnNext.backgroundColor = stepConfig.tintColor
        btnNext.tintColor = stepConfig.tintColor

        updateNavigationButtons()

        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
           let targetView = self.targetView {
            targetFrame = targetView.convert(targetView.bounds, to: window)

            if self.alpha == 1 {
                updateSpotlight(previousTarget: oldTargetView)
                updateContentViewPosition()
                updateTrianglePosition()
            }
        }

        ensureContentViewWidth()
    }

    private func updateSpotlight(previousTarget: UIView?) {
        guard let spotlightLayer = self.spotlightLayer, let targetView = self.targetView else { return }

        if previousTarget != nil && previousTarget !== targetView {
            let path = UIBezierPath(rect: self.bounds)
            let spotlightRect = targetFrame.insetBy(dx: -spotlightRadius, dy: -spotlightRadius)
            let finalSpotPath = UIBezierPath(roundedRect: spotlightRect, cornerRadius: spotlightRadius)
            path.append(finalSpotPath)
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

    private func updateContentViewPosition() {
        guard let contentView = self.contentView else { return }

        ensureContentViewWidth()

        let padding: CGFloat = 12
        let contentHeight = contentView.frame.height

        let spaceBelow = self.bounds.height - targetFrame.maxY - padding - contentHeight - triangleHeight

        if spaceBelow < 0 {
            arrowPosition = .bottom
            contentView.frame.origin.y = targetFrame.minY - contentHeight - padding - triangleHeight
        } else {
            arrowPosition = .top
            contentView.frame.origin.y = targetFrame.maxY + padding + triangleHeight
        }

        let desiredX = targetFrame.midX - contentView.frame.width / 2
        contentView.frame.origin.x = max(16, min(self.bounds.width - contentView.frame.width - 16, desiredX))

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

        let spot = UIBezierPath(ovalIn: spotlightFrame)
        path.append(spot)
        path.usesEvenOddFillRule = true

        spotlightLayer.path = path.cgPath
        spotlightLayer.fillRule = .evenOdd
        spotlightLayer.fillColor = dimColor.cgColor
        spotlightLayer.frame = self.bounds
    }

    private func updateSpotlightPosition() {
        guard let targetView = targetView, let spotlightLayer = spotlightLayer else { return }

        if let window = self.window {
            targetFrame = targetView.convert(targetView.bounds, to: window)
        }

        if spotlightLayer.animation(forKey: "pathAnimation") == nil &&
           spotlightLayer.animation(forKey: "closePathAnimation") == nil {
            let path = UIBezierPath(rect: self.bounds)

            let spotlightRect = targetFrame.insetBy(dx: -spotlightRadius, dy: -spotlightRadius)
            let spotlightPath = UIBezierPath(roundedRect: spotlightRect, cornerRadius: spotlightRadius)

            path.append(spotlightPath)
            path.usesEvenOddFillRule = true

            spotlightLayer.path = path.cgPath
            spotlightLayer.frame = self.bounds
        }
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

        let targetCenterX = targetFrame.midX

        let distanceToLeftEdge = abs(targetCenterX - contentView.frame.minX)
        let distanceToRightEdge = abs(contentView.frame.maxX - targetCenterX)

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

    private func animateSpotlight(completion: (() -> Void)? = nil) {
        let path = UIBezierPath(rect: self.bounds)
        let spotPath = UIBezierPath(ovalIn: spotlightFrame)
        path.append(spotPath)
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
        let spotlightRect = targetFrame.insetBy(dx: -spotlightRadius, dy: -spotlightRadius)
        let finalSpotPath = UIBezierPath(roundedRect: spotlightRect, cornerRadius: spotlightRadius)
        finalPath.append(finalSpotPath)
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
        let centerPoint = CGPoint(x: targetFrame.midX, y: targetFrame.midY)
        let finalSpotPath = UIBezierPath(arcCenter: centerPoint,
                                         radius: 0,
                                         startAngle: 0,
                                         endAngle: 2 * CGFloat.pi,
                                         clockwise: true)

        finalPath.append(finalSpotPath)
        finalPath.usesEvenOddFillRule = true

        animation.toValue = finalPath.cgPath

        spotlightLayer?.path = finalPath.cgPath
        spotlightLayer?.add(animation, forKey: "closePathAnimation")

        CATransaction.commit()
    }

    private func updateNavigationButtons() {
        if currentStep == totalSteps {
            let doneText = "Tutup"
            let attributedNext = NSAttributedString(string: doneText, attributes: [
                .font: Font.Button.Small.font,
                .foregroundColor: UIColor.white
            ])
            btnNext.setAttributedTitle(attributedNext, for: .normal)

        } else {
            let nextText = "Berikutnya"
            let attributedNext = NSAttributedString(string: nextText, attributes: [
                .font: Font.Button.Small.font,
                .foregroundColor: UIColor.white
            ])
            btnNext.setAttributedTitle(attributedNext, for: .normal)
        }

        btnSkip.isHidden = (currentStep == totalSteps)
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

        let spotlightRect = targetFrame.insetBy(dx: -spotlightRadius, dy: -spotlightRadius)
        if !spotlightRect.contains(location) {
            // Tapped outside the spotlight - decide what to do
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
