//
//  UITableView+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/27.
//

import UIKit

extension Extensible where Base: UITableView {
    public func register<T: UITableViewCell>(cell: T.Type) {
        base.register(cell, forCellReuseIdentifier: cell.description())
    }
    
    public func register<T: UITableViewHeaderFooterView>(view: T.Type) {
        base.register(view, forHeaderFooterViewReuseIdentifier: view.description())
    }
    
    public func dequeuReuse<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return base.dequeueReusableCell(withIdentifier: cell.description(), for: indexPath) as! T
        // swiftlint:enable force_cast
    }
    
    public func dequeuReuse<T: UITableViewCell>(cell: T.Type) -> T? {
        return base.dequeueReusableCell(withIdentifier: cell.description()) as? T
    }
    
    public func dequeuReuse<T: UITableViewHeaderFooterView>(view: T.Type) -> T {
        // swiftlint:disable force_cast
        return base.dequeueReusableHeaderFooterView(withIdentifier: view.description()) as! T
        // swiftlint:enable force_cast
    }
}
