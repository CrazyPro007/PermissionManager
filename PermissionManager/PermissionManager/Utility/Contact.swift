//
//  Contact.swift
//  PermissionManager
//
//  Created by Shivank Agarwal on 01/05/19.
//  Copyright © 2019 Shivank Agarwal. All rights reserved.
//

import UIKit
import Contacts

class Contact: NSObject {
    
    var name: String!
    var email: String?
    var image: UIImage?
    var isSelected: Bool = false
    
    init(name: String, email: String?, image: UIImage?) {
        self.name = name
        self.email = email
        self.image = image
    }
    
    init?(contact :CNContact){
        
        if !contact.isKeyAvailable(CNContactGivenNameKey) && !contact.isKeyAvailable(CNContactFamilyNameKey){
            return nil
        }
        self.name = (contact.givenName + " " + contact.familyName).trimmingCharacters(in: NSCharacterSet.whitespaces)
        if contact.isKeyAvailable(CNContactEmailAddressesKey){
            
            for emails in contact.emailAddresses{
                if let properEmail = emails.value as? String{
                    if properEmail.isValidEmail(){
                        self.email = properEmail
                        break
                    }
                }
            }
        }
        if self.email == nil{
            return nil
        }
        if contact.imageDataAvailable , let image:Data = contact.imageData{
            self.image = UIImage(data: image)
        }
        //        self.image = (contact.isKeyAvailable(CNContactImageDataKey) && contact.imageDataAvailable) ? UIImage(data: contact.imageData!) : nil
    }
}

extension String {
    
    /**
     Specify that string contains valid email address.
     
     - returns: A Bool return true if string has valid email otherwise false.
     */
    func isValidEmail() -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
