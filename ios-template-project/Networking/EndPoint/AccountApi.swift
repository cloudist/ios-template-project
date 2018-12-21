//
//  AccountApi.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Moya

enum Account {
    case login(param: [String: String])
    case userInfo(id: Int)
}

extension Account: TargetType {
    var baseURL: URL {
        return NetworkingConstant.baseURL
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/auth/tokens/"
        case .userInfo(let id):
            return "/api/user/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .userInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .userInfo:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

extension Account: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        switch self {
        case .login:
            return .none
        default:
            return .custom("Token")
        }
    }
    
    
}
