//
//  Group.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Group {
    
    // MARK: - Properties
    
    // UID
    let groupUID: UUID
    
    var active: Bool
    var name: String
    var description: String?
    var dateCreated: Date
    var dateEdited: Date
    var members: [Any]?
    
    // Memberwise Initializer
    
    init(groupUID: UUID, active: Bool, name: String, description: String?, dateCreated: Date, dateEdited: Date, members: [Any]?) {
        
        self.groupUID = groupUID
        self.active = active
        self.name = name
        self.description = description
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.members = members
    }
}

extension Group: Equatable {
    
    static func ==(lhs: Group, rhs: Group) -> Bool {
        if lhs.groupUID != rhs.groupUID { return false }
        if lhs.active != rhs.active { return false }
        if lhs.name != rhs.name { return false }
        if lhs.description != rhs.description { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        
        return true
    }
}











































