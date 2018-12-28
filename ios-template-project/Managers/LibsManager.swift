//
//  LibsManager.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import CocoaLumberjack
import Bugly

class LibsManager {
    static let shared = LibsManager()
    
    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupSDWebImage()        
        libsManager.setupKeyboardManager()
        libsManager.setupBugly()
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }
    
    func setupSDWebImage() {
        SDWebImageDownloader.shared().downloadTimeout = 15
    }
    
    func setupCocoaLumberjack() {
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        //        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    func setupBugly() {
        let config = BuglyConfig()
        config.blockMonitorEnable = true
        config.blockMonitorTimeout = 3.0
        config.reportLogLevel = .warn
        Bugly.start(withAppId: ConfigItems.buglyAppId, config: config)
    }
}
