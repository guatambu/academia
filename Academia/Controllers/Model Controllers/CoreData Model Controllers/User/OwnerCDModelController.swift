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
    
    var numberTasksCompleted: Int = 0
    
    var ownerOnboardingTasks: [OnBoardingTask] = [
        
        OnBoardingTask(onboardingTaskUID: UUID(), name: "welcome", title: "Welcome!", descriptionDetail: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "startGettingPaid", title: "Start getting paid", descriptionDetail: "Set up your account to receive your payments.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "setUpPaymentPrograms", title: "$0.00 in sales", descriptionDetail: "Please set the Payment Program(s) for your school.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "locationsSetUp", title: "No Locations", descriptionDetail: "Please add your School Location(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "messagingGroups", title: "0 Messaging Groups", descriptionDetail: "Please create Messaging Group(s) for your academy.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "createClassSchedule", title: "No Classes Scheduled", descriptionDetail: "Please set up Your School's complete Class Schedule", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "reviewBeltSystems", title: "Review Belt Systems", descriptionDetail: "Please Take a moment to review the included Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedOwnerOnboardingTasks: [OnBoardingTask] = []
    
    
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
