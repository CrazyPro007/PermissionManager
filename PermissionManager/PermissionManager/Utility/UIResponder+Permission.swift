//
//  UIApplication+Permission.swift
//  Pods-TestPod
//
//  Created by Shivank Agarwal on 07/05/19.
//

import UIKit
import UserNotifications
import Contacts

extension UIResponder {
    
    private func permissionMessage(_ aMessage: String) {
        
        autoreleasepool{
            let alertController: UIAlertController = UIAlertController(title: nil, message: aMessage, preferredStyle: .alert)
            let proceedAlert: UIAlertAction = UIAlertAction(title: "Proceed", style: .default) { (action) in
                if let aURL = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(aURL, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(proceedAlert)
            let discardAlert: UIAlertAction = UIAlertAction(title: "Discard", style: .cancel) { (action) in
                //dismiss UIAlertController
            }
            alertController.addAction(discardAlert)
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            win.rootViewController = vc
            win.windowLevel = UIWindow.Level.alert + 1
            win.makeKeyAndVisible()
            vc.present(alertController, animated: true) {
                //present UIAlertController
            }
        }
    }
    
    public func setPermissionManager() {
        
        setNotificationPermission()
        setContactsPermission()
    }
    
    public func setNotificationPermission(_ delegate: NotificationDelegate? = nil){
        
        PermissionManager.sharedInstance.notificationDelegate = delegate
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeNotification)
    }
    
    public func setContactsPermission(_ delegate: ContactsDelegate? = nil){
        
        PermissionManager.sharedInstance.contactsDelegate = delegate
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeContacts)
    }
    
    public func setLocationPermission(_ delegate: LocationDelegate? = nil){
        
        PermissionManager.sharedInstance.locationDelegate = delegate
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeLocation)
    }
}
