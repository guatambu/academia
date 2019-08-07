//
//  CurriculumModuleFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol CurriculumModuleFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct CurriculumModuleFirestore {
    
    var curriculumModuleUUID: String
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var name: String
    var descriptionDetail: String
    var techniques: [TechniqueFirestore]
    
    
    var dictionary: [String : Any] {
        return [
            "curriculumModuleUUID" : curriculumModuleUUID,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "name" : name,
            "descriptionDetail" : descriptionDetail,
            "techniques" : techniques
        ]
    }
    
    
    // initializer to allow creation of an CurriculumModuleFirestore objcct
    init(curriculumModuleUUID: String = "\(UUID())",
         dateCreated: Timestamp,
         dateEdited: Timestamp,
         name: String,
         descriptionDetail: String,
         techniques: [TechniqueFirestore]
        ) {
        
        self.curriculumModuleUUID = curriculumModuleUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.descriptionDetail = descriptionDetail
        self.techniques = techniques
    }
}


extension CurriculumModuleFirestore: CurriculumModuleFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let curriculumModuleUUID = dictionary["curriculumModuleUUID"] as? String else {
            
            print("ERROR: nil value found for curriculumModuleUUID in firestore dictionary in TestModel.swift -> init(dictionary:) - line 65.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in TestModel.swift -> init(dictionary:) - line 71.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in TestModel.swift -> init(dictionary:) - line 77.")
            return nil
        }
        
        guard let name = dictionary["name"] as? String else {
            
            print("ERROR: nil value found name in firestore dictionary in TestModel.swift -> init(dictionary:) - line 83.")
            return nil
        }
        
        guard let descriptionDetail = dictionary["descriptionDetail"] as? String else {
            
            print("ERROR: nil value found for descriptionDetail in firestore dictionary in TestModel.swift -> init(dictionary:) - line 89.")
            return nil
        }
        
        guard let techniques = dictionary["techniques"] as? [TechniqueFirestore] else {
            
            print("ERROR: nil value found for techniques in firestore dictionary in TestModel.swift -> init(dictionary:) - line 95.")
            return nil
        }
        
        self.init(curriculumModuleUUID: curriculumModuleUUID, dateCreated: dateCreated, dateEdited: dateEdited, name: name, descriptionDetail: descriptionDetail, techniques: techniques)
    }
}
