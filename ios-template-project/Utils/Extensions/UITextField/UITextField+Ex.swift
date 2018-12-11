//
//  UITextField+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/28.
//

import UIKit

extension Extensible where Base: UITextField {
    public enum TextType {
        case emailAddress
        case password
        case generic
    }
    
    public var textType: TextType {
        get {
            if base.keyboardType == .emailAddress {
                return .emailAddress
            } else if base.isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                base.keyboardType = .emailAddress
                base.autocorrectionType = .no
                base.autocapitalizationType = .none
                base.isSecureTextEntry = false
                
            case .password:
                base.keyboardType = .asciiCapable
                base.autocorrectionType = .no
                base.autocapitalizationType = .none
                base.isSecureTextEntry = true
            case .generic:
                base.isSecureTextEntry = false
            }
        }
    }
    
    public var isEmpty: Bool {
        return base.text?.isEmpty == true
    }
    
    public var trimmedText: String? {
        return base.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var hasValidEmail: Bool {
        return base.text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                                options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    public var leftViewTintColor: UIColor? {
        get {
            guard let iconView = base.leftView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = base.leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    public func clear() {
        base.text = ""
        base.attributedText = NSAttributedString(string: "")
    }
    
    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = base.placeholder, !holder.isEmpty else { return }
        base.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    public func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: base.frame.height))
        base.leftView = paddingView
        base.leftViewMode = .always
    }
    
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        base.leftView = imageView
        base.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        base.leftViewMode = UITextField.ViewMode.always
    }

}
