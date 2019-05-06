//
//  PermissionManager.swift
//  PermissionManager
//
//  Created by Shivank Agarwal on 27/01/19.
//  Copyright © 2019 Shivank Agarwal. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

protocol PermissionManagerDelegate: class {

    func requirePermission(_ aPermissionType: PermissionType)
}

protocol NotificationDelegate: PermissionManagerDelegate {
    
}

protocol ContactsDelegate: PermissionManagerDelegate {
    
    func getContacts(contacts :[Contact])
}

protocol AddressBookDelegate: class{
    
}

enum PermissionType {
    case permissionTypeNone
    case permissionTypeNotification
    case permissionTypeContacts
}

class PermissionManager: NSObject {

    static let sharedInstance = PermissionManager()

    var permissionType: PermissionType = .permissionTypeNone
    weak var notificationDelegate: NotificationDelegate!
    weak var contactsDelegate: ContactsDelegate!
    
    var contactsStore:CNContactStore!
    var lat: String = "0"
    var long: String = "0"

    func setPermissionType(permission: PermissionType) {

        permissionType = permission
        switch permissionType {
        case .permissionTypeNotification:
            registerUNUserNotification()
        case .permissionTypeContacts:            
            intiateContactSystem()
        default:
            break
        }
    }
}
