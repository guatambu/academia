//
//  BeltFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol BeltFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct BeltFirestore {
    
    var beltUUID: String
    var active: Bool
    var elligibleForNextBelt: Bool
    var dateCreated: Date
    var dateEdited: Date
    var beltLevel: String
    var beltPromotionAttendanceCriteria: BeltPromotionAttendanceFirestore?
    var beltStripeAgeDetails: BeltStripeAgeDetailsFirestore?
    var classesToNextPromotion: Int?
    var numberOfStripes: Int
    
    
    var dictionary: [String : Any] {
        return [
            "beltUUID" : beltUUID,
            "active" : active,
            "elligibleForNextBelt" : elligibleForNextBelt,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "beltLevel" : beltLevel,
            "beltPromotionAttendanceCriteria" : beltPromotionAttendanceCriteria
            "beltStripeAgeDetails" : beltStripeAgeDetails,
            "classesToNextPromotion" : classesToNextPromotion,
            "numberOfStripes" : numberOfStripes
        ]
    }
    
    
    // initializer to allow creation of a BeltFirestore object
    init(beltUUID: String = "\(UUID())",
         active: Bool = true,
         elligibleForNextBelt: Bool = false,
         dateCreated: Date = Date(),
         dateEdited: Date = Date(),
         beltLevel: String,
         beltPromotionAttendanceCriteria: BeltPromotionAttendanceCriteriaCD?,
         beltStripeAgeDetails: BeltStripeAgeDetailsCD?,
         classesToNextPromotion: Int?,
         numberOfStripes: Int
        ) {
        
        self.beltUUID = beltUUID
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
        
        
        guard let beltUUID = dictionary["beltUUID"] as? String else {
            
            print("ERROR: nil value found for beltUUID in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 136.")
            return nil
        }
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        guard let elligibleForNextBelt = dictionary["elligibleForNextBelt"] as? Bool else {
            
            print("ERROR: nil value found elligibleForNextBelt in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 160.")
            return nil
        }
        
        guard let beltLevel = dictionary["beltLevel"] as? String else {
            
            print("ERROR: nil value found for beltLevel in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 106.")
            return nil
        }
        
        guard let beltPromotionAttendanceCriteria = dictionary["beltPromotionAttendanceCriteria"] as? BeltPromotionAttendanceFirestore else {
            
            print("ERROR: nil value found for beltPromotionAttendanceCriteria in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 112.")
            return nil
        }
        
        guard let beltStripeAgeDetails = dictionary["beltStripeAgeDetails"] as? BeltStripeAgeDetailsFirestore else {
            
            print("ERROR: nil value found for beltStripeAgeDetails in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 166.")
            return nil
        }
        
        guard let classesToNextPromotion = dictionary["classesToNextPromotion"] as? String else {
            
            print("ERROR: nil value found for classesToNextPromotion in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 172.")
            return nil
        }
        
        guard let numberOfStripes = dictionary["numberOfStripes"] as? String else {
            
            print("ERROR: nil value found for numberOfStripes in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 184.")
            return nil
        }
        
        self.init(beltUUID: beltUUID, active: active, elligibleForNextBelt: elligibleForNextBelt, dateCreated: dateCreated, dateEdited: dateEdited, beltLevel: beltLevel, beltPromotionAttendanceCriteria: beltPromotionAttendanceCriteria, beltStripeAgeDetails: beltStripeAgeDetails, classesToNextPromotion: classesToNextPromotion, numberOfStripes: numberOfStripes)
    }
}
