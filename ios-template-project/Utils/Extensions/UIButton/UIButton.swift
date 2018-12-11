//
//  UIButton.swift
//  Extensions
//
//  Created by liubo on 2018/8/28.
//

import UIKit

extension Extensible where Base: UIButton {
    public var imageForDisabled: UIImage? {
        get {
            return base.image(for: .disabled)
        }
        set {
            base.setImage(newValue, for: .disabled)
        }
    }
    
    public var imageForHighlighted: UIImage? {
        get {
            return base.image(for: .highlighted)
        }
        set {
            base.setImage(newValue, for: .highlighted)
        }
    }
    
    public var imageForNormal: UIImage? {
        get {
            return base.image(for: .normal)
        }
        set {
            base.setImage(newValue, for: .normal)
        }
    }
    
    public var imageForSelected: UIImage? {
        get {
            return base.image(for: .selected)
        }
        set {
            base.setImage(newValue, for: .selected)
        }
    }
    
    public var titleColorForDisabled: UIColor? {
        get {
            return base.titleColor(for: .disabled)
        }
        set {
            base.setTitleColor(newValue, for: .disabled)
        }
    }
    
    public var titleColorForHighlighted: UIColor? {
        get {
            return base.titleColor(for: .highlighted)
        }
        set {
            base.setTitleColor(newValue, for: .highlighted)
        }
    }
    
    public var titleColorForNormal: UIColor? {
        get {
            return base.titleColor(for: .normal)
        }
        set {
            base.setTitleColor(newValue, for: .normal)
        }
    }
    
    public var titleColorForSelected: UIColor? {
        get {
            return base.titleColor(for: .selected)
        }
        set {
            base.setTitleColor(newValue, for: .selected)
        }
    }
    
    public var titleForDisabled: String? {
        get {
            return base.title(for: .disabled)
        }
        set {
            base.setTitle(newValue, for: .disabled)
        }
    }
    
    public var titleForHighlighted: String? {
        get {
            return base.title(for: .highlighted)
        }
        set {
            base.setTitle(newValue, for: .highlighted)
        }
    }
    
    public var titleForNormal: String? {
        get {
            return base.title(for: .normal)
        }
        set {
            base.setTitle(newValue, for: .normal)
        }
    }
    
    public var titleForSelected: String? {
        get {
            return base.title(for: .selected)
        }
        set {
            base.setTitle(newValue, for: .selected)
        }
    }
    
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
    
    public func setImageForAllStates(_ image: UIImage) {
        base.ext.states.forEach { base.setImage(image, for: $0) }
    }
    
    public func setTitleColorForAllStates(_ color: UIColor) {
        base.ext.states.forEach { base.setTitleColor(color, for: $0) }
    }
    
    public func setTitleForAllStates(_ title: String) {
        base.ext.states.forEach { base.setTitle(title, for: $0) }
    }
    
    public func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        base.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        base.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        base.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
