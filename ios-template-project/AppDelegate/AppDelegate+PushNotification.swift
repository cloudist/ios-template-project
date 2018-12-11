//
//  AppDelegate+PushNotification.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/11.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import UserNotifications

// MARK: - register
extension AppDelegate {
    func registerRemotePushNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, _) in
            DispatchQueue.main.sync {
                UIApplication.shared.registerForRemoteNotifications()
            }
            debugPrint(granted ? "授权成功" : "授权失败")
        }
    }
    
    func getNotificationAuthorizationStatus() -> UNAuthorizationStatus {
        var status: UNAuthorizationStatus = .notDetermined
        let sema = DispatchSemaphore(value: 0)
        UNUserNotificationCenter.current().getNotificationSettings { (setting) in
            status = setting.authorizationStatus
            sema.signal()
        }
        // 因为在主线程上，设置最多有0.5s时间来获取 status
        _ = sema.wait(timeout: DispatchTime.now() + 0.5)
        return status
    }
}

// MARK: - UIApplicationDelegate
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
