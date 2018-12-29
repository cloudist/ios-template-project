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
    var disposeBag = DisposeBag()
    
    var page = 1
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let headerLoading = ActivityIndicator()
    let footerState = BehaviorRelay(value: RxMJRefreshFooterState.default)
    
    let error = ErrorTracker()
    let loading = ActivityIndicator()
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
    }
    
    deinit {
        logDebug("\(type(of: self)): deinited")
    }
    
}

extension ViewModel {
    func footerState<T>(_ items: [T]) -> RxMJRefreshFooterState {
        return items.count < 20 ? .noMoreData : .default
    }
}
