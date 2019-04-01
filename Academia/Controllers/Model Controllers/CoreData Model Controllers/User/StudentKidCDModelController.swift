//
//  StudentKidCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class StudentKidCDModelController {
    
    // MARK: - Properties
    
    static let shared = StudentKidCDModelController()
    
    var studentKids: [StudentKidCD] {
        let fetchRequest: NSFetchRequest<StudentKidCD> = StudentKidCD.fetchRequest()
        
        let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
        let firstNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        
        fetchRequest.sortDescriptors = [lastNameSort, firstNameSort]
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(studentKid: StudentKidCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(studentKid: StudentKidCD) {
        
        if let moc = studentKid.managedObjectContext {
            
            moc.delete(studentKid)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(studentKid: StudentKidCD,                
                birthdate: Date?,
                mostRecentPromotion: Date?,
                studentStatus: StudentStatusCD?,
                belt: BeltCD?,
                profilePic: Data?,
                username: String?,
                password: String?,
                firstName: String?,
                lastName: String?,
                parentGuardian: String?,
                address: AddressCD?,
                phone: String?,
                mobile: String?,
                email: String?,
                emergencyContact: EmergencyContactCD?) {
        
        studentKid.dateEdited = Date()
        
        if let birthdate = birthdate {
            studentKid.birthdate = birthdate
        }
        if let mostRecentPromotion = mostRecentPromotion {
            studentKid.mostRecentPromotion = mostRecentPromotion
        }
        if let belt = belt {
            studentKid.belt = belt
        }
        if let profilePic = profilePic {
            studentKid.profilePic = profilePic
        }
        if let username = username {
            studentKid.username = username
        }
        if let firstName = firstName {
            studentKid.firstName = firstName
        }
        if let lastName = lastName {
            studentKid.lastName = lastName
        }
        if let parentGuardian = parentGuardian {
            studentKid.parentGuardian = parentGuardian
        }
        if let address = address {
            studentKid.address = address
        }
        if let phone = phone {
            studentKid.phone = phone
        }
        if let mobile = mobile {
            studentKid.mobile = mobile
        }
        if let email = email {
            studentKid.email = email
        }
        if let emergencyContact = emergencyContact {
            studentKid.emergencyContact = emergencyContact
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
