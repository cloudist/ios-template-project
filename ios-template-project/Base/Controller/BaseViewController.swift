//
//  BaseViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/17.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstrants()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentViewController()
    }
    
}

extension BaseViewController {
    @discardableResult
    func currentViewController() -> String {
        guard let `class` = "\(self)".split(separator: ".").last else {
            return "unknow viewcontroller class"
        }
        
        debugPrint(`class`)
        return String(`class`)
    }
}

extension BaseViewController: ViewControllerCompatible {
    func addSubviews() {}
    func addConstrants() {}
    func bindViewModel() {}
}
