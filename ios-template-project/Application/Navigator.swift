//
//  Navigator.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Hero
import SwifterSwift

protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {
    static var `default` = Navigator()
    
    // MARK: - segues list, all app scenes
    enum Scence {
        case tabBar(viewModel: HomeTabBarViewModel)
        case login(viewModel: LoginViewModel)
        case sample(viewModel: SampleViewModel)
    }
    
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
    
    // MARK: - get a single VC
    func get(segue: Scence) -> UIViewController? {
        switch segue {
        case .tabBar(let viewModel):
            let tabbar = HomeTabBarController(navigator: self, viewModel: viewModel)
            return tabbar
        case .login(let viewModel):
            let loginVC = LoginViewController()
            loginVC.viewModel = viewModel
            return loginVC
        case .sample(let viewModel):
            let sampleVC = SampleViewController()
            print("isViewLoaded: \(sampleVC.isViewLoaded)")
            sampleVC.navigator = self
            sampleVC.viewModel = viewModel
            return sampleVC
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
    
    func injectTabBarController(in target: UITabBarController) {
        if let children = target.viewControllers {
            for vc in children {
                injectNavigator(in: vc)
            }
        }
    }
    
    func show(segue: Scence, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
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
            if let nav = sender.navigationController {
                //add controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .customModal(type: let type):
            //present modally with custom animation
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true, completion: nil)
            }
        case .modal:
            //present modally
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }
    
    private func injectNavigator(in target: UIViewController) {
        // view controller
        if var target = target as? Navigatable {
            target.navigator = self
        }
        
        // navigation controller
        if let target = target as? UINavigationController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
        
        // split controller
        if let target = target as? UISplitViewController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
    }
}
