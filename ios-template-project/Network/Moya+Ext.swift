//
//  Moya+Ext.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/13.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Moya

extension MoyaProvider {
    convenience init(configuration: NetworkConfig) {
        
        let requestClosure = { (endpoint: Endpoint, closure: RequestResultClosure) in
            do {
                var urlRequest = try endpoint.urlRequest()
                urlRequest.addValue(configuration.contentType, forHTTPHeaderField: "Content-Type")
                urlRequest.timeoutInterval = configuration.timeoutInterval
                closure(.success(urlRequest))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }

        self.init(requestClosure: requestClosure, manager: configuration.sessionManager(enableSSL: false), plugins: configuration.plugins)
    }
}
