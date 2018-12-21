//
//  ViewModel.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxMJ

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel {
    
    let dataRepository: DataRepository
    
    var page = 1
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerStatus = BehaviorRelay(value: RxMJRefreshFooterState.default)
    
    let error = ErrorTracker()
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
    }
    
    deinit {
        logDebug("\(type(of: self)): deinited")
    }
    
}
