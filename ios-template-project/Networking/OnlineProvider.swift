//
//  OnlineProvider.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Moya
import Result

class OnlineProvider<Target> where Target: Moya.TargetType {
    fileprivate let online: Observable<Bool>
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = connectedToInternet) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
        self.online = online
    }
}

extension OnlineProvider {
    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online
            .ignore(false) // Wait until we're online
            .take(1) // Take 1 to make sure we only invoke the API once.
            .flatMap { _ in
                return actualRequest
                    .filterSuccessfulStatusAndRedirectCodes()
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                    .observeOn(MainScheduler.instance)
                    .do(onError: { (error) in
                        if let e = error as? MoyaError,
                            case let .statusCode(response) = e,
                            response.statusCode == 401 {
                            AuthManager.removeToken()
                        }
                    })
        }
    }
    
    func requestWithProgress(_ token: Target) -> Observable<ProgressResponse> {
        let actualRequest = provider.rx.requestWithProgress(token)
        return online
            .ignore(false)
            .take(1)
            .flatMap { _ in
                return actualRequest
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                    .observeOn(MainScheduler.instance)
                    .do(onError: { (error) in
                        if let e = error as? MoyaError,
                            case let .statusCode(response) = e,
                            response.statusCode == 401 {
                            AuthManager.removeToken()
                        }
                    })
        }
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    let path = Bundle.main.path(forResource: filename, ofType: "json")!
    return try? Data(contentsOf: URL(fileURLWithPath: path))
}

extension TargetType {
    var asMultiTarget: MultiTarget {
        return .target(self)
    }
}
