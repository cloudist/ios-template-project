//
//  LoginViewModel.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/17.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

protocol LoginViewModelInputType {
    var username: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    var loginAction: Action<Void, LoginResponse> { get }
}

enum LoginStatus {
    case idle
    case fetchingToken
    case success
    case failed
}

protocol LoginViewModelOutputType {
    var loginBtnEnabled: Observable<Bool> { get }
    var loginStatus: BehaviorSubject<LoginStatus> { get }
}

protocol LoginViewModelType {
    var input: LoginViewModelInputType { get }
    var output: LoginViewModelOutputType { get }
}

class LoginViewModel: LoginViewModelType, LoginViewModelInputType, LoginViewModelOutputType {
    var loginStatus: BehaviorSubject<LoginStatus>
    var loginBtnEnabled: Observable<Bool>
    
    var disposeBag: DisposeBag
    var username: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var password: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    lazy var loginAction: Action<Void, LoginResponse> = {
        return Action { [unowned self] _ in
            return DataRepository.shared.login(username: self.username.value, password: self.password.value)
        }
    }()
    
    var input: LoginViewModelInputType { return self }
    var output: LoginViewModelOutputType { return self }
    
    init(disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
        
        self.loginBtnEnabled = Observable<Bool>.combineLatest(username.asObservable(), password.asObservable()) { $0.count >= 6 && !$1.isEmpty }.startWith(false)
        
        self.loginStatus = BehaviorSubject<LoginStatus>.init(value: .idle)
        
        self.loginAction.errors
            .subscribe(onNext: { [unowned self] (error) in
                self.loginStatus.onNext(.failed)
            }).disposed(by: disposeBag)
        
        self.loginAction.elements
            .subscribe(onNext: { [unowned self] (loginResponse) in
                UserManager.shared.token = loginResponse.token
                UserManager.shared.user = loginResponse.user
                self.loginStatus.onNext(.success)
            }).disposed(by: disposeBag)
        
        self.loginAction.executing
            .subscribe(onNext: { [unowned self] (executing) in
                self.loginStatus.onNext(executing ? .fetchingToken : .idle)
            }).disposed(by: disposeBag)
    }
}
