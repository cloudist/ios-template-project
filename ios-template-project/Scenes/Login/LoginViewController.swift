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
import NSObject_Rx

class LoginViewController: BaseViewController {
    
    lazy var username: UITextField = {
        let field = UITextField()
        field.placeholder = "username"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .bezel
        return field
    }()
    
    lazy var password: UITextField = {
        let field = UITextField()
        field.placeholder = "password"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .bezel
        return field
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    
    private lazy var viewModel: LoginViewModel = {
        return LoginViewModel(disposeBag: rx.disposeBag)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addSubviews() {
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(loginBtn)
    }

    override func addConstrants() {
        username.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(44)
        }
        
        password.snp.makeConstraints { (make) in
            make.top.equalTo(username.snp.bottom).offset(30)
            make.left.right.height.equalTo(username)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(30)
            make.left.right.height.equalTo(username)
        }
    }
    
    override func bindViewModel() {
        username.rx.text.orEmpty.bind(to: viewModel.input.username).disposed(by: rx.disposeBag)
        password.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: rx.disposeBag)
        loginBtn.rx.bind(to: viewModel.input.loginAction, input: ())
        
        viewModel.loginBtnEnabled.bind(to: loginBtn.rx.isEnabled).disposed(by: rx.disposeBag)
        viewModel.loginStatus.subscribe(onNext: { (status) in
            switch status {
            case .idle: break
            case .fetchingToken: break
            case .failed: break
            case .success: break
            }
        }).disposed(by: rx.disposeBag)
    }
}
