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
import RxSwiftExt

class LoginViewModel: ViewModel, ViewModelType {
    
    struct Input {
        var username: ControlProperty<String>
        var password: ControlProperty<String>
        var loginAction: ControlEvent<Void>
    }
    
    struct Output {
        var loginBtnEnabled: Driver<Bool>
    }
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        
        let usernamePassword = Observable.combineLatest(input.username, input.password) { ($0, $1) }

        input.loginAction
            .withLatestFrom(usernamePassword)
            .flatMapLatest { (tuple) in
                self.dataRepository.login(username: tuple.0, password: tuple.1)
                    .trackError(self.error)
                    .trackActivity(self.loading)
                    .catchErrorJustComplete()
            }
            .subscribe(onNext: { (loginResponse) in
                AuthManager.setToken(token: Token(basicToken: loginResponse.token, isValid: true))
                loginResponse.user.save()
            }).disposed(by: disposeBag)
        
        let loginBtnEnable = Observable
            .combineLatest(input.username, input.password) {
                $0.count >= 1 && $1.count >= 1
            }
            .startWith(false)
            .asDriver(onErrorJustReturn: false)
        return Output(loginBtnEnabled: loginBtnEnable)
    }
}
