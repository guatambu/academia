//
//  Group+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension Group {
    
    convenience init(groupUID: String, active: Bool, name: String, dateCreated: Date, dateEdited: Date, members: [Any]?, context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.groupUID = groupUID
        self.active = active
        self.name = name
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.members = members
    }
    
}


//extension Group: Equatable {
//    
//    static func ==(lhs: Group, rhs: Group) -> Bool {
//        if lhs.active != rhs.active { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.groupUID != rhs.groupUID { return false }
//        if lhs.name != rhs.name { return false }
//        
//        return true
//    }
//}

