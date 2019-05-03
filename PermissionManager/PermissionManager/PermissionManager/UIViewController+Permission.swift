//
//  UIViewController+Permission.swift
//  PermissionManager
//
//  Created by Shivank Agarwal on 27/01/19.
//  Copyright © 2019 Shivank Agarwal. All rights reserved.
//

import UIKit
import UserNotifications
import Contacts

extension UIViewController {

    private func askNotificationPermission() {

        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeNotification)
    }

    private func permissionMessage(_ aMessage: String) {

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
        present(alertController, animated: true) {
            //present UIAlertController
        }
    }

    func setPermissionManager() {
        
        setNotificationPermission()
        setContactsPermission()
    }

    internal func setNotificationPermission(){
        
        PermissionManager.sharedInstance.notificationDelegate = self
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeNotification)
    }
    
    internal func setContactsPermission(){
        
        PermissionManager.sharedInstance.contactsDelegate = self
        PermissionManager.sharedInstance.setPermissionType(permission: .permissionTypeContacts)
    }
}

extension UIViewController: PermissionManagerDelegate{
    
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

extension UIViewController: NotificationDelegate{
    
    
}

extension UIViewController: ContactsDelegate{
    
    func getContacts(contacts: [Contact]) {
        
    }
}
