//
//  GroupX.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class GroupX {
    
    // MARK: - Properties
    
    // UID
    let groupUID: String
    
    var active: Bool
    var name: String
    var dateCreated: Date
    var dateEdited: Date
    var members: [Any]?
    
    // Memberwise Initializer
    
    init(groupUID: String, active: Bool, name: String, dateCreated: Date, dateEdited: Date, members: [Any]?) {
        
        self.groupUID = groupUID
        self.active = active
        self.name = name
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.members = members
    }
}

extension GroupX: Equatable {
    
    static func ==(lhs: GroupX, rhs: GroupX) -> Bool {
        if lhs.active != rhs.active { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.groupUID != rhs.groupUID { return false }
        if lhs.name != rhs.name { return false }
        
        return true
    }
}











































