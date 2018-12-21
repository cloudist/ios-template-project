//
//  NetworkConfig.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift

struct NetworkingConstant {
    static let baseURL: URL = URL(string: ConfigItems.baseURL)!
    static let timeoutInterval: TimeInterval = 60
    static let contentType: String = "application/json"
}

public struct NetworkConfig {
    static func provider() -> OnlineProvider<MultiTarget> {
        let endPointClosure = { (target: TargetType) -> Endpoint in
            let url = target.baseURL.absoluteString + target.path
            let endpoint = Endpoint(url: url,
                                    sampleResponseClosure: {
                                        .networkResponse(200, target.sampleData)
            },
                                    method: target.method,
                                    task: target.task,
                                    httpHeaderFields: target.headers)
            return endpoint
        }
        
        let requestClosure = { (endpoint: Endpoint, closure: MoyaProvider.RequestResultClosure) in
            do {
                var urlRequest = try endpoint.urlRequest()
//                urlRequest.addValue(NetworkingConstant.contentType, forHTTPHeaderField: "Content-Type")
                urlRequest.timeoutInterval = NetworkingConstant.timeoutInterval
                closure(.success(urlRequest))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
        
        let manager = MoyaProvider<MultiTarget>.defaultAlamofireManager()
        
        /// SSL
//        let manager = SessionManager(configuration: URLSessionConfiguration.default,
//                                     serverTrustPolicyManager: ServerTrustPolicyManager(policies: [NetworkingConstant.baseURL.host! : ServerTrustPolicy.pinCertificates(certificates: ServerTrustPolicy.certificates(), validateCertificateChain: true, validateHost: true)]))
        
        let plugins: [PluginType] = {
            let logger = NetworkLoggerPlugin(verbose: true)
            let authorization = AccessTokenPlugin(tokenClosure: {
                return AuthManager.shared.token?.basicToken ?? ""
            })
            return [logger, authorization]
        }()
    
        return OnlineProvider(endpointClosure: endPointClosure,
                              requestClosure: requestClosure,
                              manager: manager,
                              plugins: plugins,
                              online: connectedToInternet)
    }

    static func stubbingProvider() -> OnlineProvider<MultiTarget> {
        return OnlineProvider(stubClosure: { _ in .immediate }, online: .just(true))
    }
}
