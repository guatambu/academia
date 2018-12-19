//
//  GroupModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class GroupModelController {
    
    static let shared = GroupModelController()
    
    var groups = [Group]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func add(active: Bool, name: String, members: [Any]?) {
        
        let group = Group(groupUID: UUID(), active: active, name: name, dateCreated: Date(), dateEdited: Date(), members: members)
        
        groups.append(group)
    }
    
    // Read
    
    
    // Update
    func update(group: Group, active: Bool?, name: String?, members: [Any]?) {
        
        group.dateEdited = Date()
        
        if let active = active {
            group.active = active
        }
        if let name = name {
            group.name = name
        }
        if let members = members {
            group.members = members
        }
    }
    
    
    // Delete
    func delete(group: Group) {
        guard let index = self.groups.index(of: group) else { return }
        self.groups.remove(at: index)
    }
    
    
}
