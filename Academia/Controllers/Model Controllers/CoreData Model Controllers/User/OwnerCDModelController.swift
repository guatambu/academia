//
//  OwnerCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class OwnerCDModelController {
    
    // MARK: - Properties
    
    static let shared = OwnerCDModelController()
    
    var owners: [OwnerCD] {
        let fetchRequest: NSFetchRequest<OwnerCD> = OwnerCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(owner: OwnerCD) {
        saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(owner: OwnerCD) {
        
        if let moc = owner.managedObjectContext {
            
            moc.delete(owner)
            saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(owner: OwnerCD,
                isInstructor: Bool?,
                birthdate: Date?,
                mostRecentPromotion: Date?,
                belt: BeltCD?,
                profilePic: Data?,
                username: String?,
                password: String?,
                firstName: String?,
                lastName: String?,
                address: AddressCD?,
                phone: String?,
                mobile: String?,
                email: String?,
                emergencyContact: EmergencyContactCD?) {
        
        owner.dateEdited = Date()
        
        if let isInstructor = isInstructor {
            owner.isInstructor = isInstructor
        }
        if let birthdate = birthdate {
            owner.birthdate = birthdate
        }
        if let mostRecentPromotion = mostRecentPromotion {
            owner.mostRecentPromotion = mostRecentPromotion
        }
        if let belt = belt {
            owner.belt = belt
        }
        if let profilePic = profilePic {
            owner.profilePic = profilePic
        }
        if let username = username {
            owner.username = username
        }
        if let firstName = firstName {
            owner.firstName = firstName
        }
        if let lastName = lastName {
            owner.lastName = lastName
        }
        if let address = address {
            owner.address = address
        }
        if let phone = phone {
            owner.phone = phone
        }
        if let mobile = mobile {
            owner.mobile = mobile
        }
        if let email = email {
            owner.email = email
        }
        if let emergencyContact = emergencyContact {
            owner.emergencyContact = emergencyContact
        }
        
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStorage() {
        
        do {
            try CoreDataStack.context.save()
        } catch {
            print("ERROR: there was an error saving to persitent store. \(error) \(error.localizedDescription)")
        }
    }
}
