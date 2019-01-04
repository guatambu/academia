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
    var kidMembers: [KidStudent]?
    var adultMembers: [AdultStudent]?
    
    // Memberwise Initializer
    
    init(groupUID: UUID, active: Bool, name: String, description: String?, dateCreated: Date, dateEdited: Date, kidMembers: [KidStudent]?, adultMembers: [AdultStudent]?) {
        
        self.groupUID = groupUID
        self.active = active
        self.name = name
        self.description = description
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.kidMembers = kidMembers
        self.adultMembers = adultMembers
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
        if lhs.kidMembers != rhs.kidMembers { return false }
        if lhs.adultMembers != rhs.adultMembers { return false }
        
        return true
    }
}











































