//
//  DataRepository.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension TargetType {
    func request() -> Single<Moya.Response> {
        return DataRepository.shared.apiService.rx.request(.target(self))
    }
    
    func requestWithProgress() -> Observable<Moya.ProgressResponse> {
        return DataRepository.shared.apiService.rx.requestWithProgress(.target(self))
    }
}

class DataRepository {
    static let shared = DataRepository()
    
    lazy var apiService: MoyaProvider<MultiTarget> = {
        return MoyaProvider<MultiTarget>(configuration: NetworkConfig.default)
    }()
    
    private init() {}
}

extension DataRepository {
    func login(username: String, password: String) -> Observable<User> {
        return Account.login(param: ["username": username, "password": password])
            .request()
            .asObservable()
            .filterSuccessfulStatusAndRedirectCodes()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .map(User.self)
    }
}
