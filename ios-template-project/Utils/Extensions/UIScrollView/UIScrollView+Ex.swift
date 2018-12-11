//
//  UIScrollView+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/28.
//

import UIKit

extension Extensible where Base: UIScrollView {
    public var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = base.frame
        base.frame = CGRect(origin: base.frame.origin, size: base.contentSize)
        base.layer.render(in: context)
        base.frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
