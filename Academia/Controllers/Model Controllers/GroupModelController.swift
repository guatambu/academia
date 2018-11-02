//
//  GroupModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 10/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class GroupModelController {
    
    static let shared = GroupModelController()
    
    var groups = [Group]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func add(profilePic: UIImage?, active: Bool, name: String, members: [Any]?) {
        
        let group = Group(groupUID: UUID(), active: active, name: name, dateCreated: Date(), dateEdited: Date(), members: members)
        
        groups.append(group)
    }
    
    // Read
    
    
    // Update
    func update(group: Group, active: Bool, name: String, members: [Any]?) {
        
        group.active = active
        group.dateEdited = Date()
        group.members = members
        group.name = name
    }
    
    
    // Delete
    func delete(group: Group) {
        guard let index = self.groups.index(of: group) else { return }
        self.groups.remove(at: index)
    }
    
    
}
