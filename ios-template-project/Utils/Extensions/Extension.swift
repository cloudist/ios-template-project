//
//  Extensible.swift
//  Extensibles
//
//  Created by liubo on 2018/8/27.
//

import Foundation

public struct Extensible<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ExtensibleCompatible {
    associatedtype CompatibleType
    
    static var ext: Extensible<CompatibleType>.Type { get set }
    var ext: Extensible<CompatibleType> { get set }
}

extension ExtensibleCompatible {
    public static var ext: Extensible<Self>.Type {
        get {
            return Extensible<Self>.self
        }
        set {
            // this enables using Extensible to "mutate" base type
        }
    }
    
    public var ext: Extensible<Self> {
        get {
            return Extensible(self)
        }
        set {
            // this enables using Extensible to "mutate" base object
        }
    }
}

import class Foundation.NSObject

extension NSObject: ExtensibleCompatible {}
