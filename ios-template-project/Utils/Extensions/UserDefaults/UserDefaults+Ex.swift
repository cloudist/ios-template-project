//
//  UserDefaults+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/29.
//

import Foundation

extension Extensible where Base: UserDefaults {
    public subscript(key: String) -> Any? {
        get {
            return base.object(forKey: key)
        }
        set {
            base.set(newValue, forKey: key)
        }
    }
    
    public func float(forKey key: String) -> Float? {
        return base.object(forKey: key) as? Float
    }
    
    public func date(foKey key: String) -> Date? {
        return base.object(forKey: key) as? Date
    }
    
    public func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = base.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    @discardableResult
    public func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) -> Bool {
        guard let data = try? encoder.encode(object) else { return false }
        base.set(data, forKey: key)
        return true
    }
}
