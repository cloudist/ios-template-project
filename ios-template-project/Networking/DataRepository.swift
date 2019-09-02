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

class DataRepository {
    static let shared = DataRepository()
    
    private lazy var apiService: MoyaProvider<MultiTarget> = {
       return NetworkConfig.provider()
    }()
    
    private init() {}
}

extension DataRepository {
    func login(username: String, password: String) -> Observable<LoginResponse> {
        return apiService.rx.request(Account.login(param: ["userIdentity": username, "password": password]).asMultiTarget)
            .asObservable()
            .authHandler() 
            .filterSuccessfulStatusAndRedirectCodes()
            .map(LoginResponse.self)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
    
    }
}
