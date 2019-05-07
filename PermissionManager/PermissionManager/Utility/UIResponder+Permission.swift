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
    
    private func askNotificationPermission() {
        
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeNotification)
    }
    
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
    
    public func setNotificationPermission(){
        
        PermissionManager.sharedInstance.notificationDelegate = self
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeNotification)
    }
    
    public func setContactsPermission(){
        
        PermissionManager.sharedInstance.contactsDelegate = self
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeContacts)
    }
}

extension UIResponder: PermissionManagerDelegate{
    
    func requirePermission(_ aPermissionType: PermissionType) {
        
        DispatchQueue.main.async {
            switch aPermissionType {
            case .permissionTypeNotification:
                self.permissionMessage("We need notification permission")
            case .permissionTypeContacts:
                self.permissionMessage("We need contacts permission")
            default:
                break
            }
        }
    }
}

extension UIResponder: NotificationDelegate{
    
    
}

extension UIResponder: ContactsDelegate{
    
    func getContacts(contacts: [Contact]) {
        
    }
}

