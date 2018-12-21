//
//  HomeTabBarViewModel.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/21.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum TabbarItem: CaseIterable {
    case sample
    case profile
}

class HomeTabBarViewModel: ViewModel, ViewModelType {
    struct Input {
        var viewDidAppear: Observable<Void>
    }
    
    struct Output {
        var tabBarItems: Driver<[TabbarItem]>
    }
    
    func transform(input: HomeTabBarViewModel.Input) -> HomeTabBarViewModel.Output {
        let items = input.viewDidAppear
            .map { _ in
                return TabbarItem.allCases
            }
            .asDriver(onErrorJustReturn: [])
        return Output(tabBarItems: items)
    }
    
    func viewModel(for tabBarItem: TabbarItem) -> ViewModel {
        switch tabBarItem {
        case .sample:
            return SampleViewModel(dataRepository: dataRepository)
        case .profile:
            return ProfileViewModel(dataRepository: dataRepository)
        }
    }
}
