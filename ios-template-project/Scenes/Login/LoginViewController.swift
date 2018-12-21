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

class LoginViewController: ViewController {
    
    lazy var username: UITextField = {
        let field = UITextField()
        field.placeholder = "username"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .roundedRect
        return field
    }()
    
    lazy var password: UITextField = {
        let field = UITextField()
        field.placeholder = "password"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .roundedRect
        return field
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(loginBtn)
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

    override func updateUI() {
        
    }
    
    override func bindViewModel() {
        
        let input = LoginViewModel.Input(username: username.rx.text.orEmpty,
                                         password: password.rx.text.orEmpty,
                                         loginAction: loginBtn.rx.tap)
        
        let out = viewModel.transform(input: input)
        out.loginBtnEnabled.drive(loginBtn.rx.isEnabled).disposed(by: rx.disposeBag)
        
        viewModel.loading.asDriver()
            .drive(onNext: { [weak self] (loading) in
                loading ? self?.startAnimating() : self?.stopAnimating()
            }).disposed(by: rx.disposeBag)
        
        loginBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] () in
                self?.view.endEditing(true)
            }).disposed(by: rx.disposeBag)
        
        viewModel.error.asDriver().drive(onNext: { (error) in
            
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
}
