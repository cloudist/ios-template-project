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
    
    var page: Int?
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let headerLoading = ActivityIndicator()
    let footerState = BehaviorRelay(value: RxMJRefreshFooterState.hidden)
    
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
    func footerStateFromPageParam() -> RxMJRefreshFooterState {
        return page == nil ? .noMoreData : .default
    }
}
