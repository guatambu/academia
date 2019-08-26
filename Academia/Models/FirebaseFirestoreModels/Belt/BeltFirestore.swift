//
//  BeltFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol BeltFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}

struct BeltFirestore {
    
    var isActive: Bool
    var elligibleForNextBelt: Bool
    var elligibleForPromotion: Bool
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var beltLevel: String
    var numberOfClassesAttendedSinceLastPromotion: Int
    var numberOfStripes: Int
    
    
    var dictionary: [String : Any] {
        return [
            "isActive" : isActive,
            "elligibleForNextBelt" : elligibleForNextBelt,
            "elligibleForPromotion" : elligibleForPromotion,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "beltLevel" : beltLevel,
            "numberOfClassesAttendedSinceLastPromotion" : numberOfClassesAttendedSinceLastPromotion,
            "numberOfStripes" : numberOfStripes
        ]
    }
    
    
    // initializer to allow creation of a BeltFirestore object
    init(isActive: Bool = true,
         elligibleForNextBelt: Bool = false,
         elligibleForPromotion: Bool = false,
         dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         beltLevel: String,
         numberOfClassesAttendedSinceLastPromotion: Int,
         numberOfStripes: Int
        ) {
        
        self.isActive = isActive
        self.elligibleForNextBelt = elligibleForNextBelt
        self.elligibleForPromotion = elligibleForPromotion
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.beltLevel = beltLevel
        self.numberOfClassesAttendedSinceLastPromotion = numberOfClassesAttendedSinceLastPromotion
        self.numberOfStripes = numberOfStripes
    }
}


extension BeltFirestore: BeltFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 71.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 77.")
            return nil
        }
        
        guard let isActive = dictionary["isActive"] as? Bool else {
            
            print("ERROR: nil value found for isActive in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 83.")
            return nil
        }
        
        guard let elligibleForNextBelt = dictionary["elligibleForNextBelt"] as? Bool else {
            
            print("ERROR: nil value found elligibleForNextBelt in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 89.")
            return nil
        }
        
        guard let elligibleForPromotion = dictionary["elligibleForPromotion"] as? Bool else {
            
            print("ERROR: nil value found elligibleForPromotion in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 95.")
            return nil
        }
        
        guard let beltLevel = dictionary["beltLevel"] as? String else {
            
            print("ERROR: nil value found for beltLevel in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 101.")
            return nil
        }
        
        guard let numberOfClassesAttendedSinceLastPromotion = dictionary["numberOfClassesAttendedSinceLastPromotion"] as? Int else {
            
            print("ERROR: nil value found for numberOfClassesAttendedSinceLastPromotion in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 107.")
            return nil
        }
        
        guard let numberOfStripes = dictionary["numberOfStripes"] as? Int else {
            
            print("ERROR: nil value found for numberOfStripes in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 113.")
            return nil
        }
        
        self.init(isActive: isActive, elligibleForNextBelt: elligibleForNextBelt, elligibleForPromotion: elligibleForPromotion, dateCreated: dateCreated, dateEdited: dateEdited, beltLevel: beltLevel, numberOfClassesAttendedSinceLastPromotion: numberOfClassesAttendedSinceLastPromotion, numberOfStripes: numberOfStripes)
    }
}
