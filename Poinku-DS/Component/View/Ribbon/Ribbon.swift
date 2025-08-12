//
//  Ribbon.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 03/02/25.
//

import UIKit

@IBDesignable
class RibbonView: UIView {
    
    enum Gravity {
        case start
        case end
    }
    
    enum VerticalAlignment {
        case top
        case center
        case bottom
        case defaultV
    }
    
    @IBInspectable var triangleColor: UIColor = UIColor.blue50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var containerColor: UIColor = UIColor.blue30 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var containerStartColor: UIColor = .clear {
        didSet {
            updateGradientLayer()
        }
    }
    
    @IBInspectable var containerEndColor: UIColor = .clear {
        didSet {
            updateGradientLayer()
        }
    }
    
    @IBInspectable var textColor: UIColor = .white {
        didSet {
            label.textColor = textColor
        }
    }
    
    var gravity: Gravity = .start {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var textVerticalPadding: CGFloat = 4 {
        didSet {
            updateTextContainerHeight()
        }
    }
    
    @IBInspectable var textHorizontalPadding: CGFloat = 4 {
        didSet {
            updateTextContainerHeight()
        }
    }
    
    var ribbonText: String? {
        get { label.text }
        set {
            label.text = newValue
            updateTextMeasurements()
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.H3.font
        return label
    }()
    
    private let gradientLayer = CAGradientLayer()
    private var textWidth: CGFloat = 0
    private var textHeight: CGFloat = 0
    private var textLineHeight: CGFloat = 0
    
    private var triangleWidth: CGFloat { 6 }
    private var triangleHeight: CGFloat { 8 }
    private var textContainerHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        layer.addSublayer(gradientLayer)
        addSubview(label)
        updateTextMeasurements()
        
        sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: 0,
            y: 0,
            width: textWidth,
            height: textContainerHeight
        )
        
        updateGradientLayer()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: textWidth,
            height: triangleWidth + textContainerHeight + 2
        )
    }
    
    override func draw(_ rect: CGRect) {
        let containerPath = if gravity == .start {
            UIBezierPath(
                roundedRect: CGRect(
                    x: 0,
                    y: 0,
                    width: textWidth,
                    height: textContainerHeight
                ),
                byRoundingCorners: [.topLeft, .topRight, .bottomRight],
                cornerRadii: CGSize(width: 4, height: 4)
            )
        } else {
            UIBezierPath(
                roundedRect: CGRect(
                    x: 0,
                    y: 0,
                    width: textWidth,
                    height: textContainerHeight
                ),
                byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                cornerRadii: CGSize(width: 4, height: 4)
            )
        }
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.15)
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowBlurRadius = 6
        
        containerPath.addShadow(shadow)
        
        if containerStartColor == .clear || containerEndColor == .clear {
            containerColor.setFill()
            containerPath.fill()
        }
        
        let trianglePath = UIBezierPath()
        if gravity == .start {
            trianglePath.move(to: CGPoint(x: 0, y: textContainerHeight))
            trianglePath.addLine(to: CGPoint(x: triangleWidth, y: textContainerHeight))
            trianglePath.addLine(to: CGPoint(x: triangleWidth, y: textContainerHeight + triangleHeight))
        } else {
            trianglePath.move(to: CGPoint(x: textWidth, y: textContainerHeight))
            trianglePath.addLine(to: CGPoint(x: textWidth - triangleWidth, y: textContainerHeight))
            trianglePath.addLine(to: CGPoint(x: textWidth - triangleWidth, y: textContainerHeight + triangleHeight))
        }
        trianglePath.close()
        
        triangleColor.setFill()
        trianglePath.fill()
    }
    
    private func updateGradientLayer() {
        let path =  if gravity == .start {
            UIBezierPath(
                roundedRect: CGRect(
                    x: 0,
                    y: 0,
                    width: textWidth,
                    height: textContainerHeight
                ),
                byRoundingCorners: [.topLeft, .topRight, .bottomRight],
                cornerRadii: CGSize(width: 4, height: 4)
            )
        } else {
            UIBezierPath(
                roundedRect: CGRect(
                    x: 0,
                    y: 0,
                    width: textWidth,
                    height: textContainerHeight
                ),
                byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                cornerRadii: CGSize(width: 4, height: 4)
            )
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: textWidth, height: textContainerHeight)
        gradientLayer.colors = [containerStartColor.cgColor, containerEndColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradientLayer.mask = maskLayer
    }
    
    private func updateTextMeasurements() {
        guard let text = ribbonText else { return }
        let size = (text as NSString).size(withAttributes: [.font: label.font as Any])
        textWidth = size.width + textHorizontalPadding * 2
        textHeight = size.height
        updateTextContainerHeight()
        frame = CGRect(x: 0, y: 0, width: textWidth, height: triangleWidth + textContainerHeight + 2)
        invalidateIntrinsicContentSize()
    }
    
    private func updateTextContainerHeight() {
        textContainerHeight = textHeight + textVerticalPadding * 2
        setNeedsDisplay()
    }
    
    func anchorToView(
        rootParent: UIView,
        targetView: UIView,
        verticalAlignment: VerticalAlignment = .defaultV,
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0
    ) {
        let targetFrame = targetView.convert(targetView.bounds, to: rootParent)
        
        let x: CGFloat
        if gravity == .start {
            x = targetFrame.minX - triangleWidth + offsetX
        } else {
            x = targetFrame.maxX - frame.width + triangleWidth + offsetX
        }
        
        let y: CGFloat
        switch verticalAlignment {
        case .top:
            y = targetFrame.minY - textContainerHeight + offsetY
        case .center:
            y = targetFrame.midY - textContainerHeight / 2 + offsetY
        case .bottom:
            y = targetFrame.maxY + offsetY
        default:
            y = targetFrame.minY + 8
        }
        
        removeFromSuperview()
        
        rootParent.addSubview(self)
        frame = CGRect(x: x, y: y, width: frame.width, height: frame.height)
    }
}

extension UIBezierPath {
    func addShadow(_ shadow: NSShadow) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        let shadowColor = shadow.shadowColor as? UIColor ?? .black
        context?.setShadow(
            offset: shadow.shadowOffset,
            blur: shadow.shadowBlurRadius,
            color: shadowColor.cgColor
        )
        
        fill()
        context?.restoreGState()
    }
}
