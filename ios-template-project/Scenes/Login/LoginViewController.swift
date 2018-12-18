//
//  LoginViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/17.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import SnapKit
import Action

class LoginViewController: BaseViewController {
    
    lazy var username: UITextField = {
        let field = UITextField()
        field.placeholder = "username"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        return field
    }()
    
    lazy var password: UITextField = {
        let field = UITextField()
        field.placeholder = "password"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        return field
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("登录", for: .normal)
        return btn
    }()
    
//    private var viewModel: LoginViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func addSubviews() {
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(loginBtn)
    }

    func addConstrants() {
        username.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(44)
        }
        
        password.snp.makeConstraints { (make) in
            make.top.equalTo(username.snp.bottom).inset(30)
            make.left.right.height.equalTo(username)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).inset(30)
            make.left.right.height.equalTo(username)
        }
    }
    
    func bindViewModel() {
//        loginBtn.rx.
    }
}
