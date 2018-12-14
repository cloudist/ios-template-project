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

public class NetworkConfig {
    public static var `default`: NetworkConfig = NetworkConfig()
    
    var baseURL: URL = URL(string: Bundle.main[.baseURL])!
    var timeoutInterval: TimeInterval = 60
    var contentType: String = "Content-Type"

    lazy var plugins: [PluginType] = {
        let errorHandler = NetworkErrorHandlerPlugin()
        let logger = NetworkLoggerPlugin(verbose: true)
        let authorization = AccessTokenPlugin(tokenClosure: {
            return UserManager.shared.token ?? ""
        })
        return [errorHandler, logger, authorization]
    }()

    func sessionManager(enableSSL: Bool) -> SessionManager {
        let config = URLSessionConfiguration.default
        let manager: SessionManager
        if enableSSL {
            var policies: [String: ServerTrustPolicy] = [:]
            if let host = URL(string: Bundle.main[.baseURL])?.host {
                policies = [host: pinCertificatesPolicy]
            }
            manager = SessionManager(configuration: config,
                                     serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
        } else {
            manager = SessionManager(configuration: config)
        }

        return manager
    }

    /// SSL
    lazy var pinCertificatesPolicy: ServerTrustPolicy = {
        return ServerTrustPolicy.pinCertificates(certificates: ServerTrustPolicy.certificates(), validateCertificateChain: true, validateHost: true)
    }()
}
