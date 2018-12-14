//
//  HUDAnimating.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/14.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

protocol HUDAnimating: AnyObject {
    func startAnimation()
    func stopAnimation()
}

extension HUDAnimating {
    func stopAnimation() {}
}
