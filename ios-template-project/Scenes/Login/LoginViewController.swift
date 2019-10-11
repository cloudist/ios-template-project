//
//  LoginViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/17.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import SnapKit
import NSObject_Rx

class LoginViewController: ViewController {
    
    lazy var username: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.localizable.loginUsername.key.localized()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .roundedRect
        return field
    }()
    
    lazy var password: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.localizable.loginPassword.key.localized()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        return field
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(R.string.localizable.loginLoginBtnTitle.key.localized(),
                     for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    
    var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

        viewModel.loading.skip(1).asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        
        loginBtn.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] () in
                self?.view.endEditing(true)
            }).disposed(by: rx.disposeBag)
        
        viewModel.error
            .map { $0.resolve() }
            .drive(rx.showError)
            .disposed(by: rx.disposeBag)
    }
}
