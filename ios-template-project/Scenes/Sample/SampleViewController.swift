//
//  SampleViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/21.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import RxViewController
import RxSwift

class SampleViewController: ViewController {

    var viewModel: SampleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
}
