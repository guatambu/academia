//
//  AulaAttendanceFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol AulaAttendanceFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct AulaAttendanceFirestore {
    
    var currentDate: String
    var adultStudent: AdultStudentFirestore?
    var kidStudent: KidStudentFirestore?
    var owner: OwnerFirestore?
    var aula: AulaFirestore?
    
    
    var dictionary: [String : Any] {
        return [
            "currentDate" : currentDate,
            "studentAdultAttendance" : adultStudent,
            "studentKidAttendance" : kidStudent,
            "ownerAttendance" : owner,
            "aula" : aula
        ]
    }
    
    
    // convenience initializer to allow creation of an OwnerCD object via Academia CoreDataStack's managedObjectContext
    init(currentDate: String = "\(Date())",
         adultStudent: AdultStudentFirestore?,
         kidStudent: KidStudentFirestore?,
         owner: OwnerFirestore?,
         aula: AulaFirestore?,
        ) {
        
        self.currentDate = currentDate
        self.adultStudent = adultStudent
        self.kidStudent = kidStudent
        self.owner = owner
        self.aula = aula
    }
}


extension AulaAttendanceFirestore: AulaAttendanceFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let currentDate = dictionary["currentDate"] as? String else {
            
            print("ERROR: nil value found for currentDate in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 60.")
            return nil
        }
        
        guard let adultStudent = dictionary["adultStudent"] as? AdultStudentFirestore else {
            
            print("ERROR: nil value found for adultStudent in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 66.")
            return nil
        }
        
        guard let kidStudent = dictionary["kidStudent"] as? KidStudentFirestore else {
            
            print("ERROR: nil value found for kidStudent in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 72.")
            return nil
        }
        
        guard let owner = dictionary["owner"] as? OwnerFirestore else {
            
            print("ERROR: nil value found for owner in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 78.")
            return nil
        }
        
        guard let aula = dictionary["aula"] as? AulaFirestore else {
            
            print("ERROR: nil value found aula in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 84.")
            return nil
        }
        
        self.init(currentDate: currentDate, adultStudent: adultStudent, kidStudent: kidStudent, owner: owner, aula: aula)
    }
}
