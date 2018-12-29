//
//  NavigationController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import Hero

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topViewController = topViewController {
            return topViewController.preferredStatusBarStyle
        }
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hero.isEnabled = true

        navigationBar.backIndicatorImage = R.image.back()
        navigationBar.backIndicatorTransitionMaskImage = R.image.back()
    }
}
