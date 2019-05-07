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
import UserNotifications

public protocol PermissionManagerDelegate: class {

    func requirePermission(_ aPermissionType: PermissionType)
}

public protocol NotificationDelegate: PermissionManagerDelegate {
    
    func userNotificationWillPresent(_ notification: UNNotification, center: UNUserNotificationCenter)
    func userNotificationDidReceive(_ response: UNNotificationResponse, center: UNUserNotificationCenter)
}

public protocol ContactsDelegate: PermissionManagerDelegate {
    
    func getContacts(contacts :[Contact])
}

public protocol LocationDelegate: PermissionManagerDelegate {
    
    func didUpdateLocations(_ locations:[CLLocation], _ manager: CLLocationManager)
    func didFailWithError(_ error:Error, _ manager: CLLocationManager)
    func didDetermineState(_ state: CLRegionState, _region: CLRegion, _ manager: CLLocationManager)    
    func didChangeAuthorizationStatus(_ status: CLAuthorizationStatus, _ manager: CLLocationManager)
}

public enum PermissionType {
    case permissionTypeNone
    case permissionTypeNotification
    case permissionTypeContacts
    case permissionTypeLocation
}

class PermissionManager: NSObject {

    static let sharedInstance = PermissionManager()

    var permissionType: PermissionType = .permissionTypeNone
    weak var notificationDelegate: NotificationDelegate?
    weak var contactsDelegate: ContactsDelegate?
    weak var locationDelegate: LocationDelegate?
    
    var locationManager = CLLocationManager()
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
        case .permissionTypeLocation:
            initLocation()
        default:
            break
        }
    }
}
