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

struct NetworkConfig {
    final class CustomRequestAdapter: RequestAdapter {
        func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("TOKEN", forHTTPHeaderField: "Authorization")
            return urlRequest
        }
    }
    
    static var endPointPlugins: [PluginType] {
        let errorHandler = NetworkErrorHandlerPlugin()
        let logger = NetworkLoggerPlugin(verbose: true)
        return [errorHandler, logger]
    }
    
    static var manager: Alamofire.SessionManager {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForRequest = 15
        let manager = Alamofire.SessionManager(configuration: config)
        manager.adapter = CustomRequestAdapter()
        return manager
    }
}
