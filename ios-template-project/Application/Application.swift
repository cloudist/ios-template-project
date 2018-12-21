//
//  Application.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import Bugly

final class Application {
    static let shared = Application()
    
    var window: UIWindow!
    
    let dataRepository: DataRepository
    
    let authManager: AuthManager
    let navigator: Navigator
    
    init() {
        self.navigator = Navigator.default
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
        if loggedIn {
            let viewModel = HomeTabBarViewModel(dataRepository: dataRepository)
            navigator.show(segue: .tabBar(viewModel: viewModel), sender: nil, transition: .root(in: window))
        } else {
            let viewModel = LoginViewModel(dataRepository: dataRepository)
            navigator.show(segue: .login(viewModel: viewModel), sender: nil, transition: .root(in: window))
        }
    }
}
