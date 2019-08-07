//
//  AulaFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol AulaFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct AulaFirestore {
    
    var isActive: Bool
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var aulaName: String
    var aulaDescription: String
    var dayOfTheWeek: String
    var time: String
    var timeCode: Int
    var locationUUID: String?
    
    var dictionary: [String : Any] {
        return [
            "isActive" : isActive,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "aulaName" : aulaName,
            "aulaDescription" : aulaDescription,
            "dayOfTheWeek" : dayOfTheWeek,
            "time" : time,
            "timeCode" : timeCode,
            "locationUUID" : locationUUID as Any
        ]
    }
    
    // initializer to allow creation of an AulaFirestore object
    init(
        isActive: Bool,
        dateCreated: Timestamp = Timestamp(),
        dateEdited: Timestamp = Timestamp(),
        aulaName: String,
        aulaDescription: String,
        dayOfTheWeek: String,
        time: String,
        timeCode: Int,
        locationUUID: String?
        ) {
        
        self.isActive = isActive
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.aulaName = aulaName
        self.aulaDescription = aulaDescription
        self.dayOfTheWeek = dayOfTheWeek
        self.time = time
        self.timeCode = timeCode
        self.locationUUID = locationUUID
    }
}


extension AulaFirestore: AulaFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let isActive = dictionary["isActive"] as? Bool else {
            
            print("ERROR: nil value found for isActive in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 75.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 81.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 87.")
            return nil
        }
        
        guard let aulaName = dictionary["aulaName"] as? String else {
            
            print("ERROR: nil value found for aulaName in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 93.")
            return nil
        }
        
        guard let aulaDescription = dictionary["aulaDescription"] as? String else {
            
            print("ERROR: nil value found aulaDescription in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 99.")
            return nil
        }
        
        guard let dayOfTheWeek = dictionary["dayOfTheWeek"] as? String else {
            
            print("ERROR: nil value found for dayOfTheWeek in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 105.")
            return nil
        }
        
        guard let time = dictionary["time"] as? String else {
            
            print("ERROR: nil value found for time in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 111.")
            return nil
        }
        
        guard let timeCode = dictionary["timeCode"] as? Int else {
            
            print("ERROR: nil value found for timeCode in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 117.")
            return nil
        }
        
        guard let locationUUID = dictionary["locationUUID"] as? String? else {
            
            print("ERROR: nil value found for locationUUID in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 123.")
            return nil
        }
        
        self.init(isActive: isActive, dateCreated: dateCreated, dateEdited: dateEdited, aulaName: aulaName, aulaDescription: aulaDescription, dayOfTheWeek: dayOfTheWeek, time: time, timeCode: timeCode, locationUUID: locationUUID)
    }
}



