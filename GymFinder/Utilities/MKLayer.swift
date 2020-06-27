//
//  MKLayer.swift
//  su_iphone
//
//  Created by Azfal, Umar on 6/5/18.
//  Copyright © 2018 StudentUniverse.com Inc. All rights reserved.
//

import UIKit

let kMKClearEffectsDuration = 0.3

@objc public class MKLayer: CALayer,CAAnimationDelegate {
    
    public var maskEnabled: Bool = true {
        didSet {
            self.mask = maskEnabled ? maskLayer : nil
        }
    }
    @objc public var rippleEnabled: Bool = true
    public var rippleScaleRatio: CGFloat = 1.0 {
        didSet {
            self.calculateRippleSize()
        }
    }
    @objc public var rippleDuration: CFTimeInterval = 0.35
    public var elevation: CGFloat = 0 {
        didSet {
            self.enableElevation()
        }
    }
    public var elevationOffset: CGSize = .zero {
        didSet {
            self.enableElevation()
        }
    }
    public var roundingCorners: UIRectCorner = UIRectCorner.allCorners {
        didSet {
            self.enableElevation()
        }
    }
    public var backgroundAnimationEnabled: Bool = true
    
    private var superView: UIView?
    private var superLayer: CALayer?
    private var rippleLayer: CAShapeLayer?
    private var backgroundLayer: CAShapeLayer?
    private var maskLayer: CAShapeLayer?
    private var userIsHolding: Bool = false
    private var effectIsRunning: Bool = false
    
    private override init(layer: Any) {
        super.init()
    }
    
    @objc public init(superLayer: CALayer) {
        super.init()
        self.superLayer = superLayer
        setup()
    }
    
    @objc public init(withView view: UIView) {
        super.init()
        self.superView = view
        self.superLayer = view.layer
        self.setup()
    }
    
    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.superLayer = self.superlayer
        self.setup()
    }
    
    @objc public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let keyPath = keyPath {
            if keyPath == "bounds" {
                self.superLayerDidResize()
            } else if keyPath == "cornerRadius" {
                if let superLayer = superLayer {
                    setMaskLayerCornerRadius(radius: superLayer.cornerRadius)
                }
            }
        }
    }
    
    
    @objc public func superLayerDidResize() {
        if let superLayer = self.superLayer {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.frame = superLayer.bounds
            self.setMaskLayerCornerRadius(radius: superLayer.cornerRadius)
            self.calculateRippleSize()
            CATransaction.commit()
        }
    }
    

    @objc public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim == self.animation(forKey: "opacityAnim") {
            self.opacity = 0
        } else if flag {
            if userIsHolding {
                effectIsRunning = false
            } else {
                self.clearEffects()
            }
        }
    }
    
    @objc public func startEffects(atLocation touchLocation: CGPoint) {
        userIsHolding = true
        if let rippleLayer = self.rippleLayer {
            rippleLayer.timeOffset = 0
            rippleLayer.speed = backgroundAnimationEnabled ? 1 : 1.1
            if rippleEnabled {
                startRippleEffect(touchLocation: nearestInnerPoint(point: touchLocation))
            }
        }
    }
    
    @objc public func stopEffects() {
        userIsHolding = false
        if !effectIsRunning {
            self.clearEffects()
        } else if let rippleLayer = rippleLayer {
            rippleLayer.timeOffset = rippleLayer.convertTime(CACurrentMediaTime(), from: nil)
            rippleLayer.beginTime = CACurrentMediaTime()
            rippleLayer.speed = 1.2
        }
    }
    
   @objc public func stopEffectsImmediately() {
        userIsHolding = false
        effectIsRunning = false
        if rippleEnabled {
            if let rippleLayer = self.rippleLayer,
                let backgroundLayer = self.backgroundLayer {
                rippleLayer.removeAllAnimations()
                backgroundLayer.removeAllAnimations()
                rippleLayer.opacity = 0
                backgroundLayer.opacity = 0
            }
        }
    }
    
   @objc public func setRippleColor(color: UIColor,
                               withRippleAlpha rippleAlpha: CGFloat = 0.3,
                               withBackgroundAlpha backgroundAlpha: CGFloat = 0.3) {
        if let rippleLayer = self.rippleLayer,
            let backgroundLayer = self.backgroundLayer {
            rippleLayer.fillColor = color.withAlphaComponent(rippleAlpha).cgColor
            backgroundLayer.fillColor = color.withAlphaComponent(backgroundAlpha).cgColor
        }
    }
    
    // MARK: Touches
    
  @objc  public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let first = touches.first, let superView = self.superView {
            let point = first.location(in: superView)
            startEffects(atLocation: point)
        }
    }
    
   @objc public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.stopEffects()
    }
    
  @objc  public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.stopEffects()
    }
    
  @objc  public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    // MARK: Private
    
    private func setup() {
        rippleLayer = CAShapeLayer()
        rippleLayer!.opacity = 0
        self.addSublayer(rippleLayer!)
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer!.opacity = 0
        backgroundLayer!.frame = superLayer!.bounds
        self.addSublayer(backgroundLayer!)
        
        maskLayer = CAShapeLayer()
        self.setMaskLayerCornerRadius(radius: superLayer!.cornerRadius)
        self.mask = maskLayer
        
        self.frame = superLayer!.bounds
        superLayer!.addSublayer(self)
        superLayer!.addObserver(
            self,
            forKeyPath: "bounds",
            options: NSKeyValueObservingOptions(rawValue: 0),
            context: nil)
        superLayer!.addObserver(
            self,
            forKeyPath: "cornerRadius",
            options: NSKeyValueObservingOptions(rawValue: 0),
            context: nil)
        
        self.enableElevation()
        self.superLayerDidResize()
    }
    
    private func setMaskLayerCornerRadius(radius: CGFloat) {
        if let maskLayer = self.maskLayer {
            maskLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        }
    }
    
    private func nearestInnerPoint(point: CGPoint) -> CGPoint {
        
        let x:CGRect = self.bounds
        
        let centerX = x.midX
        let centerY = x.midY
        let dx = point.x - centerX
        let dy = point.y - centerY
        let dist = sqrt(dx * dx + dy * dy)
        if let backgroundLayer = self.rippleLayer { // TODO: Fix it
            if dist <= backgroundLayer.bounds.size.width / 2 {
                return point
            }
            let d = backgroundLayer.bounds.size.width / 2 / dist
            let x = centerX + d * (point.x - centerX)
            let y = centerY + d * (point.y - centerY)
            return CGPoint(x: x, y: y)
        }
        return CGPoint.zero
    }
    
    private func clearEffects() {
        if let rippleLayer = self.rippleLayer,
            let backgroundLayer = self.backgroundLayer {
            rippleLayer.timeOffset = 0
            rippleLayer.speed = 1
            
            if rippleEnabled {
                rippleLayer.removeAllAnimations()
                backgroundLayer.removeAllAnimations()
                self.removeAllAnimations()
                
                let opacityAnim = CABasicAnimation(keyPath: "opacity")
                opacityAnim.fromValue = 1
                opacityAnim.toValue = 0
                opacityAnim.duration = kMKClearEffectsDuration
                opacityAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                opacityAnim.isRemovedOnCompletion = false
                opacityAnim.fillMode = CAMediaTimingFillMode.forwards
                opacityAnim.delegate = self
                
                self.add(opacityAnim, forKey: "opacityAnim")
            }
        }
    }
    
    private func startRippleEffect(touchLocation: CGPoint) {
        self.removeAllAnimations()
        self.opacity = 1
        if let rippleLayer = self.rippleLayer,
            let backgroundLayer = self.backgroundLayer,
            let superLayer = self.superLayer {
            rippleLayer.removeAllAnimations()
            backgroundLayer.removeAllAnimations()
            
            let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
            scaleAnim.fromValue = 0
            scaleAnim.toValue = 1
            scaleAnim.duration = rippleDuration
            scaleAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            scaleAnim.delegate = self
            
            let x:CGRect = superLayer.bounds
            
            let moveAnim = CABasicAnimation(keyPath: "position")
            moveAnim.fromValue = CGPoint.init(x: touchLocation.x, y: touchLocation.y)//NSValue(CGPoint.init(x: touchLocation.x, y: touchLocation.y))
            moveAnim.toValue = CGPoint(
                x: x.midX,
                y: x.midY)
            moveAnim.duration = rippleDuration
            moveAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            
            effectIsRunning = true
            rippleLayer.opacity = 1
            if backgroundAnimationEnabled {
                backgroundLayer.opacity = 1
            } else {
                backgroundLayer.opacity = 0
            }
            
            rippleLayer.add(moveAnim, forKey: "position")
            rippleLayer.add(scaleAnim, forKey: "scale")
        }
    }
    
    private func calculateRippleSize() {
        
        let x:CGRect = (superLayer?.bounds)!
        
        if self.superLayer != nil {
            let superLayerWidth = x.width
            let superLayerHeight = x.height
            let center = CGPoint(
                x: x.midX,
                y: x.midY)
            let circleDiameter =
                sqrt(
                    powf(Float(superLayerWidth), 2)
                        +
                        powf(Float(superLayerHeight), 2)) * Float(rippleScaleRatio)
            let subX = center.x - CGFloat(circleDiameter) / 2
            let subY = center.y - CGFloat(circleDiameter) / 2
            
            if let rippleLayer = self.rippleLayer {
                rippleLayer.frame = CGRect(
                    x: subX, y: subY,
                    width: CGFloat(circleDiameter), height: CGFloat(circleDiameter))
                rippleLayer.path =  UIBezierPath.init(ovalIn: rippleLayer.bounds).cgPath
                
                if let backgroundLayer = self.backgroundLayer {
                    backgroundLayer.frame = rippleLayer.frame
                    backgroundLayer.path = rippleLayer.path
                }
            }
        }
    }
    
    private func enableElevation() {
        if let superLayer = self.superLayer {
            superLayer.shadowOpacity = 0.5
            superLayer.shadowRadius = elevation / 4
            superLayer.shadowColor = UIColor.black.cgColor
            superLayer.shadowOffset = elevationOffset
        }
    }
}
