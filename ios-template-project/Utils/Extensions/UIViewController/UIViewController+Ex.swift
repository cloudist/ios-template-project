//
//  UIViewController+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/28.
//

import UIKit

extension Extensible where Base: UIViewController {
    public var isVisible: Bool {
        return base.isViewLoaded && base.view.window != nil
    }
    
    @discardableResult
    public func showAlert(title: String?,
                          message: String?,
                          buttonTitles: [String]? = nil,
                          highlightedButtonIndex: Int? = nil,
                          completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.isEmpty {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        base.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    public func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        base.addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: base)
    }
    
    public func removeViewAndControllerFromParentViewController() {
        guard base.parent != nil else { return }
        base.willMove(toParent: nil)
        base.removeFromParent()
        base.view.removeFromSuperview()
    }
}
