//
//  AulaCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class AulaCDModelController {
    
    // MARK: - Properties
    
    static let shared = AulaCDModelController()
    
    var aulas: [AulaCD] {
        let fetchRequest: NSFetchRequest<AulaCD> = AulaCD.fetchRequest()
        
        let aulaNameSort = NSSortDescriptor(key: "aulaName", ascending: true)
        fetchRequest.sortDescriptors = [aulaNameSort]
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(aula: AulaCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(aula: AulaCD) {
        
        if let moc = aula.managedObjectContext {
            
            moc.delete(aula)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(aula: AulaCD,
                active: Bool?,
                aulaName: String?,
                aulaDescription: String?,
                dayOfTheWeek: String?,
                timeCode: Int16?,
                time: String?) {
        
        aula.dateEdited = Date()
        
        if let aulaName = aulaName {
            aula.aulaName = aulaName
        }
        if let aulaDescription = aulaDescription {
            aula.aulaDescription = aulaDescription
        }
        if let dayOfTheWeek = dayOfTheWeek {
            aula.dayOfTheWeek = dayOfTheWeek
        }
        if let timeCode = timeCode {
            aula.timeCode = timeCode
        }
        if let time = time {
            aula.time = time
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
