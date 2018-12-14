//
//  UIViewHUD+Rx.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/14.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: HUDDisplayable {
    public var showLoading: Binder<String?> {
        return Binder(base) { (target, title) in
            target.showLoading(title: title)
        }
    }
    
    public var hideLoading: Binder<Void> {
        return Binder(base) { (target, _) in
            target.hideLoading()
        }
    }
    
    public var loading: Binder<Bool> {
        return Binder.init(base) { (target, show) in
            show ? target.showLoading() : target.hideLoading()
        }
    }
    
    public var showSuccess: Binder<(String?, TimeInterval?)> {
        return Binder(base) { (target, data) in
            if let timeInterval = data.1 {
                target.showSuccess(title: data.0, duration: timeInterval)
            } else {
                target.showError(title: data.0)
            }
        }
    }
    
    public var showError: Binder<(String?, TimeInterval?)> {
        return Binder(base) { (target, data) in
            if let timeInterval = data.1 {
                target.showError(title: data.0, duration: timeInterval)
            } else {
                target.showError(title: data.0)
            }
        }
    }
    
    public var showInfo: Binder<(String?, String?, TimeInterval?)> {
        return Binder(base) { (target, data) in
            if let timeInterval = data.2 {
                target.showInfo(title: data.0, subtitle: data.1, duration: timeInterval)
            } else {
                target.showInfo(title: data.0, subtitle: data.1)
            }
        }
    }
}
