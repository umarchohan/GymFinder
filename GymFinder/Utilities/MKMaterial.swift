//
//  MKButton.swift
//  su_iphone
//
//  Created by Azfal, Umar on 6/5/18.
//  Copyright © 2018 StudentUniverse.com Inc. All rights reserved.
//


import UIKit

@IBDesignable
public class MKButton : UIButton
{
    @IBInspectable public var maskEnabled: Bool = true {
        didSet {
            mkLayer.maskEnabled = maskEnabled
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            mkLayer.superLayerDidResize()
        }
    }
    @IBInspectable public var elevation: CGFloat = 0 {
        didSet {
            mkLayer.elevation = elevation
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            mkLayer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            mkLayer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            mkLayer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var roundingCorners: UIRectCorner = UIRectCorner.allCorners {
        didSet {
            mkLayer.roundingCorners = roundingCorners
        }
    }
    @IBInspectable public var rippleEnabled: Bool = true {
        didSet {
            mkLayer.rippleEnabled = rippleEnabled
        }
    }
    @IBInspectable public var rippleDuration: CFTimeInterval = 0.05 {
        didSet {
            mkLayer.rippleDuration = rippleDuration
        }
    }
    @IBInspectable public var rippleScaleRatio: CGFloat = 1.0 {
        didSet {
            mkLayer.rippleScaleRatio = rippleScaleRatio
        }
    }
    @IBInspectable public var rippleLayerColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            mkLayer.setRippleColor(color: rippleLayerColor)
        }
    }
    
    @IBInspectable public var backgroundAnimationEnabled: Bool = false {
        didSet {
            mkLayer.backgroundAnimationEnabled = backgroundAnimationEnabled
        }
    }
    
    override public var bounds: CGRect {
        didSet {
            mkLayer.superLayerDidResize()
        }
    }
    
    private lazy var mkLayer: MKLayer = MKLayer(withView: self)
    
    // MARK: Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    // MARK: Setup
    private func setupLayer() {
        mkLayer = MKLayer(withView: self)
        mkLayer.elevation = self.elevation
        self.layer.cornerRadius = self.cornerRadius
        mkLayer.elevationOffset = self.shadowOffset
        mkLayer.roundingCorners = self.roundingCorners
        mkLayer.maskEnabled = self.maskEnabled
        mkLayer.rippleScaleRatio = self.rippleScaleRatio
        mkLayer.rippleDuration = self.rippleDuration
        mkLayer.rippleEnabled = self.rippleEnabled
        mkLayer.backgroundAnimationEnabled = self.backgroundAnimationEnabled
        mkLayer.setRippleColor(color: self.rippleLayerColor)
    }
    
    // MARK: Touch
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        mkLayer.touchesBegan(touches: touches, withEvent: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        mkLayer.touchesEnded(touches: touches, withEvent: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        mkLayer.touchesCancelled(touches: touches, withEvent: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        mkLayer.touchesMoved(touches: touches, withEvent: event)
    }
}

public class MKCollectionViewCell: UICollectionViewCell {
    
    @IBInspectable public var maskEnabled: Bool = true {
        didSet {
            mkLayer.maskEnabled = maskEnabled
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            mkLayer.superLayerDidResize()
        }
    }
    @IBInspectable public var elevation: CGFloat = 0 {
        didSet {
            mkLayer.elevation = elevation
        }
    }
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            mkLayer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var roundingCorners: UIRectCorner = UIRectCorner.allCorners {
        didSet {
            mkLayer.roundingCorners = roundingCorners
        }
    }
    @IBInspectable public var rippleEnabled: Bool = true {
        didSet {
            mkLayer.rippleEnabled = rippleEnabled
        }
    }
    @IBInspectable public var rippleDuration: CFTimeInterval = 0.15 {
        didSet {
            mkLayer.rippleDuration = rippleDuration
        }
    }
    @IBInspectable public var rippleScaleRatio: CGFloat = 1.0 {
        didSet {
            mkLayer.rippleScaleRatio = rippleScaleRatio
        }
    }
    @IBInspectable public var rippleLayerColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            mkLayer.setRippleColor(color: rippleLayerColor)
        }
    }
    @IBInspectable public var backgroundAnimationEnabled: Bool = true {
        didSet {
            mkLayer.backgroundAnimationEnabled = backgroundAnimationEnabled
        }
    }
    
    private lazy var mkLayer: MKLayer = MKLayer(withView: self)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    // MARK: Setup
    private func setupLayer() {
        mkLayer.elevation = self.elevation
        self.layer.cornerRadius = self.cornerRadius
        mkLayer.elevationOffset = self.shadowOffset
        mkLayer.roundingCorners = self.roundingCorners
        mkLayer.maskEnabled = self.maskEnabled
        mkLayer.rippleScaleRatio = self.rippleScaleRatio
        mkLayer.rippleDuration = self.rippleDuration
        mkLayer.rippleEnabled = self.rippleEnabled
        mkLayer.backgroundAnimationEnabled = self.backgroundAnimationEnabled
        mkLayer.setRippleColor(color: self.rippleLayerColor)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        mkLayer.touchesBegan(touches: touches, withEvent: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        mkLayer.touchesEnded(touches: touches, withEvent: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        mkLayer.touchesCancelled(touches: touches, withEvent: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        mkLayer.touchesMoved(touches: touches, withEvent: event)
    }
}

 public class MKTableViewCell : UITableViewCell {
    @IBInspectable public var maskEnabled: Bool = true {
        didSet {
            mkLayer.maskEnabled = maskEnabled
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            mkLayer.superLayerDidResize()
        }
    }
    @IBInspectable public var elevation: CGFloat = 0 {
        didSet {
            mkLayer.elevation = elevation
        }
    }
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            mkLayer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var roundingCorners: UIRectCorner = UIRectCorner.allCorners {
        didSet {
            mkLayer.roundingCorners = roundingCorners
        }
    }
    @IBInspectable public var rippleEnabled: Bool = true {
        didSet {
            mkLayer.rippleEnabled = rippleEnabled
        }
    }
    @IBInspectable public var rippleDuration: CFTimeInterval = 0.15 {
        didSet {
            mkLayer.rippleDuration = rippleDuration
        }
    }
    @IBInspectable public var rippleScaleRatio: CGFloat = 1.0 {
        didSet {
            mkLayer.rippleScaleRatio = rippleScaleRatio
        }
    }
    @IBInspectable public var rippleLayerColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            mkLayer.setRippleColor(color: rippleLayerColor)
        }
    }
    @IBInspectable public var backgroundAnimationEnabled: Bool = true {
        didSet {
            mkLayer.backgroundAnimationEnabled = backgroundAnimationEnabled
        }
    }
    
    private lazy var mkLayer: MKLayer = MKLayer(withView: self.contentView)
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    // MARK: Setup
    private func setupLayer() {
        selectionStyle = .none
        mkLayer.elevation = self.elevation
        self.layer.cornerRadius = self.cornerRadius
        mkLayer.elevationOffset = self.shadowOffset
        mkLayer.roundingCorners = self.roundingCorners
        mkLayer.maskEnabled = self.maskEnabled
        mkLayer.rippleScaleRatio = self.rippleScaleRatio
        mkLayer.rippleDuration = self.rippleDuration
        mkLayer.rippleEnabled = self.rippleEnabled
        mkLayer.backgroundAnimationEnabled = self.backgroundAnimationEnabled
        mkLayer.setRippleColor(color: self.rippleLayerColor)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        mkLayer.touchesBegan(touches: touches, withEvent: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        mkLayer.touchesEnded(touches: touches, withEvent: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        mkLayer.touchesCancelled(touches: touches, withEvent: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        mkLayer.touchesMoved(touches: touches, withEvent: event)
    }
}

@IBDesignable
public class MKTextField : UITextField {
    
    @IBInspectable public var padding: CGSize = CGSize(width: 5, height: 5)
    @IBInspectable public var floatingLabelBottomMargin: CGFloat = 2.0
    @IBInspectable public var floatingPlaceholderEnabled: Bool = false {
        didSet {
            self.updateFloatingLabelText()
        }
    }
    
    @IBInspectable public var maskEnabled: Bool = true {
        didSet {
            mkLayer.maskEnabled = maskEnabled
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.frame.size.height / 2 //self.cornerRadius
            mkLayer.superLayerDidResize()
        }
    }
    @IBInspectable public var elevation: CGFloat = 0 {
        didSet {
            mkLayer.elevation = elevation
        }
    }
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            mkLayer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var roundingCorners: UIRectCorner = UIRectCorner.allCorners {
        didSet {
            mkLayer.roundingCorners = roundingCorners
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            mkLayer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var paddingToLeft: Int = 0 {
        didSet {
            
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: paddingToLeft, height: 30))
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            mkLayer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var rippleEnabled: Bool = true {
        didSet {
            mkLayer.rippleEnabled = rippleEnabled
        }
    }
    @IBInspectable public var rippleDuration: CFTimeInterval = 0.15 {
        didSet {
            mkLayer.rippleDuration = rippleDuration
        }
    }
    @IBInspectable public var rippleScaleRatio: CGFloat = 1.0 {
        didSet {
            mkLayer.rippleScaleRatio = rippleScaleRatio
        }
    }
    @IBInspectable public var rippleLayerColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            mkLayer.setRippleColor(color: rippleLayerColor)
        }
    }
    @IBInspectable public var backgroundAnimationEnabled: Bool = true {
        didSet {
            mkLayer.backgroundAnimationEnabled = backgroundAnimationEnabled
        }
    }
    
    override public var bounds: CGRect {
        didSet {
            mkLayer.superLayerDidResize()
        }
    }
    
    // floating label
    @IBInspectable public var floatingLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 10.0) {
        didSet {
            floatingLabel.font = floatingLabelFont
        }
    }
    @IBInspectable public var floatingLabelTextColor: UIColor = UIColor.lightGray {
        didSet {
            floatingLabel.textColor = floatingLabelTextColor
        }
    }
    
    @IBInspectable public var bottomBorderEnabled: Bool = false {
        didSet {
            bottomBorderLayer?.removeFromSuperlayer()
            bottomBorderLayer = nil
            if bottomBorderEnabled {
                bottomBorderLayer = CALayer()
                bottomBorderLayer?.frame = CGRect(x: 0, y: layer.bounds.height - 1, width: bounds.width, height: 1)
                bottomBorderLayer?.backgroundColor = UIColor.gray.cgColor
                layer.addSublayer(bottomBorderLayer!)
            }
        }
    }
    @IBInspectable public var bottomBorderWidth: CGFloat = 0//1.0
    @IBInspectable public var bottomBorderColor: UIColor = UIColor.clear
        {
        didSet {
            if bottomBorderEnabled {
                bottomBorderLayer?.backgroundColor = bottomBorderColor.cgColor
            }
        }
    }
    @IBInspectable public var bottomBorderHighlightWidth: CGFloat = 1.75
    override public var attributedPlaceholder: NSAttributedString? {
        didSet {
            updateFloatingLabelText()
        }
    }
    
    private lazy var mkLayer: MKLayer = MKLayer(withView: self)
    private var floatingLabel: UILabel!
    private var bottomBorderLayer: CALayer?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    private func setupLayer() {
        mkLayer.elevation = self.elevation
        self.layer.cornerRadius = self.cornerRadius
        mkLayer.elevationOffset = self.shadowOffset
        mkLayer.roundingCorners = self.roundingCorners
        mkLayer.maskEnabled = self.maskEnabled
        mkLayer.rippleScaleRatio = self.rippleScaleRatio
        mkLayer.rippleDuration = self.rippleDuration
        mkLayer.rippleEnabled = self.rippleEnabled
        mkLayer.backgroundAnimationEnabled = self.backgroundAnimationEnabled
        mkLayer.setRippleColor(color: self.rippleLayerColor)
        
      //  layer.borderWidth = 1.0
        borderStyle = .none
        
        // floating label
        floatingLabel = UILabel()
        floatingLabel.font = floatingLabelFont
        floatingLabel.alpha = 0.0
        updateFloatingLabelText()
        
        addSubview(floatingLabel)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        bottomBorderLayer?.backgroundColor = isFirstResponder ? tintColor.cgColor : bottomBorderColor.cgColor
        let borderWidth = isFirstResponder ? bottomBorderHighlightWidth : bottomBorderWidth
        bottomBorderLayer?.frame = CGRect(x: 0, y: layer.bounds.height - borderWidth, width: layer.bounds.width, height: borderWidth)
        
        if !floatingPlaceholderEnabled {
            return
        }
        
        if let text = text, text.isEmpty == false {
            floatingLabel.textColor = isFirstResponder ? tintColor : floatingLabelTextColor
            if floatingLabel.alpha == 0 {
                showFloatingLabel()
            }
        } else {
            hideFloatingLabel()
        }
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.textRect(forBounds: bounds)
        var newRect = CGRect(x: rect.origin.x + padding.width, y: rect.origin.y,
                             width: rect.size.width - 2 * padding.width, height: rect.size.height)
        
        if !floatingPlaceholderEnabled {
            return newRect
        }
        
        if let text = text, text.isEmpty == false {
            let dTop = floatingLabel.font.lineHeight + floatingLabelBottomMargin
            newRect = frame.insetBy(dx: dTop, dy: dTop)
//            newRect = UIEdgeInsetsInsetRect(newRect, UIEdgeInsets(top: dTop, left: 0.0, bottom: 0.0, right: 0.0))
        }
        
        return newRect
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    
    // MARK: Touch
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        mkLayer.touchesBegan(touches: touches, withEvent: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        mkLayer.touchesEnded(touches: touches, withEvent: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        mkLayer.touchesCancelled(touches: touches, withEvent: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        mkLayer.touchesMoved(touches: touches, withEvent: event)
    }
}

// MARK - private methods
private extension MKTextField {
    private func setFloatingLabelOverlapTextField() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch textAlignment {
        case .center:
            originX += textRect.size.width / 2 - floatingLabel.bounds.width / 2
        case .right:
            originX += textRect.size.width - floatingLabel.bounds.width
        default:
            break
        }
        floatingLabel.frame = CGRect(x: originX, y: padding.height,
                                     width: floatingLabel.frame.size.width, height: floatingLabel.frame.size.height)
    }
    
    private func showFloatingLabel() {
        let curFrame = floatingLabel.frame
        floatingLabel.frame = CGRect(x: curFrame.origin.x, y: bounds.height / 2, width: curFrame.width, height: curFrame.height)
        UIView.animate(withDuration: 0.45, delay: 0.0, options: .curveEaseOut,
                                   animations: {
                                    self.floatingLabel.alpha = 1.0
                                    self.floatingLabel.frame = curFrame
        }, completion: nil)
    }
    
    private func hideFloatingLabel() {
        floatingLabel.alpha = 0.0
    }
    
    private func updateFloatingLabelText() {
        floatingLabel.attributedText = attributedPlaceholder
        floatingLabel.sizeToFit()
        setFloatingLabelOverlapTextField()
    }
}

@IBDesignable
public class MKCardView: UIControl {
    
    @IBInspectable public var elevation: CGFloat = 2 {
        didSet {
            mkLayer.elevation = elevation
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            mkLayer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            mkLayer.superLayerDidResize()
        }
    }
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            mkLayer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var roundingCorners: UIRectCorner = UIRectCorner.allCorners {
        didSet {
            mkLayer.roundingCorners = roundingCorners
        }
    }
    @IBInspectable public var maskEnabled: Bool = true {
        didSet {
            mkLayer.maskEnabled = maskEnabled
        }
    }
    @IBInspectable public var rippleScaleRatio: CGFloat = 1.0 {
        didSet {
            mkLayer.rippleScaleRatio = rippleScaleRatio
        }
    }
    @IBInspectable public var rippleDuration: CFTimeInterval = 0.15 {
        didSet {
            mkLayer.rippleDuration = rippleDuration
        }
    }
    @IBInspectable public var rippleEnabled: Bool = true {
        didSet {
            mkLayer.rippleEnabled = rippleEnabled
        }
    }
    @IBInspectable public var rippleLayerColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            mkLayer.setRippleColor(color: rippleLayerColor)
        }
    }
    @IBInspectable public var backgroundAnimationEnabled: Bool = true {
        didSet {
            mkLayer.backgroundAnimationEnabled = backgroundAnimationEnabled
        }
    }
    
    override public var bounds: CGRect {
        didSet {
            mkLayer.superLayerDidResize()
        }
    }
    
    public lazy var mkLayer: MKLayer = MKLayer(withView: self)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    private func setupLayer() {
        mkLayer.elevation = self.elevation
        self.layer.cornerRadius = self.cornerRadius
        mkLayer.elevationOffset = self.shadowOffset
        mkLayer.roundingCorners = self.roundingCorners
        mkLayer.maskEnabled = self.maskEnabled
        mkLayer.rippleScaleRatio = self.rippleScaleRatio
        mkLayer.rippleDuration = self.rippleDuration
        mkLayer.rippleEnabled = self.rippleEnabled
        mkLayer.backgroundAnimationEnabled = self.backgroundAnimationEnabled
        mkLayer.setRippleColor(color: self.rippleLayerColor)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        mkLayer.touchesBegan(touches: touches, withEvent: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        mkLayer.touchesEnded(touches: touches, withEvent: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        mkLayer.touchesCancelled(touches: touches, withEvent: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        mkLayer.touchesMoved(touches: touches, withEvent: event)
    }
}
