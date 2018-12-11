//
//  UILabel+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/28.
//

import UIKit

extension Extensible where Base: UILabel {
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: base.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = base.font
        label.text = base.text
        label.attributedText = base.attributedText
        label.sizeToFit()
        return label.frame.height
    }
}

extension UILabel {
    public convenience init(text: String) {
        self.init()
        self.text = text
    }
}
