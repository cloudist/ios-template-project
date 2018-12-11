//
//  UIView+Msic.swift
//  Extensions
//
//  Created by liubo on 2018/8/16.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

public extension Reactive where Base: UIView {
    var backgroundColor: Binder<UIColor> {
        return Binder(self.base) { view, backgroundColor in
            view.backgroundColor = backgroundColor
        }
    }
}

extension Extensible where Base: UIView {
    
    public enum shakeDirection {
        case horizontal
        case vertical
    }
    
    public enum AngleUnit {
        case degrees
        case radians
    }
    
    public enum ShakeAnumationType {
        case linear
        case easeIn
        case easeOut
        case easeInout
    }
    
    public var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return base.safeAreaLayoutGuide.snp
        }
        return base.snp
    }
    
    public var borderColor: UIColor? {
        get {
            guard let color = base.layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                base.layer.borderColor = nil
                return
            }
            base.layer.borderColor = color.cgColor
        }
    }
    
    public var borderWidth: CGFloat {
        get {
            return base.layer.borderWidth
        }
        set {
            base.layer.borderWidth = newValue
        }
    }
    
    public var cornerRadius: CGFloat {
        get {
            return base.layer.cornerRadius
        }
        set {
            base.layer.masksToBounds = true
            base.layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    public var shadowColor: UIColor? {
        get {
            guard let color = base.layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            base.layer.shadowColor = newValue?.cgColor
        }
    }
    
    public var shadowOffset: CGSize {
        get {
            return base.layer.shadowOffset
        }
        set {
            base.layer.shadowOffset = newValue
        }
    }
    
    public var shadowOpacity: Float {
        get {
            return base.layer.shadowOpacity
        }
        set {
            base.layer.shadowOpacity = newValue
        }
    }
    
    public var shadowRadius: CGFloat {
        get {
            return base.layer.shadowRadius
        }
        set {
            base.layer.shadowRadius = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return base.frame.size.height
        }
        set {
            base.frame.size.height = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return base.frame.size.width
        }
        set {
            base.frame.size.width = newValue
        }
    }
    
    public var size: CGSize {
        get {
            return base.frame.size
        }
        set {
            base.frame.size.width = newValue.width
            base.frame.size.height = newValue.height
        }
    }
    
    public var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        set {
            base.frame.origin.x = newValue
        }
    }
    
    public var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        set {
            base.frame.origin.y = newValue
        }
    }
    
    public var isRightToLeft: Bool {
        if #available(iOS 10.0, *, tvOS 10.0, *) {
            return base.effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            return false
        }
    }
    
    public var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        base.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = base
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    public var firstResponder: UIView? {
        var views = [UIView](arrayLiteral: base)
        var i = 0
        repeat {
            let view = views[i]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            i += 1
        } while i < views.count
        return nil
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: base.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        base.layer.mask = shape
    }
    
    public func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0),
                          radius: CGFloat = 3,
                          offset: CGSize = .zero,
                          opacity: Float = 0.5) {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowRadius = radius
        base.layer.shadowOpacity = opacity
        base.layer.masksToBounds = false
    }
    
    public func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { base.addSubview($0) }
    }
    
    public func removeSubviews() {
        base.subviews.forEach { $0.removeFromSuperview() }
    }
    
    public func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    public func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if base.isHidden {
            base.isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.base.alpha = 1
        }, completion: completion)
    }
    
    public func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if base.isHidden {
            base.isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.base.alpha = 0
        }, completion: completion)
    }
    
    public func rotate(byAngle angle: CGFloat,
                       ofType type: AngleUnit,
                       animated: Bool = false,
                       duration: TimeInterval = 1,
                       completion: ((Bool) -> Void)? = nil) {
        
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: {
            self.base.transform = self.base.transform.rotated(by: angleWithType)
        }, completion: completion)
    }
    
    public func rotate(toAngle angle: CGFloat,
                       ofType type: AngleUnit,
                       animated: Bool = false,
                       duration: TimeInterval = 1,
                       completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.base.transform = self.base.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }
    
    public func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
                self.base.transform = self.base.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            base.transform = base.transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }
    
    public func shake(direction: shakeDirection = .horizontal,
                      duration: TimeInterval = 1,
                      animatedType: ShakeAnumationType = .easeOut,
                      completion: (() -> Void)? = nil) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.traslation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.traslation.y")
        }
        
        switch animatedType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInout:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        base.layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    
}
