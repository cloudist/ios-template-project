//
//  Constant.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/12.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation

enum Constant: String {
    case buglyAppId = "BUYLY_APP_ID"
    case baseURL = "BASE_URL"
}

extension Bundle {
    subscript<T>(key: Constant) -> T {
        guard let infoDic = Bundle.main.infoDictionary else {
            fatalError("Can't find info.plist!")
        }
        guard let value = infoDic[key.rawValue] as? T else {
            fatalError("There is no value of '\(T.self)' type for \(key.rawValue) in Info.plist, Please check if the type of \(key.rawValue) is correct or \(key.rawValue) exists")
        }
        
        return value
    }
}
