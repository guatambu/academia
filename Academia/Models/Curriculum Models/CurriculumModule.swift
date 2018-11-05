//
//  CurriculumModule.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/2/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class CurriculumModule {
    
    // MARK: - Properties
    
    // UID
    let curriculumModuleUID: UUID
    
    var name: String
    var dateCreated: Date
    var dateEdited: Date
    var descriptionDetail: String
    var techniques: [Technique]
    
    // initialization
    init(curriculumModuleUID: UUID,
         name: String,
         dateCreated: Date,
         dateEdited: Date,
         descriptionDetail: String,
         techniques: [Technique]) {
        
        self.curriculumModuleUID = curriculumModuleUID
        self.name = name
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.descriptionDetail = descriptionDetail
        self.techniques = techniques
    }
    
}

extension CurriculumModule: Equatable {
    
    static func ==(lhs: CurriculumModule, rhs: CurriculumModule) -> Bool {

        if lhs.curriculumModuleUID != rhs.curriculumModuleUID { return false }
        if lhs.name != rhs.name { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.descriptionDetail != rhs.descriptionDetail { return false }
        if lhs.techniques != rhs.techniques { return false }
        
        return true
    }
}
