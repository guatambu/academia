//
//  Technique.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/2/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class Technique {
    
    // MARK: - Properties
    
    // UID
    let techniqueUID: UUID
    
    var name: String
    var dateCreated: Date
    var dateEdited: Date
    var descriptionDetail: String
    var skillLevel: InternationalStandardBJJBelts
    
    // initialization
    init(techniqueUID: UUID,
         name: String,
         dateCreated: Date,
         dateEdited: Date,
         descriptionDetail: String,
         skillLevel: InternationalStandardBJJBelts) {
        
        self.techniqueUID = techniqueUID
        self.name = name
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.descriptionDetail = descriptionDetail
        self.skillLevel = skillLevel
    }
    
}

extension Technique: Equatable {
    
    static func ==(lhs: Technique, rhs: Technique) -> Bool {
        if lhs.techniqueUID != rhs.techniqueUID { return false }
        if lhs.name != rhs.name { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.descriptionDetail != rhs.descriptionDetail { return false }
        if lhs.skillLevel != rhs.skillLevel { return false }
        
        return true
    }
}
