//
//  NetworkErrorHandlerPlugin.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Moya
import Result

extension Notification.Name {
    static let NetworkErrorNotification = Notification.Name.init("NetworkErrorNotification")
}

final class NetworkErrorHandlerPlugin: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard case Result.failure(let error) = result else { return }
        guard case MoyaError.underlying(let e, _) = error else { return }
        
        let nserror = e as NSError
        
        switch nserror.code {
        case NSURLErrorCancelled,
             NSURLErrorTimedOut,
             NSURLErrorCannotFindHost,
             NSURLErrorCannotConnectToHost,
             NSURLErrorNetworkConnectionLost,
             NSURLErrorDNSLookupFailed,
             NSURLErrorNotConnectedToInternet:
            NotificationCenter.default.post(name: Notification.Name.NetworkErrorNotification, object: ["code": nserror.code])
        default:
            break
        }
    }
}
