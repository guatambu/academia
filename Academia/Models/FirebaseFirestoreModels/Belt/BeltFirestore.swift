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
    
    var active: Bool
    var elligibleForNextBelt: Bool
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var beltLevel: String
    // these two may be rompting the need for an academy belt template class all its own
    var beltPromotionAttendanceCriteria: BeltPromotionAttendanceCriteriaFirestore?
    var beltStripeAgeDetails: BeltStripeAgeDetailsFirestore?
    // see comment ^^^
    var classesToNextPromotion: Int?
    var numberOfStripes: Int
    
    
    var dictionary: [String : Any] {
        return [
            "active" : active,
            "elligibleForNextBelt" : elligibleForNextBelt,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "beltLevel" : beltLevel,
            "beltPromotionAttendanceCriteria" : beltPromotionAttendanceCriteria as Any,
            "beltStripeAgeDetails" : beltStripeAgeDetails as Any,
            "classesToNextPromotion" : classesToNextPromotion as Any,
            "numberOfStripes" : numberOfStripes
        ]
    }
    
    
    // initializer to allow creation of a BeltFirestore object
    init(active: Bool = true,
         elligibleForNextBelt: Bool = false,
         dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         beltLevel: String,
         beltPromotionAttendanceCriteria: BeltPromotionAttendanceCriteriaFirestore?,
         beltStripeAgeDetails: BeltStripeAgeDetailsFirestore?,
         classesToNextPromotion: Int?,
         numberOfStripes: Int
        ) {
        
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.beltLevel = beltLevel
        self.beltPromotionAttendanceCriteria = beltPromotionAttendanceCriteria
        self.beltStripeAgeDetails = beltStripeAgeDetails
        self.classesToNextPromotion = classesToNextPromotion
        self.numberOfStripes = numberOfStripes
    }
}


extension BeltFirestore: BeltFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 77.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 83.")
            return nil
        }
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 89.")
            return nil
        }
        
        guard let elligibleForNextBelt = dictionary["elligibleForNextBelt"] as? Bool else {
            
            print("ERROR: nil value found elligibleForNextBelt in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 95.")
            return nil
        }
        
        guard let beltLevel = dictionary["beltLevel"] as? String else {
            
            print("ERROR: nil value found for beltLevel in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 101.")
            return nil
        }
        
        guard let beltPromotionAttendanceCriteria = dictionary["beltPromotionAttendanceCriteria"] as? BeltPromotionAttendanceCriteriaFirestore else {
            
            print("ERROR: nil value found for beltPromotionAttendanceCriteria in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 107.")
            return nil
        }
        
        guard let beltStripeAgeDetails = dictionary["beltStripeAgeDetails"] as? BeltStripeAgeDetailsFirestore else {
            
            print("ERROR: nil value found for beltStripeAgeDetails in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 113.")
            return nil
        }
        
        guard let classesToNextPromotion = dictionary["classesToNextPromotion"] as? Int else {
            
            print("ERROR: nil value found for classesToNextPromotion in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 119.")
            return nil
        }
        
        guard let numberOfStripes = dictionary["numberOfStripes"] as? Int else {
            
            print("ERROR: nil value found for numberOfStripes in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 125.")
            return nil
        }
        
        self.init(active: active, elligibleForNextBelt: elligibleForNextBelt, dateCreated: dateCreated, dateEdited: dateEdited, beltLevel: beltLevel, beltPromotionAttendanceCriteria: beltPromotionAttendanceCriteria, beltStripeAgeDetails: beltStripeAgeDetails, classesToNextPromotion: classesToNextPromotion, numberOfStripes: numberOfStripes)
    }
}
