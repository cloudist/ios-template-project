//
//  ViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/6.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        #if ADHOC
        print("ADHOC")
        #else
        print("other")
        #endif
    }


}
