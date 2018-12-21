//
//  Reachability.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Reachability
import RxSwift

var connectedToInternet: Observable<Bool> {
    return ReachabilityManager.shared.reach
}

class ReachabilityManager {
    static let shared = ReachabilityManager()
    
    private let reachability = Reachability()
    
    private let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return _reach.asObservable()
    }
    
    init() {
        reachability?.whenReachable = { reachability in
            DispatchQueue.main.async {
                self._reach.onNext(true)
            }
        }
        
        reachability?.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    self._reach.onNext(false)
                }
            }
        }
        
        do {
            try reachability?.startNotifier()
            _reach.onNext(reachability?.connection != .none)
        } catch {
            logError("Unable to start notifier")
        }
    }
}
