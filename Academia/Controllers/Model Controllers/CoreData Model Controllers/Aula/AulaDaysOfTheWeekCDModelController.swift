//
//  AulaDaysOfTheWeekCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class AulaDaysOfTheWeekCDModelController {
    
    // MARK: - Properties
    
    static let shared = AulaDaysOfTheWeekCDModelController()
    
    var aulas: [AulaDaysOfTheWeekCD] {
        let fetchRequest: NSFetchRequest<AulaDaysOfTheWeekCD> = AulaDaysOfTheWeekCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(aulaDaysOfTheWeek: AulaDaysOfTheWeekCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(aulaDaysOfTheWeek: AulaDaysOfTheWeekCD) {
        
        if let moc = aulaDaysOfTheWeek.managedObjectContext {
            
            moc.delete(aulaDaysOfTheWeek)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(aulaDaysOfTheWeek: AulaDaysOfTheWeekCD,
                sunday: String?,
                monday: String?,
                tuesday: String?,
                wednesday: String?,
                thursday: String?,
                friday: String?,
                saturday: String?) {
        
        if let sunday = sunday {
            aulaDaysOfTheWeek.sunday = sunday
        }
        if let monday = monday {
            aulaDaysOfTheWeek.monday = monday
        }
        if let tuesday = tuesday {
            aulaDaysOfTheWeek.tuesday = tuesday
        }
        if let wednesday = wednesday {
            aulaDaysOfTheWeek.wednesday = wednesday
        }
        if let thursday = thursday {
            aulaDaysOfTheWeek.thursday = thursday
        }
        if let friday = friday {
            aulaDaysOfTheWeek.friday = friday
        }
        if let saturday = saturday {
            aulaDaysOfTheWeek.saturday = saturday
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
