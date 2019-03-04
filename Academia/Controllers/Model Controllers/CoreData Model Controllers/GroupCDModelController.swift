//
//  GroupCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class GroupCDModelController {
    
    // MARK: - Properties
    
    static let shared = GroupCDModelController()
    
    var groups: [GroupCD] {
        let fetchRequest: NSFetchRequest<GroupCD> = GroupCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(group: GroupCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(group: GroupCD) {
        
        if let moc = group.managedObjectContext {
            
            moc.delete(group)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(group: GroupCD,
                active: Bool?,
                name: String?,
                groupDescription: String?) {
        
        group.dateEdited = Date()
        
        if let name = name {
            group.name = name
        }
        if let groupDescription = groupDescription {
            group.groupDescription = groupDescription
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
