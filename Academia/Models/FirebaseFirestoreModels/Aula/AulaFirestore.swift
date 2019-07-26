//
//  AulaFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol AulaFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct AulaFirestore {
    
    var aulaUUID: String
    var active: Bool
    var dateCreated: Date
    var dateEdited: Date
    var aulaName: String
    var aulaDescription: String
    var dayOfTheWeek: String
    var time: String
    var timeCode: Int
    var locationUUID: String?
    
    var dictionary: [String : Any] {
        return [
            "aulaUUID" : aulaUUID,
            "active" : active,
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
    init(aulaUUID: String = "\(UUID())",
        active: Bool,
        dateCreated: Date = Date(),
        dateEdited: Date = Date(),
        aulaName: String,
        aulaDescription: String,
        dayOfTheWeek: String,
        time: String,
        timeCode: Int,
        locationUUID: String?
        ) {
        
        self.aulaUUID = aulaUUID
        self.active = active
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
        
        
        guard let aulaUUID = dictionary["aulaUUID"] as? String else {
            
            print("ERROR: nil value found for aulaUUID in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 79.")
            return nil
        }
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 85.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 91.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 97.")
            return nil
        }
        
        guard let aulaName = dictionary["aulaName"] as? String else {
            
            print("ERROR: nil value found for aulaName in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 103.")
            return nil
        }
        
        guard let aulaDescription = dictionary["aulaDescription"] as? String else {
            
            print("ERROR: nil value found aulaDescription in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 109.")
            return nil
        }
        
        guard let dayOfTheWeek = dictionary["dayOfTheWeek"] as? String else {
            
            print("ERROR: nil value found for dayOfTheWeek in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 115.")
            return nil
        }
        
        guard let time = dictionary["time"] as? String else {
            
            print("ERROR: nil value found for time in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 121.")
            return nil
        }
        
        guard let timeCode = dictionary["timeCode"] as? Int else {
            
            print("ERROR: nil value found for timeCode in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 127.")
            return nil
        }
        
        guard let locationUUID = dictionary["locationUUID"] as? String? else {
            
            print("ERROR: nil value found for locationUUID in firestore dictionary in AulaFirestore.swift -> init(dictionary:) - line 133.")
            return nil
        }
        
        self.init(aulaUUID: aulaUUID, active: active, dateCreated: dateCreated, dateEdited: dateEdited, aulaName: aulaName, aulaDescription: aulaDescription, dayOfTheWeek: dayOfTheWeek, time: time, timeCode: timeCode, locationUUID: locationUUID)
    }
}



