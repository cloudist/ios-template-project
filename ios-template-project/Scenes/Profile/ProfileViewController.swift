//
//  ProfileViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/21.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {
    
    var viewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .system)
        btn.backgroundColor = .blue
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(btn)
        
        btn.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                let viewModel = LoginViewModel(dataRepository: self.viewModel.dataRepository)
                self.navigator.show(segue: .login(viewModel: viewModel), sender: self)
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
