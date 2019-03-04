//
//  StudentAdultCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class StudentAdultCDModelController {
    
    // MARK: - Properties
    
    static let shared = StudentAdultCDModelController()
    
    var studentAdults: [StudentAdultCD] {
        let fetchRequest: NSFetchRequest<StudentAdultCD> = StudentAdultCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(studentAdult: StudentAdultCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(studentAdult: StudentAdultCD) {
        
        if let moc = studentAdult.managedObjectContext {
            
            moc.delete(studentAdult)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(studentAdult: StudentAdultCD,
                isInstructor: Bool?,
                birthdate: Date?,
                mostRecentPromotion: Date?,
                studentStatus: StudentStatusCD?,
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
        
        studentAdult.dateEdited = Date()
        
        if let isInstructor = isInstructor {
            studentAdult.isInstructor = isInstructor
        }
        if let birthdate = birthdate {
            studentAdult.birthdate = birthdate
        }
        if let mostRecentPromotion = mostRecentPromotion {
            studentAdult.mostRecentPromotion = mostRecentPromotion
        }
        if let belt = belt {
            studentAdult.belt = belt
        }
        if let profilePic = profilePic {
            studentAdult.profilePic = profilePic
        }
        if let username = username {
            studentAdult.username = username
        }
        if let firstName = firstName {
            studentAdult.firstName = firstName
        }
        if let lastName = lastName {
            studentAdult.lastName = lastName
        }
        if let address = address {
            studentAdult.address = address
        }
        if let phone = phone {
            studentAdult.phone = phone
        }
        if let mobile = mobile {
            studentAdult.mobile = mobile
        }
        if let email = email {
            studentAdult.email = email
        }
        if let emergencyContact = emergencyContact {
            studentAdult.emergencyContact = emergencyContact
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
