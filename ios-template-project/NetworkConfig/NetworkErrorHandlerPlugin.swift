//
//  NetworkReachabilityPlugin.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Moya
import Result

extension Notification.Name {
    static let URLErrorUnknown = Notification.Name("URLErrorUnknown")
    static let URLErrorCancelled = Notification.Name("URLErrorCancelled")
    static let URLErrorTimedOut = Notification.Name("URLErrorTimedOut")
    static let URLErrorCannotFindHost = Notification.Name("URLErrorCannotFindHost")
    static let URLErrorCannotConnectToHost = Notification.Name("URLErrorCannotConnectToHost")
    static let URLErrorNetworkConnectionLost = Notification.Name("URLErrorNetworkConnectionLost")
    static let URLErrorDNSLookupFailed = Notification.Name("URLErrorDNSLookupFailed")
    static let URLErrorNotConnectedToInternet = Notification.Name("URLErrorNotConnectedToInternet")

}

final class NetworkErrorHandlerPlugin: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard case Result.failure(let error) = result else { return }
        guard case MoyaError.underlying(let e, _) = error else { return }
        
        let nserror = e as NSError
        let reason: Notification.Name
        switch nserror.code {
        case NSURLErrorCancelled:
            reason = Notification.Name.URLErrorCancelled
        case NSURLErrorTimedOut:
            reason = Notification.Name.URLErrorTimedOut
        case NSURLErrorCannotFindHost:
            reason = Notification.Name.URLErrorCannotFindHost
        case NSURLErrorCannotConnectToHost:
            reason = Notification.Name.URLErrorCannotConnectToHost
        case NSURLErrorNetworkConnectionLost:
            reason = Notification.Name.URLErrorNetworkConnectionLost
        case NSURLErrorDNSLookupFailed:
            reason = Notification.Name.URLErrorDNSLookupFailed
        case NSURLErrorNotConnectedToInternet:
            reason = Notification.Name.URLErrorNotConnectedToInternet
        default:
            reason = Notification.Name.URLErrorUnknown
        }
        
        NotificationCenter.default.post(name: reason, object: ["code": nserror.code])
    }
}
