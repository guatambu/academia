//
//  AulaAttendanceCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class AulaAttendanceCDModelController {
    
    // MARK: - Properties
    
    static let shared = AulaAttendanceCDModelController()
    
    var aulaAttendance: [AulaAttendanceCD] {
        let fetchRequest: NSFetchRequest<AulaAttendanceCD> = AulaAttendanceCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(aulaAttendance: AulaAttendanceCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(aulaAttendance: AulaAttendanceCD) {
        
        if let moc = aulaAttendance.managedObjectContext {
            
            moc.delete(aulaAttendance)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(aulaAttendance: AulaAttendanceCD,
                currentDate: Date = Date()) {
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
