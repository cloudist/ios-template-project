//
//  UIView+HUD.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/13.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import MBProgressHUD

public protocol HUDDisplayable where Self: UIView {
    func showLoading(title: String?)
    func hideLoading()
    func showInfo(title: String?, subtitle: String?, duration: TimeInterval)
    func showSuccess(title: String?, duration: TimeInterval)
    func showError(title: String?, duration: TimeInterval)
}

extension UIView: HUDDisplayable {
    public func showLoading(title: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView
        hud.customView = NVActivityIndicatorViewWrapperView(intrinsicSize: CGSize(width: 100, height: 100), type: .audioEqualizer)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = .clear
        hud.label.text = title
        hud.animationType = .zoom
    }
    
    public func hideLoading() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    public func showSuccess(title: String? = nil, duration: TimeInterval = 1.5) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView
        hud.customView = HUDSuccessView(intrinsicSize: CGSize(width: 100, height: 100))
        hud.label.text = title
        hud.animationType = .zoom
        hud.hide(animated: true, afterDelay: duration)
    }
    
    public func showError(title: String? = nil, duration: TimeInterval = 1.5) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView
        hud.customView = HUDErrorView(intrinsicSize: CGSize(width: 100, height: 100))
        hud.label.text = title
        hud.animationType = .zoom
        hud.hide(animated: true, afterDelay: duration)
    }
    
    public func showInfo(title: String? = nil, subtitle: String? = nil, duration: TimeInterval = 1.5) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.minShowTime = 1
        hud.minSize = CGSize(width: 100, height: 100)
        hud.mode = .text
        hud.label.text = title
        
        hud.detailsLabel.text = subtitle
        hud.detailsLabel.numberOfLines = 0
        
        hud.animationType = .zoom
        hud.hide(animated: true, afterDelay: duration)
    }
}
