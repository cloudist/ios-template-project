//
//  LoginResponse.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/18.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let user: User
}
