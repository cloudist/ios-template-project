//
//  User.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import KeychainAccess

private let userkey = "User.CurrentUserKey"

struct User: Codable {
    let id: Int
    let username: String
    let name: String
}

extension User {
    static func currentUser() -> User? {
        if let jsonData = try? Keychain().getData(userkey),
            let user = try? JSONDecoder().decode(User.self, from: jsonData) {
            return user
        }
        return nil
    }
    
    static func removeCurrentUser() {
        try? Keychain().remove(userkey)
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try Keychain().set(data, key: userkey)
        } catch {
            logError("User can't be saved")
        }
    }
    
    func isMe() -> Bool {
        return self == User.currentUser()
    }
    
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
