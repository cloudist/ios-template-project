//
//  DataRepository.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Moya

let ApiServiceProvider = MoyaProvider<MultiTarget>(manager: NetworkConfig.manager, plugins: NetworkConfig.endPointPlugins)

class DataRepository {
    static let shared = DataRepository()
    
    private init() {}
}

extension DataRepository {
    
}
