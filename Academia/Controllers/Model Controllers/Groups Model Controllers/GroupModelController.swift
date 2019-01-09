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
    func add(active: Bool, name: String, description: String?, kidMembers: [KidStudent]?, adultMembers: [AdultStudent]?) {
        
        let group = Group(groupUID: UUID(), active: active, name: name, description: description, dateCreated: Date(), dateEdited: Date(), kidMembers: kidMembers, adultMembers: adultMembers)
        
        groups.append(group)
    }
    
    // Read
    
    
    // Update
    func update(group: Group, active: Bool?, name: String?, description: String?, kidMembers: [KidStudent]?, adultMembers: [AdultStudent]?, kidStudent: KidStudent?, adultStudent: AdultStudent?) {
        
        group.dateEdited = Date()
        
        if let active = active {
            group.active = active
        }
        if let name = name {
            group.name = name
        }
        if let description = description {
            group.description = description
        }
        if let kidMembers = kidMembers {
            group.kidMembers = kidMembers
        }
        if let adultMembers = adultMembers {
            group.adultMembers = adultMembers
        }
        if let kidStudent = kidStudent {
            group.kidMembers?.append(kidStudent)
        }
        if let adultStudent = adultStudent {
            group.adultMembers?.append(adultStudent)
        }
        
    }
    
    
    // Delete
    func delete(group: Group) {
        guard let index = self.groups.index(of: group) else { return }
        self.groups.remove(at: index)
    }
    
}
