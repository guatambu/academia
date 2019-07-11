//
//  BeltPromotionAttendanceFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol BeltPromotionAttendanceCriteriaFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct BeltPromotionAttendanceCriteriaFirestore {
    
    var beltLevel: String
    var attendancePerStripe: Int
    var attendancePerBelt: Int
    
    
    var dictionary: [String : Any] {
        return [
            "beltLevel" : beltLevel,
            "attendancePerStripe" : attendancePerStripe,
            "attendancePerBelt" : attendancePerBelt
        ]
    }
    
    
    // initializer to allow creation of a BeltPromotionFirestore object
    init(beltLevel: String, // do i want to manually set the date?
        attendancePerStripe: Int,
        attendancePerBelt: Int
        ) {
        
        self.beltLevel = beltLevel
        self.attendancePerStripe = attendancePerStripe
        self.attendancePerBelt = attendancePerBelt
    }
}


extension BeltPromotionAttendanceCriteriaFirestore: BeltPromotionAttendanceCriteriaFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let beltLevel = dictionary["beltLevel"] as? String else {
            
            print("ERROR: nil value found for beltLevel in firestore dictionary in BeltPromotionAttendanceCriteriaFirestore.swift -> init(dictionary:) - line 52.")
            return nil
        }
        
        guard let attendancePerStripe = dictionary["attendancePerStripe"] as? Int else {
            
            print("ERROR: nil value found for attendancePerStripe in firestore dictionary in BeltPromotionAttendanceCriteriaFirestore.swift -> init(dictionary:) - line 58.")
            return nil
        }
        
        guard let attendancePerBelt = dictionary["attendancePerBelt"] as? Int else {
            
            print("ERROR: nil value found for attendancePerBelt in firestore dictionary in BeltPromotionAttendanceCriteriaFirestore.swift -> init(dictionary:) - line 64.")
            return nil
        }
        
        self.init(beltLevel: beltLevel, attendancePerStripe: attendancePerStripe, attendancePerBelt: attendancePerBelt)
    }
}
