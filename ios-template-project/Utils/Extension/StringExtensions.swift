//
//  StringExtensions.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/25.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation

extension String {
    /// 适用于 base64 的字符串
    public var urlSafeString: String {
        var x = replacingOccurrences(of: "/", with: "_")
        x = x.replacingOccurrences(of: "+", with: "-")
        x = x.replacingOccurrences(of: "=", with: "")
        return x
    }
    
    /// 适用于 base64 的字符串
    public var urlUnsafeString: String {
        var x = replacingOccurrences(of: "_", with: "/")
        x = x.replacingOccurrences(of: "-", with: "+")
        let mod4 = x.count % 4
        if mod4 > 0 {
            let y = ("====" as NSString).substring(to: 4 - mod4)
            x.append(y)
        }
        return x
    }
}
