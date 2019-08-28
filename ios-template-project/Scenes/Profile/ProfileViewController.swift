//
//  ProfileViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/21.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {
    
    var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .system)
        btn.backgroundColor = .blue
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(btn)
        
        btn.rx.tap
            .asObservable()
            .subscribe(onNext: { _ in
                Application.shared.logout()
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func makeUI() {
        view.backgroundColor = .white
    }
}
