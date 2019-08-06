//
//  EmergencyContactFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol EmergencyContactFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct EmergencyContactFirestore {
    
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var name: String?
    var phone: String?
    var relationship: String?
    
    
    var dictionary: [String : Any] {
        return [
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "name" : name ?? "",
            "phone" : phone ?? "",
            "relationship" : relationship ?? ""
        ]
    }
    
    
    // initializer to allow creation of an OwnerCD object via Academia CoreDataStack's managedObjectContext
    init(dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         name: String?,
         phone: String?,
         relationship: String?
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.phone = phone
        self.relationship = relationship
    }
}


extension EmergencyContactFirestore: EmergencyContactFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
      
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 59.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 65.")
            return nil
        }
        
        guard let name = dictionary["name"] as? String else {
            
            print("ERROR: nil value found for name in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 71.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found phone in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 77.")
            return nil
        }
        
        guard let relationship = dictionary["relationship"] as? String else {
            
            print("ERROR: nil value found for relationship in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 83.")
            return nil
        }
        
        self.init(dateCreated: dateCreated, dateEdited: dateEdited, name: name, phone: phone, relationship: relationship)
    }
}
