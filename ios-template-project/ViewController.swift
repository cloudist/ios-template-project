//
//  ViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/6.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import UIFontComplete

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        #if ADHOC
        print("adhoc")
        #elseif DEBUG
        print("debug")
        #else
        print("release")
        #endif
        
        
//        let font = CustomFont.consolas.of(size: 22.0)
        let font = R.font.consolas(size: 22)
        let label = UILabel()
        label.font = font
        label.textColor = .black
        label.text = "google"
        label.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
        view.addSubview(label)
        
        
    }

}
