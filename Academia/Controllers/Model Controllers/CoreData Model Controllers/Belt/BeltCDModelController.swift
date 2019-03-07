//
//  BeltCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class BeltCDModelController {
    
    // MARK: - Properties
    
    static let shared = BeltCDModelController()
    
    var belts: [BeltCD] {
        let fetchRequest: NSFetchRequest<BeltCD> = BeltCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(belt: BeltCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(belt: BeltCD) {
        
        if let moc = belt.managedObjectContext {
            
            moc.delete(belt)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(belt: BeltCD,
                active: Bool?,
                elligibleForNextBelt: Bool?, beltLevel: String?, numberOfStripes: Int16?) {
        
        belt.dateEdited = Date()
        
        if let active = active {
            belt.active = active
        }
        if let elligibleForNextBelt = elligibleForNextBelt {
            belt.elligibleForNextBelt = elligibleForNextBelt
        }
        if let beltLevel = beltLevel {
            belt.beltLevel = beltLevel
        }
        if let numberOfStripes = numberOfStripes {
            belt.numberOfStripes = numberOfStripes
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
