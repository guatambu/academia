//
//  GroupFirestore.swift
//  Academia
//
//  Created by Micahel Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol GroupFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct GroupFirestore {
    
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var isActive: Bool
    var name: String
    var groupDescription: String
    
    
    var dictionary: [String : Any] {
        return [
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "isActive" : isActive,
            "name" : name,
            "groupDescription" : groupDescription
        ]
    }
    
    
    // initializer to allow creation of an GroupFirestore object
    init(dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         isActive: Bool,
         name: String,
         groupDescription: String
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.isActive = isActive
        self.name = name
        self.groupDescription = groupDescription
    }
}


extension GroupFirestore: GroupFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 60.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 66.")
            return nil
        }
        
        guard let isActive = dictionary["isActive"] as? Bool else {
            
            print("ERROR: nil value found for isActive in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 72.")
            return nil
        }
        
        guard let name = dictionary["name"] as? String else {
            
            print("ERROR: nil value found name in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 78.")
            return nil
        }
        
        guard let groupDescription = dictionary["groupDescription"] as? String else {
            
            print("ERROR: nil value found for groupDescription in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 84.")
            return nil
        }
        
        self.init(dateCreated: dateCreated, dateEdited: dateEdited, isActive: isActive, name: name, groupDescription: groupDescription)
    }
}
