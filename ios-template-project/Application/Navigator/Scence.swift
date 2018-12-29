//
//  Scence.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/29.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import UIKit

extension Navigator {
    // MARK: - segues list, all app scenes
    enum Scence {
        case tabBar(viewModel: HomeTabBarViewModel)
        case login(viewModel: LoginViewModel)
        case sample(viewModel: SampleViewModel)
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
            sampleVC.navigator = self
            sampleVC.viewModel = viewModel
            return sampleVC
        }
    }
}
