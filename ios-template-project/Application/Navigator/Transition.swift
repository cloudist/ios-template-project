//
//  Transition.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/29.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import UIKit
import Hero

extension Navigator {
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case custom
    }
    
    func show(segue: Scence, sender: UIViewController?, transition: Transition = .navigation(type: .push(direction: .left))) {
        guard let target = get(segue: segue) else { return }
        show(target: target, sender: sender, transition: transition)
    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        injectNavigator(in: target)
        
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        case .custom: return
        default: break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
            return
        }
        
        switch transition {
        case .navigation(type: let type):
            guard let nav = sender.navigationController else {
                assertionFailure("\(sender) has no navigationController")
                return
            }
            target.hidesBottomBarWhenPushed = true
            nav.hero.navigationAnimationType = .autoReverse(presenting: type)
            nav.pushViewController(target, animated: true)
        case .customModal(type: let type):
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true, completion: nil)
            }
        case .modal:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                 nav.hero.modalAnimationType = .autoReverse(presenting: .cover(direction:.up))
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        default: break
        }
    }
    
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController()
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
