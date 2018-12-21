//
//  Token.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation

struct Token: Codable {
    var basicToken: String?
    var isValid = false
    
    init(basicToken: String, isValid: Bool) {
        self.basicToken = basicToken
        self.isValid = isValid
    }
}
