//
//  UIViewControllerHUD+Rx.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/14.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var showLoading: Binder<(String?, String?)> {
        return Binder(base) { (target, data) in
            switch data {
            case let (title?, subtitle?):
                target.showLoading(title: title, subtitle: subtitle)
            case let (title?, nil):
                target.showLoading(title: title)
            case let (nil, subtitle?):
                target.showLoading(subtitle: subtitle)
            case (nil, nil):
                target.showLoading()
            }
        }
    }
    
    public var hideLoading: Binder<Void> {
        return Binder(base) { (target, _) in
            target.hideLoading()
        }
    }
    
    public var loading: Binder<Bool> {
        return Binder(base) { (target, show) in
            show ? target.showLoading() : target.hideLoading()
        }
    }
    
    public var showSuccess: Binder<(String?, String?, TimeInterval?)> {
        return Binder(base) { (target, data) in
            switch data {
            case let (title?, subtitle?, interval?):
                target.showSuccess(title: title, subtitle: subtitle, duration: interval)
            case let (title?, subtitle?, nil):
                target.showSuccess(title: title, subtitle: subtitle)
            case let (title?, nil, interval?):
                target.showSuccess(title: title, duration: interval)
            case let (title?, nil, nil):
                target.showSuccess(title: title)
            case let (nil, subtitle?, interval?):
                target.showSuccess(subtitle: subtitle, duration: interval)
            case let (nil, nil, interval?):
                target.showSuccess(duration: interval)
            case let (nil, subtitle?, nil):
                target.showSuccess(subtitle: subtitle)
            case (nil, nil, nil):
                target.showSuccess()
            }
        }
    }
    
    public var showError: Binder<(String?, String?, TimeInterval?)> {
        return Binder(base) { (target, data) in
            switch data {
            case let (title?, subtitle?, interval?):
                target.showError(title: title, subtitle: subtitle, duration: interval)
            case let (title?, subtitle?, nil):
                target.showError(title: title, subtitle: subtitle)
            case let (title?, nil, interval?):
                target.showError(title: title, duration: interval)
            case let (title?, nil, nil):
                target.showError(title: title)
            case let (nil, subtitle?, interval?):
                target.showError(subtitle: subtitle, duration: interval)
            case let (nil, nil, interval?):
                target.showError(duration: interval)
            case let (nil, subtitle?, nil):
                target.showError(subtitle: subtitle)
            case (nil, nil, nil):
                target.showError()
            }
        }
    }
    
    public var showInfo: Binder<(String, String?, TimeInterval?)> {
        return Binder(base) { (target, data) in
            switch data {
            case let (title, subtitle?, interval?):
                target.showInfo(title: title, subtitle: subtitle, duration: interval)
            case let (title, subtitle?, nil):
                target.showInfo(title: title, subtitle: subtitle)
            case let (title, nil, interval?):
                target.showInfo(title: title, duration: interval)
            case let (title, nil, nil):
                target.showInfo(title: title)
            }
        }
    }
}
