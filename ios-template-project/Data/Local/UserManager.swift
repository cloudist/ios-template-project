//
//  UserManager.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/13.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import KeychainAccess

extension Notification.Name {
    static let UserShouldLogout = Notification.Name("UserManager.UserShouldLogout")
}

class UserManager {
    static let shared = UserManager()
    
    private let userInfoStorageKey = "UserManager.userInfoStorageKey"
    private let userTokenStorageKey = "UserManager.userTokenStorageKey"
    private var _user: User?
    private var _token: String?
    
    var user: User? {
        get { return _user }
        set {
            _user = newValue
            let keyChain = Keychain()
            if let newValue = newValue, let userData = try? JSONEncoder().encode(newValue) {
                try? keyChain.set(userData, key: userInfoStorageKey)
            } else {
                try? keyChain.remove(userInfoStorageKey)
            }
        }
    }
    
    var token: String? {
        get { return _token }
        set {
            _token = newValue
            let keyChain = Keychain()
            if let newValue = newValue {
                keyChain[userTokenStorageKey] = newValue
            } else {
                try? keyChain.remove(userTokenStorageKey)
            }
        }
    }
    
    private init() {
        let keyChain = Keychain()
        if let data = try? keyChain.getData("key"),
            let userData = data,
            let user = try? JSONDecoder().decode(User.self, from: userData) {
            _user = user
        }
        if let token = keyChain[userTokenStorageKey] {
            _token = token
        }
    }
    
    
    func logout() {
        NotificationCenter.default.post(name: NSNotification.Name.UserShouldLogout, object: nil)
        token = nil
        user = nil
    }
}
