//
//  ConfigItems.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/12.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

struct ConfigItems {
    static let buglyAppId: String = Bundle.main["BUGLY_APP_ID"]
    static let baseURL: String = Bundle.main["BASE_URL"]
    static let enableNetworkingLogging: Bool = Bundle.main["ENABLE_NETWORK_LOGGING"] == "YES"
}

extension Bundle {
    subscript<T>(key: String) -> T {
        guard let infoDic = Bundle.main.infoDictionary else {
            fatalError("Can't find info.plist!")
        }
        guard let value = infoDic[key] as? T else {
            fatalError("There is no value of '\(T.self)' type for \(key) in Info.plist, Please check if the type of \(key) is correct or \(key) exists")
        }
        
        return value
    }
}
