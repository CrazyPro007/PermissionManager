//
//  PermissionManager+Notification.swift
//  PermissionManager
//
//  Created by Shivank Agarwal on 27/01/19.
//  Copyright © 2019 Shivank Agarwal. All rights reserved.
//

import UIKit
import UserNotifications

extension PermissionManager {
    
    //MARK:- Notification Methods
    internal func registerUNUserNotification() {
        if #available(iOS 10.0, *) {
            let userNotificationCenter = UNUserNotificationCenter.current()
            userNotificationCenter.delegate = self
            userNotificationCenter.requestAuthorization(options: [.sound, .alert, .badge], completionHandler: { (status, error) in
                if status {
                    self.registerRemoteNotification()
                }
                else {
                    self.notificationDelegate?.requirePermission(PermissionType.permissionTypeNotification)
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func registerRemoteNotification() {
        DispatchQueue.main.async {
           UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    private func deregisterRemoteNotification() {
        DispatchQueue.main.async {
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
}

extension PermissionManager: UNUserNotificationCenterDelegate{
    
    //MARK:- UNUserNotificationCenterDelegate
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //Implentation notification when app is in foreground
        self.notificationDelegate?.userNotificationWillPresent(notification, center: center)
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Handle notification recieve
        self.notificationDelegate?.userNotificationDidReceive(response, center: center)
    }
}
