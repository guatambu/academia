//
//  GroupModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 10/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class GroupModelController {
    
    static let shared = GroupModelController()
    
    var groups = [Group]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addGroup(profilePic: UIImage?, active: Bool, name: String, members: [Any]?) {
        
        let group = Group(groupUID: "006", active: active, name: name, dateCreated: Date(), dateEdited: Date(), members: members)
        
        groups.append(group)
    }
    
    // Read
    
    
    // Update
    
    
    // Delete
    func deleteGroup(group: Group) {
        guard let index = self.groups.index(of: group) else { return }
        self.groups.remove(at: index)
    }
    
    
}
