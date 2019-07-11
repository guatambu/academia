//
//  GroupFirestore.swift
//  Academia
//
//  Created by Micahel Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol GroupFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct GroupFirestore {
    
    var groupUUID: String
    var dateCreated: Date
    var dateEdited: Date
    var active: Bool
    var name: String
    var groupDescription: String
    
    
    var dictionary: [String : Any] {
        return [
            "groupUUID" : groupUUID,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "active" : active,
            "name" : name,
            "groupDescription" : groupDescription
        ]
    }
    
    
    // initializer to allow creation of an GroupFirestore object
    init(groupUUID: String = "\(UUID())",
         dateCreated: Date = Date(),
         dateEdited: Date = Date(),
         active: Bool,
         name: String,
         groupDescription: String
        ) {
        
        self.groupUUID = groupUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.active = active
        self.name = name
        self.groupDescription = groupDescription
    }
}


extension GroupFirestore: GroupFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let groupUUID = dictionary["groupUUID"] as? String else {
            
            print("ERROR: nil value found for groupUUID in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 64.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 70.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 76.")
            return nil
        }
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 82.")
            return nil
        }
        
        guard let name = dictionary["name"] as? String else {
            
            print("ERROR: nil value found name in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 88.")
            return nil
        }
        
        guard let groupDescription = dictionary["groupDescription"] as? String else {
            
            print("ERROR: nil value found for groupDescription in firestore dictionary in GroupFirestore.swift -> init(dictionary:) - line 94.")
            return nil
        }
        
        self.init(groupUUID: groupUUID, dateCreated: dateCreated, dateEdited: dateEdited, active: active, name: name, groupDescription: groupDescription)
    }
}
