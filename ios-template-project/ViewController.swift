//
//  ViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/6.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import UIFontComplete
import NVActivityIndicatorView

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
        
        let x: String = Bundle.main[Constant.baseURL]
        print(x)
//        let font = CustomFont.consolas.of(size: 22.0)
//        let font = R.font.consolas(size: 22)


        view.showLoading(title: "加载中...")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.view.hideLoading()
        }
        
//        view.showInfo(title: "title", subtitle: "subtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitle", duration: 5)
//        view.showSuccess(title: "录入成功")
//        view.showError(title: "录入失败", duration: 5)
        
    }

}
