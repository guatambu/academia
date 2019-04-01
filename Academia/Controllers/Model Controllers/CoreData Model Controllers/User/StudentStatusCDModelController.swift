//
//  StudentStatusCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class StudentStatusCDModelController {
    
    // MARK: - Properties
    
    static let shared = StudentStatusCDModelController()
    
    var studentStatus: [StudentStatusCD] {
        let fetchRequest: NSFetchRequest<StudentStatusCD> = StudentStatusCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(studentStatus: StudentStatusCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(studentStatus: StudentStatusCD) {
        
        if let moc = studentStatus.managedObjectContext {
            
            moc.delete(studentStatus)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(studentStatus: StudentStatusCD,
                active: Bool?,
                paid: Bool?,
                membershipPaused: Bool?,
                medicalMembershipPause: Bool?) {
        
        if let active = active {
            studentStatus.active = active
        }
        if let paid = paid {
            studentStatus.paid = paid
        }
        if let membershipPaused = membershipPaused {
            studentStatus.membershipPaused = membershipPaused
        }
        if let medicalMembershipPause = medicalMembershipPause {
            studentStatus.medicalMembershipPause = medicalMembershipPause
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
