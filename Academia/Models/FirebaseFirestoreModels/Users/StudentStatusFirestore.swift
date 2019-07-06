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
    
    var active: Bool
    var medicalMembershipPaused: Bool
    var membershipPaused: Bool
    var paid: Bool
//    var studentAdult: AdultStudentFirestore
//    var studentKid: KidStudentFirestore
    
    
    var dictionary: [String : Any] {
        return [
            "active" : active,
            "medicalMembershipPaused" : medicalMembershipPaused,
            "membershipPaused" : membershipPaused,
            "paid" : paid,
            // "studentAdult" : studentAdult,
            // "studentKid" : studentKid
        ]
    }
    
    
    // initializer to allow creation of an StudentStatusFirestore object
    init(active: Bool,
         medicalMembershipPaused: Bool,
         membershipPaused: Bool,
         //         studentAdult: AdultStudentFirestore,
        //         studentKid: StudentKidCD,
         paid: Bool
        ) {
        
        self.active = active
        self.medicalMembershipPaused = medicalMembershipPaused
        self.membershipPaused = membershipPaused
        //self.studentAdult = studentAdult
        //self.studentKid = studentKid
        self.paid = paid
    }
}


extension StudentStatusFirestore: StudentStatusFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let medicalMembershipPaused = dictionary["dmedicalMembershipPaused"] as? Bool else {
            
            print("ERROR: nil value found for medicalMembershipPaused in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
        guard let membershipPaused = dictionary["membershipPaused"] as? Bool else {
            
            print("ERROR: nil value found for membershipPaused in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 136.")
            return nil
        }
        
        guard let paid = dictionary["paid"] as? Bool else {
            
            print("ERROR: nil value found for paid in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        //        guard let studentAdult = dictionary["studentAdult"] as? AdultStudentFirestore else {
        //
        //            print("ERROR: nil value found for studentAdult in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 148.")
        //            return nil
        //        }
        
        //        guard let studentKid = dictionary["studentKid"] as? KidStudentFirestore else {
        //
        //            print("ERROR: nil value found for studentKid in firestore dictionary in StudentStatusFirestore.swift -> init(dictionary:) - line 154.")
        //            return nil
        //        }
        
        self.init(active: active, medicalMembershipPaused: medicalMembershipPaused, membershipPaused: membershipPaused, paid: paid)
        
    }
}


