//
//  Curriculum.swift
//  Academia
//
//  Created by Kelly Johnson on 11/2/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation


class Curriculum {
    
    // MARK: - Properties
    
    // UID
    let curriculumUID: UUID
    
    var name: String
    var dateCreated: Date
    var dateEdited: Date
    var descriptionDetail: String
    var modules: [CurriculumModule]
    
    // initialization
    init(curriculumUID: UUID,
         name: String,
         dateCreated: Date,
         dateEdited: Date,
         descriptionDetail: String,
         modules: [CurriculumModule]) {
        
        self.curriculumUID = curriculumUID
        self.name = name
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.descriptionDetail = descriptionDetail
        self.modules = modules
    }
    
}

extension Curriculum: Equatable {
    
    static func ==(lhs: Curriculum, rhs: Curriculum) -> Bool {
        
        if lhs.curriculumUID != rhs.curriculumUID { return false }
        if lhs.name != rhs.name { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.descriptionDetail != rhs.descriptionDetail { return false }
        if lhs.modules != rhs.modules { return false }
        
        return true
    }
}
