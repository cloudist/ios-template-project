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
    static let timeoutInterval: TimeInterval = 15
    static let contentType: String = "application/json"
}

public struct NetworkConfig {
    static func provider() -> MoyaProvider<MultiTarget> {
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
    
        return MoyaProvider(endpointClosure: endPointClosure,
                            requestClosure: requestClosure,
                            manager: manager,
                            plugins: plugins)
    }

    static func stubbingProvider() -> MoyaProvider<MultiTarget> {
        return MoyaProvider(stubClosure: { _ in .immediate })
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

extension MultiTarget: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType {
        if case let MultiTarget.target(target) = self {
            return (target as? AccessTokenAuthorizable)?.authorizationType ?? .none
        }
        return .none
    }
}


extension Observable {
    func authHandler() -> Observable<E> {
        return self.do(onError: { (error) in
            if let e = error as? MoyaError,
                case let .statusCode(response) = e,
                response.statusCode == 401 {
                AuthManager.removeToken()
            }
        })
    }
}
