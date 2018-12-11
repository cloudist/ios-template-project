//
//  UICollectionView+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/27.
//

import UIKit

extension Extensible where Base: UICollectionView {
    public func register<T: UICollectionViewCell>(cell: T.Type) {
        base.register(cell, forCellWithReuseIdentifier: cell.description())
    }
    
    public func register<T: UICollectionReusableView>(view: T.Type, kind: String) {
        base.register(view, forSupplementaryViewOfKind: kind, withReuseIdentifier: view.description())
    }
    
    public func dequeuReuse<T: UICollectionViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return base.dequeueReusableCell(withReuseIdentifier: cell.description(), for: indexPath) as! T
        // swiftlint:enable force_cast
    }
    
    public func dequeuReuse<T: UICollectionReusableView>(view: T.Type, kind: String, indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return base.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: view.description(), for: indexPath) as! T
        // swiftlint:enable force_cast
    }
}
