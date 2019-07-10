//
//  BeltStripeAgeDetailsFirestore.swift
//  Academia
//
//  Created by Michel Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol BeltStripeAgeDetailsFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct BeltStripeAgeDetailsFirestore {
    
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
    var dateCreated: Date
    var dateEdited: Date
    
    
    var dictionary: [String : Any] {
        return [
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
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited
        ]
    }
    
    
    // initializer to allow creation of a BeltStripeAgeDetailsFirestore object
    init(beltRequiredTime: String?,
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
         dateCreated: Date = Date(),
         dateEdited: Date = Date()
        ) {
        
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
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
    }
}


extension BeltStripeAgeDetailsFirestore: BeltStripeAgeDetailsFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let beltRequiredTime = dictionary["beltRequiredTime"] as? String else {
            
            print("ERROR: nil value found for beltRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 100.")
            return nil
        }
        
        guard let minAgeRequirements = dictionary["minAgeRequirements"] as? String else {
            
            print("ERROR: nil value found for minAgeRequirements in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 106.")
            return nil
        }
        
        guard let iStripeRequiredTime = dictionary["iStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for iStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 112.")
            return nil
        }
        
        guard let iiStripeRequiredTime = dictionary["iiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for iiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let iiiStripeRequiredTime = dictionary["iiiStripeRequiredTime"] as? String else {

            print("ERROR: nil value found for iiiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 124.")
            return nil
        }

        guard let ivStripeRequiredTime = dictionary["ivStripeRequiredTime"] as? String else {

            print("ERROR: nil value found for ivStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
        guard let vStripeRequiredTime = dictionary["vStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found StripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 136.")
            return nil
        }
        
        guard let viStripeRequiredTime = dictionary["viStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for viStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        guard let viiStripeRequiredTime = dictionary["viiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for viiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 148.")
            return nil
        }
        
        guard let viiiStripeRequiredTime = dictionary["viiiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for viiiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 154.")
            return nil
        }
        
        guard let ixStripeRequiredTime = dictionary["iStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for ixStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 160.")
            return nil
        }

        guard let xStripeRequiredTime = dictionary["xStripeRequiredTime"] as? String else {

            print("ERROR: nil value found for xStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 166.")
            return nil
        }
        
        guard let xiStripeRequiredTime = dictionary["xiStripeRequiredTime"] as? String else {
            
            print("ERROR: nil value found for xiStripeRequiredTime in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 172.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 178.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in BeltStripeAgeDetailsFirestore.swift -> init(dictionary:) - line 184.")
            return nil
        }
    
        
        self.init(beltRequiredTime: beltRequiredTime, minAgeRequirements: minAgeRequirements, iStripeRequiredTime: iStripeRequiredTime, iiStripeRequiredTime: iiStripeRequiredTime, iiiStripeRequiredTime: iiiStripeRequiredTime, ivStripeRequiredTime: ivStripeRequiredTime, vStripeRequiredTime: vStripeRequiredTime, viStripeRequiredTime: viStripeRequiredTime, viiStripeRequiredTime: viiStripeRequiredTime, viiiStripeRequiredTime: viiiStripeRequiredTime, ixStripeRequiredTime: ixStripeRequiredTime, xStripeRequiredTime: xStripeRequiredTime, xiStripeRequiredTime: xiStripeRequiredTime, dateCreated: dateCreated, dateEdited: dateEdited)
    }
}
