//
//  TechniqueFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol TechniqueFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct TechniqueFirestore {
    
    var techniqueUUID: String
    var name: String
    var dateCreated: Date
    var dateEdited: Date
    var descriptionDetail: String
    var skillLevel: InternationalStandardBJJBelts
    var images: [String]?
    
    
    var dictionary: [String : Any] {
        return [
            "techniqueUUID" : techniqueUUID,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "name" : name,
            "descriptionDetail" : descriptionDetail,
            "skillLevel" : skillLevel,
            "images" : images ?? []
        ]
    }
    
    
    // initializer to allow creation of an TechniqueFirestore model object
    init(techniqueUUID: String = "\(UUID())",
         name: String,
         dateCreated: Date,
         dateEdited: Date,
         descriptionDetail: String,
         skillLevel: InternationalStandardBJJBelts,
         images: [String]?
        ) {
        
        self.techniqueUUID = techniqueUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.descriptionDetail = descriptionDetail
        self.skillLevel = skillLevel
        self.images = images
    }
}


extension TechniqueFirestore: TechniqueFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let techniqueUUID = dictionary["techniqueUUID"] as? String else {
            
            print("ERROR: nil value found for techniqueUUID in firestore dictionary in TechniqueFirestore.swift -> init(dictionary:) - line 68.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in TechniqueFirestore.swift -> init(dictionary:) - line 74.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in TechniqueFirestore.swift -> init(dictionary:) - line 80.")
            return nil
        }
        
        guard let name = dictionary["name"] as? String else {
            
            print("ERROR: nil value found for name in firestore dictionary in TechniqueFirestore.swift -> init(dictionary:) - line 86.")
            return nil
        }
        
        guard let descriptionDetail = dictionary["descriptionDetail"] as? String else {
            
            print("ERROR: nil value found descriptionDetail in firestore dictionary in TechniqueFirestore.swift -> init(dictionary:) - line 92.")
            return nil
        }
        
        guard let skillLevel = dictionary["skillLevel"] as? InternationalStandardBJJBelts else {
            
            print("ERROR: nil value found for skillLevel in firestore dictionary in TechniqueFirestore.swift -> init(dictionary:) - line 98.")
            return nil
        }
        
        guard let images = dictionary["images"] as? [String] else {
            
            print("ERROR: nil value found for images in firestore dictionary in TechniqueFirestore.swift -> init(dictionary:) - line 104.")
            return nil
        }
        
        self.init(techniqueUUID: techniqueUUID, name: name, dateCreated: dateCreated, dateEdited: dateEdited, descriptionDetail: descriptionDetail, skillLevel: skillLevel, images: images)
    }
}
