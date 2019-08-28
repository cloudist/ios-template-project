//
//  Application.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import Bugly
import SwifterSwift

final class Application {
    static let shared = Application()
    
    var window: UIWindow!
    
    let dataRepository: DataRepository
    
    let authManager: AuthManager
    
    init() {
        self.authManager = AuthManager.shared
        self.dataRepository = DataRepository.shared
        
        _ = authManager.tokenChanged.subscribe(onNext: { [weak self] (token) in
            if let window = self?.window, token == nil || token?.isValid == true {
                self?.presentInitialScreen(in: window)
            }
        })
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        
        if let user = User.currentUser() {
            Bugly.setUserIdentifier(user.id.string)
        }
        
        let loggedIn = authManager.hasToken

        let dataRepository = Application.shared.dataRepository
        var vc: UIViewController
        if loggedIn {
            let viewModel = HomeTabBarViewModel(dataRepository: dataRepository)
            vc = HomeTabBarController(viewModel: viewModel)
        } else {
            let viewModel = LoginViewModel(dataRepository: dataRepository)
            vc = LoginViewController(viewModel: viewModel)
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.window.rootViewController = vc
        }, completion: nil)
    }
    
    func logout() {
        AuthManager.removeToken()
        let viewModel = LoginViewModel(dataRepository: dataRepository)
        let vc = LoginViewController(viewModel: viewModel)
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.window.rootViewController = vc
        }, completion: nil)
    }
}
