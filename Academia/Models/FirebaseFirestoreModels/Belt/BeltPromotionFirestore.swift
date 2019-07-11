//
//  BeltPromotionFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol BeltPromotionFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct BeltPromotionFirestore {
    
    var promotionDate: Date
    var numberOfStripes: Int
    var beltLevel: String
    
    
    var dictionary: [String : Any] {
        return [
            "promotionDate" : promotionDate,
            "numberOfStripes" : numberOfStripes,
            "beltLevel" : beltLevel
        ]
    }
    
    
    // initializer to allow creation of a BeltPromotionFirestore object
    init(promotionDate: Date = Date(), // do i want to manually set the date?
        numberOfStripes: Int,
        beltLevel: String
        ) {
        
        self.promotionDate = promotionDate
        self.numberOfStripes = numberOfStripes
        self.beltLevel = beltLevel
    }
}


extension BeltPromotionFirestore: BeltPromotionFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let promotionDate = dictionary["promotionDate"] as? Date else {
            
            print("ERROR: nil value found for promotionDate in firestore dictionary in BeltPromotionFirestore.swift -> init(dictionary:) - line 52.")
            return nil
        }
        
        guard let numberOfStripes = dictionary["numberOfStripes"] as? Int else {
            
            print("ERROR: nil value found for numberOfStripes in firestore dictionary in BeltPromotionFirestore.swift -> init(dictionary:) - line 58.")
            return nil
        }
        
        guard let beltLevel = dictionary["beltLevel"] as? String else {
            
            print("ERROR: nil value found for beltLevel in firestore dictionary in BeltPromotionFirestore.swift -> init(dictionary:) - line 64.")
            return nil
        }
        
        self.init(promotionDate: promotionDate, numberOfStripes: numberOfStripes, beltLevel: beltLevel)
    }
}
