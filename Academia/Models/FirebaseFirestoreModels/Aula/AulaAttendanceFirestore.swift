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
    var adultStudents: [String]?
    var kidStudents: [String]?
    var owners: [String]?
    var aulaUUID: String
    
    
    var dictionary: [String : Any] {
        return [
            "currentDate" : currentDate,
            "studentAdultsAttendance" : adultStudents as Any,
            "studentKidsAttendance" : kidStudents as Any,
            "ownersAttendance" : owners as Any,
            "aulaUUID" : aulaUUID
        ]
    }
    
    
    // convenience initializer to allow creation of an OwnerCD object via Academia CoreDataStack's managedObjectContext
    init(currentDate: String = "\(Date())",
         adultStudents: [String]?,
         kidStudents: [String]?,
         owners: [String]?,
         aulaUUID: String
        ) {
        
        self.currentDate = currentDate
        self.adultStudents = adultStudents
        self.kidStudents = kidStudents
        self.owners = owners
        self.aulaUUID = aulaUUID
    }
}


extension AulaAttendanceFirestore: AulaAttendanceFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let currentDate = dictionary["currentDate"] as? String else {
            
            print("ERROR: nil value found for currentDate in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 60.")
            return nil
        }
        
        guard let adultStudents = dictionary["adultStudents"] as? [String]? else {
            
            print("ERROR: nil value found for adultStudents in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 66.")
            return nil
        }
        
        guard let kidStudents = dictionary["kidStudents"] as? [String]? else {
            
            print("ERROR: nil value found for kidStudents in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 72.")
            return nil
        }
        
        guard let owners = dictionary["owners"] as? [String]? else {
            
            print("ERROR: nil value found for owners in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 78.")
            return nil
        }
        
        guard let aulaUUID = dictionary["aulaUUID"] as? String else {
            
            print("ERROR: nil value found aulaUUID in firestore dictionary in AulaAttendanceFirestore.swift -> init(dictionary:) - line 84.")
            return nil
        }
        
        self.init(currentDate: currentDate, adultStudents: adultStudents, kidStudents: kidStudents, owners: owners, aulaUUID: aulaUUID)
    }
}
