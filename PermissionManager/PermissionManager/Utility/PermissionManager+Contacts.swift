//
//  PermissionManager + AddressBook.swift
//  PermissionManager
//
//  Created by Shivank Agarwal on 27/01/19.
//  Copyright © 2019 Shivank Agarwal. All rights reserved.
//

import UIKit
import Contacts

extension PermissionManager{
    
    //Mark:- to intlize contact retrieval system along with permission checking
    func intiateContactSystem() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        contactsStore = CNContactStore()
        switch authorizationStatus {
        case .authorized:
            retrieveContacts{(success, contacts) in
                if contacts != nil{
                    //self.contacts = contacts!
                    self.contactsDelegate?.getContacts(contacts: contacts!)
                }else{
                    let contacts:[Contact] = []
                    self.contactsDelegate?.getContacts(contacts: contacts)
                }
            }
            break
        case .denied:
            //user has denied access
            self.contactsDelegate?.requirePermission(PermissionType.permissionTypeContacts)
            break
        case .notDetermined:
            //need to ask for permission
            self.contactsStore.requestAccess(for: CNEntityType.contacts) {(granted,error) in
                if !granted{
                    //ask again
                    self.contactsDelegate?.requirePermission(PermissionType.permissionTypeContacts)
                }
                self.retrieveContacts {(success, contacts) in
                    if contacts != nil {
                       // self.contacts = contacts!
                        self.contactsDelegate?.getContacts(contacts: contacts!)
                    }else{
                        let contacts:[Contact] = []
                        self.contactsDelegate?.getContacts(contacts: contacts)
                    }
                }
            }
            break
        case .restricted:
            //user has restricted the access
            self.contactsDelegate?.requirePermission(PermissionType.permissionTypeContacts)
            break
        }
    }
    
    //Mark:- to retrieve contacts from address book
    func retrieveContacts(completion: (_ success: Bool,_ contacts: [Contact]?) -> ()) {
        var contacts :[Contact] = []
        do {
            let contactsFetchReuest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor,CNContactEmailAddressesKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor])
            try contactsStore.enumerateContacts(with: contactsFetchReuest, usingBlock: {(contact, bool) in
                if let contact = Contact(contact: contact) {
                    contacts.append(contact)
                }
            })            
            completion(true, contacts)
        }catch( _) {
            completion(false, nil)
        }
    }
}
