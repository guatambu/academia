//
//  AddressFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol AddressFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct AddressFirestore {
    
    var addressLine1: String
    var addressLine2: String?
    var city: String
    var state: String
    var zipCode: String
    var dateCreated: Date
    var dateEdited: Date
    
    var dictionary: [String : Any] {
        return [
            "addressLine1" : addressLine1,
            "addressLine2" : addressLine2 ?? "",
            "city" : city,
            "state" : state,
            "zipCode" : zipCode,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited
        ]
    }
    
    
    // initializer to allow creation of an AddressFirestore object 
    init(dateCreated: Date = Date(),
        dateEdited: Date = Date(),
        addressLine1: String,
        addressLine2: String?,
        city: String,
        state: String,
        zipCode: String
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}


extension AddressFirestore: AddressFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in TestModel.swift -> init(dictionary:) - line 67.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in TestModel.swift -> init(dictionary:) - line 73.")
            return nil
        }
        
        guard let addressLine1 = dictionary["addressLine1"] as? String else {
            
            print("ERROR: nil value found for addressLine1 in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 79.")
            return nil
        }
        
        guard let addressLine2 = dictionary["addressLine2"] as? String else {
            
            print("ERROR: nil value found addressLine2 in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 85.")
            return nil
        }
        
        guard let city = dictionary["city"] as? String else {
            
            print("ERROR: nil value found for city in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 91.")
            return nil
        }
        
        guard let state = dictionary["state"] as? String else {
            
            print("ERROR: nil value found for state in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 97.")
            return nil
        }
        
        guard let zipCode = dictionary["zipCode"] as? String else {
            
            print("ERROR: nil value found for zipCode in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 103.")
            return nil
        }
        
        self.init(dateCreated: dateCreated, dateEdited: dateEdited, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode)    }
}
