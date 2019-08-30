//
//  BeltStripeAgeDetailsFirestore.swift
//  Academia
//
//  Created by Michel Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol BeltStripeAgeDetailsFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct BeltStripeAgeDetailsFirestore {
    
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var beltLevel: String
    var beltRequiredTime: String?
    var minAgeRequirements: String?
    var iStripeRequiredTime: String?
    var iiStripeRequiredTime: String?
    var iiiStripeRequiredTime: String?
    var ivStripeRequiredTime: String?
    var vStripeRequiredTime: String?
    var viStripeRequiredTime: String?
    var viiStripeRequiredTime: String?
    var viiiStripeRequiredTime: String?
    var ixStripeRequiredTime: String?
    var xStripeRequiredTime: String?
    var xiStripeRequiredTime: String?
    var attendancePerBelt: Int?
    var iStripeAttendance: Int?
    var iiStripeAttendance: Int?
    var iiiStripeAttendance: Int?
    var ivStripeAttendance: Int?
    var vStripeAttendance: Int?
    var viStripeAttendance: Int?
    var viiStripeAttendance: Int?
    var viiiStripeAttendance: Int?
    var ixStripeAttendance: Int?
    var xStripeAttendance: Int?
    var xiStripeAttendance: Int?
    
    
    var dictionary: [String : Any] {
        return [
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "beltLevel" : beltLevel,
            "beltRequiredTime" : beltRequiredTime ?? "",
            "minAgeRequirements" : minAgeRequirements  ?? "",
            "iStripeRequiredTime" : iStripeRequiredTime  ?? "",
            "iiStripeRequiredTime" : iiStripeRequiredTime  ?? "",
            "iiiStripeRequiredTime" : iiiStripeRequiredTime  ?? "",
            "ivStripeRequiredTime" : ivStripeRequiredTime  ?? "",
            "vStripeRequiredTime" : vStripeRequiredTime  ?? "",
            "viStripeRequiredTime" : viStripeRequiredTime  ?? "",
            "viiStripeRequiredTime" : viiStripeRequiredTime  ?? "",
            "viiiStripeRequiredTime" : viiiStripeRequiredTime  ?? "",
            "ixStripeRequiredTime" : ixStripeRequiredTime  ?? "",
            "xStripeRequiredTime" : xStripeRequiredTime  ?? "",
            "xiStripeRequiredTime" : xiStripeRequiredTime  ?? "",
            "attendancePerBelt" : attendancePerBelt ?? 0,
            "iStripeAttendance" : iStripeAttendance ?? 0,
            "iiStripeAttendance" : iiStripeAttendance ?? 0,
            "iiiStripeAttendance" : iiiStripeAttendance ?? 0,
            "ivStripeAttendance" : ivStripeAttendance ?? 0,
            "vStripeAttendance" : vStripeAttendance ?? 0,
            "viStripeAttendance" : viStripeAttendance ?? 0,
            "viiStripeAttendance" : viiStripeAttendance ?? 0,
            "viiiStripeAttendance" : viiiStripeAttendance ?? 0,
            "ixStripeAttendance" : ixStripeAttendance ?? 0,
            "xStripeAttendance" : xStripeAttendance ?? 0,
            "xiStripeAttendance" : xiStripeAttendance ?? 0
        ]
    }
    
    
    // initializer to allow creation of a BeltStripeAgeDetailsFirestore object
    init(dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         beltLevel: String,
         beltRequiredTime: String?,
         minAgeRequirements: String?,
         iStripeRequiredTime: String?,
         iiStripeRequiredTime: String?,
         iiiStripeRequiredTime: String?,
         ivStripeRequiredTime: String?,
         vStripeRequiredTime: String?,
         viStripeRequiredTime: String?,
         viiStripeRequiredTime: String?,
         viiiStripeRequiredTime: String?,
         ixStripeRequiredTime: String?,
         xStripeRequiredTime: String?,
         xiStripeRequiredTime: String?,
         attendancePerBelt: Int?,
         iStripeAttendance: Int?,
         iiStripeAttendance: Int?,
         iiiStripeAttendance: Int?,
         ivStripeAttendance: Int?,
         vStripeAttendance: Int?,
         viStripeAttendance: Int?,
         viiStripeAttendance: Int?,
         viiiStripeAttendance: Int?,
         ixStripeAttendance: Int?,
         xStripeAttendance: Int?,
         xiStripeAttendance: Int?
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.beltLevel = beltLevel
        self.beltRequiredTime = beltRequiredTime
        self.minAgeRequirements = minAgeRequirements
        self.iStripeRequiredTime = iStripeRequiredTime
        self.iiStripeRequiredTime = iiStripeRequiredTime
        self.iiiStripeRequiredTime = iiiStripeRequiredTime
        self.ivStripeRequiredTime = ivStripeRequiredTime
        self.vStripeRequiredTime = vStripeRequiredTime
        self.viStripeRequiredTime = viStripeRequiredTime
        self.viiStripeRequiredTime = viiStripeRequiredTime
        self.viiiStripeRequiredTime = viiiStripeRequiredTime
        self.ixStripeRequiredTime = ixStripeRequiredTime
        self.xStripeRequiredTime = xStripeRequiredTime
        self.xiStripeRequiredTime = xiStripeRequiredTime
        self.attendancePerBelt = attendancePerBelt
        self.iStripeAttendance = iStripeAttendance
        self.iiStripeAttendance = iiStripeAttendance
        self.iiiStripeAttendance = iiiStripeAttendance
        self.ivStripeAttendance = ivStripeAttendance
        self.vStripeAttendance = vStripeAttendance
        self.viStripeAttendance = viStripeAttendance
        self.viiStripeAttendance = viiStripeAttendance
        self.viiiStripeAttendance = viiiStripeAttendance
        self.ixStripeAttendance = ixStripeAttendance
        self.xStripeAttendance = xStripeAttendance
        self.xiStripeAttendance = xiStripeAttendance
    }
}


extension BeltStripeAgeDetailsFirestore: BeltStripeAgeDetailsFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 152.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 158.")
            return nil
        }
        
        guard let beltLevel = dictionary["beltLevel"] as? String else {
            
            print("ERROR: nil value found for beltLevel in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 165.")
            return nil
        }
        
        
        guard let beltRequiredTime = dictionary["beltRequiredTime"] as? String else {
            
            print("ERROR: nil value found for beltRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 171.")
            return nil
        }
        
        guard let minAgeRequirements = dictionary["minAgeRequirements"] as? String else {
            
            print("ERROR: nil value found for minAgeRequirements in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 177.")
            return nil
        }
        
        guard let iStripeRequiredTime = dictionary["iStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for iStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 183.")
            return nil
        }
        
        guard let iiStripeRequiredTime = dictionary["iiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for iiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 189.")
            return nil
        }
        
        guard let iiiStripeRequiredTime = dictionary["iiiStripeRequiredTime"] as? String else {

            print("ERROR: nil value found for iiiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 195.")
            return nil
        }

        guard let ivStripeRequiredTime = dictionary["ivStripeRequiredTime"] as? String else {

            print("ERROR: nil value found for ivStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 201.")
            return nil
        }
        
        guard let vStripeRequiredTime = dictionary["vStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found StripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 207.")
            return nil
        }
        
        guard let viStripeRequiredTime = dictionary["viStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for viStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 213.")
            return nil
        }
        
        guard let viiStripeRequiredTime = dictionary["viiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for viiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 219.")
            return nil
        }
        
        guard let viiiStripeRequiredTime = dictionary["viiiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for viiiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 225.")
            return nil
        }
        
        guard let ixStripeRequiredTime = dictionary["iStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for ixStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 231.")
            return nil
        }

        guard let xStripeRequiredTime = dictionary["xStripeRequiredTime"] as? String else {

            print("ERROR: nil value found for xStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 237.")
            return nil
        }
        
        guard let xiStripeRequiredTime = dictionary["xiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for xiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 243.")
            return nil
        }
        
        guard let attendancePerBelt = dictionary["attendancePerBelt"] as? Int else {
            
            print("ERROR: nil value found for attendancePerBelt in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 249.")
            return nil
        }
        
        guard let iStripeAttendance = dictionary["iStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for iStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 255.")
            return nil
        }
        
        guard let iiStripeAttendance = dictionary["iiStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for iiStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 261.")
            return nil
        }
        
        guard let iiiStripeAttendance = dictionary["iiiStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for iiiStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 267.")
            return nil
        }
        
        guard let ivStripeAttendance = dictionary["ivStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for ivStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 273.")
            return nil
        }
        
        guard let vStripeAttendance = dictionary["vStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for vStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 279.")
            return nil
        }
        
        guard let viStripeAttendance = dictionary["viStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for viStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 285.")
            return nil
        }
        
        guard let viiStripeAttendance = dictionary["viiStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for viiStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 291.")
            return nil
        }
        
        guard let viiiStripeAttendance = dictionary["viiiStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for viiiStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 297.")
            return nil
        }
        
        guard let ixStripeAttendance = dictionary["ixStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for ixStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 303.")
            return nil
        }
        
        guard let xStripeAttendance = dictionary["xStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for xStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 309.")
            return nil
        }
        
        guard let xiStripeAttendance = dictionary["xiStripeAttendance"] as? Int else {
            
            print("ERROR: nil value found for xiStripeAttendance in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 315.")
            return nil
        }
        
    
        
        self.init(dateCreated: dateCreated, dateEdited: dateEdited, beltLevel: beltLevel, beltRequiredTime: beltRequiredTime, minAgeRequirements: minAgeRequirements, iStripeRequiredTime: iStripeRequiredTime, iiStripeRequiredTime: iiStripeRequiredTime, iiiStripeRequiredTime: iiiStripeRequiredTime, ivStripeRequiredTime: ivStripeRequiredTime, vStripeRequiredTime: vStripeRequiredTime, viStripeRequiredTime: viStripeRequiredTime, viiStripeRequiredTime: viiStripeRequiredTime, viiiStripeRequiredTime: viiiStripeRequiredTime, ixStripeRequiredTime: ixStripeRequiredTime, xStripeRequiredTime: xStripeRequiredTime, xiStripeRequiredTime: xiStripeRequiredTime, attendancePerBelt: attendancePerBelt, iStripeAttendance: iStripeAttendance, iiStripeAttendance: iiStripeAttendance, iiiStripeAttendance: iiiStripeAttendance, ivStripeAttendance: ivStripeAttendance, vStripeAttendance: vStripeAttendance, viStripeAttendance: viStripeAttendance, viiStripeAttendance: viiStripeAttendance, viiiStripeAttendance: viiiStripeAttendance, ixStripeAttendance: ixStripeAttendance, xStripeAttendance: xStripeAttendance, xiStripeAttendance: xiStripeAttendance)
    }
}
