//
//  ViewControllerCompatible.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/17.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

protocol ViewControllerCompatible where Self: UIViewController {
    func addSubviews()
    func addConstrants()
    func bindViewModel()
}

extension ViewControllerCompatible {
    func addSubviews() {}
    func addConstrants() {}
    func bindViewModel() {}
}
