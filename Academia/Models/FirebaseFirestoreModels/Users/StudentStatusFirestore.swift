//
//  StudentStatusFirestore.swift
//  Academia
//
//  Created by Micahel Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol StudentStatusFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct StudentStatusFirestore {
    
    var isActive: Bool
    var isMedicalMembershipPaused: Bool
    var isMembershipPaused: Bool
    var isPaid: Bool
    
    var dictionary: [String : Any] {
        return [
            "isActive" : isActive,
            "isMedicalMembershipPaused" : isMedicalMembershipPaused,
            "isMembershipPaused" : isMembershipPaused,
            "isPaid" : isPaid,
        ]
    }
    
    
    // initializer to allow creation of an StudentStatusFirestore object
    init(isActive: Bool,
         isMedicalMembershipPaused: Bool,
         isMembershipPaused: Bool,
         isPaid: Bool
        ) {
        
        self.isActive = isActive
        self.isMedicalMembershipPaused = isMedicalMembershipPaused
        self.isMembershipPaused = isMembershipPaused
        self.isPaid = isPaid
    }
}


extension StudentStatusFirestore: StudentStatusFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let isActive = dictionary["isActive"] as? Bool else {
            
            print("ERROR: nil value found for isActive in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 55.")
            return nil
        }
        
        guard let isMedicalMembershipPaused = dictionary["isMedicalMembershipPaused"] as? Bool else {
            
            print("ERROR: nil value found for isMedicalMembershipPaused in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 61.")
            return nil
        }
        
        guard let isMembershipPaused = dictionary["isMembershipPaused"] as? Bool else {
            
            print("ERROR: nil value found for isMembershipPaused in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 67.")
            return nil
        }
        
        guard let isPaid = dictionary["isPaid"] as? Bool else {
            
            print("ERROR: nil value found for isPaid in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 73.")
            return nil
        }
        
        self.init(isActive: isActive, isMedicalMembershipPaused: isMedicalMembershipPaused, isMembershipPaused: isMembershipPaused, isPaid: isPaid)
        
    }
}


