//
//  CurriculumFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol CurriculumFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct CurriculumFirestore {
    
    var curriculumUUID: String
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var name: String
    var descriptionDetail: String
    var modules: [CurriculumModuleFirestore]
    
    
    var dictionary: [String : Any] {
        return [
            "curriculumUUID" : curriculumUUID,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "name" : name,
            "descriptionDetail" : descriptionDetail,
            "modules" : modules
        ]
    }
    
    
    // initializer to allow creation of an CurriculumFirestore object
    init(curriculumUUID: String = "\(UUID())",
         dateCreated: Timestamp,
         dateEdited: Timestamp,
         name: String,
         descriptionDetail: String,
         modules: [CurriculumModuleFirestore]
        ) {
        
        self.curriculumUUID = curriculumUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.descriptionDetail = descriptionDetail
        self.modules = modules
    }
}


extension CurriculumFirestore: CurriculumFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let curriculumUUID = dictionary["curriculumUUID"] as? String else {
            
            print("ERROR: nil value found for curriculumUUID in firestore dictionary in TestModel.swift -> init(dictionary:) - line 65.")
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
            
            print("ERROR: nil value found for name in firestore dictionary in TestModel.swift -> init(dictionary:) - line 83.")
            return nil
        }
        
        guard let descriptionDetail = dictionary["descriptionDetail"] as? String else {
            
            print("ERROR: nil value found for descriptionDetail in firestore dictionary in TestModel.swift -> init(dictionary:) - line 89.")
            return nil
        }
        
        guard let modules = dictionary["modules"] as? [CurriculumModuleFirestore] else {
            
            print("ERROR: nil value found for modules in firestore dictionary in TestModel.swift -> init(dictionary:) - line 95.")
            return nil
        }
        
        self.init(curriculumUUID: curriculumUUID, dateCreated: dateCreated, dateEdited: dateEdited, name: name, descriptionDetail: descriptionDetail, modules: modules)
    }
}
