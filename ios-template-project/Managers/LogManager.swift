//
//  LogManager.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import CocoaLumberjack
import Bugly

public func logDebug(_ message: @autoclosure () -> String) {
    DDLogDebug(message())
    BuglyLog.level(.debug, logs: message())
}

public func logError(_ message: @autoclosure () -> String) {
    DDLogError(message())
    BuglyLog.level(.error, logs: message())
}

public func logInfo(_ message: @autoclosure () -> String) {
    DDLogInfo(message())
    BuglyLog.level(.info, logs: message())
}

public func logVerbose(_ message: @autoclosure () -> String) {
    DDLogVerbose(message())
    BuglyLog.level(.verbose, logs: message())
}

public func logWarn(_ message: @autoclosure () -> String) {
    DDLogWarn(message())
    BuglyLog.level(.warn, logs: message())
}
