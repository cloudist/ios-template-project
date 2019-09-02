//
//  SampleViewModel.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/21.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxMJ

class SampleViewModel: ViewModel {
    
    let tableData = BehaviorRelay<[String]>(value: [])
    
    override init(dataRepository: DataRepository) {
        super.init(dataRepository: dataRepository)
        let headerData = headerRefreshTrigger
            .flatMapLatest {
                return Observable
                    .just(["1", "2", "3"])
                    .trackError(self.error)
                    .trackActivity(self.headerLoading)
                    .catchErrorJustComplete()
            }.share(replay: 1)
        
        let footerData = footerRefreshTrigger
            .flatMapLatest {
                return Observable.just(["1", "2", "3"])
                    .trackError(self.error)
                    .catchErrorJustComplete()
            }.share(replay: 1)
        
        
        headerData.bind(to: tableData).disposed(by: disposeBag)
        footerData.map { self.tableData.value + $0 }.bind(to: tableData).disposed(by: disposeBag)
        
        let state = Observable
            .merge(headerData.mapTo(()).map(footerStateFromPageParam), footerData.mapTo(()).map(footerStateFromPageParam))
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
        
        state.drive(footerState).disposed(by: disposeBag)
        
        
    }
    
}
