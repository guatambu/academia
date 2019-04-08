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
    
    var adultStudentOnboardingTasks: [OnBoardingTask] = [
        
        OnBoardingTask(onboardingTaskUID: UUID(), name: "welcome", title: "Welcome!", descriptionDetail: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "setUpPaymentPrograms", title: "Sign Up For Your Program", descriptionDetail: "Please choose the appropriate program according to your teacher.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "messagingGroups", title: "News From The Source", descriptionDetail: "Please have your teacher add you to your academy's message group(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "viewClassSchedule", title: "View Current Classes", descriptionDetail: "Here you can view the academy's full schedule.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "learnTheBeltSystems", title: "Learn The Belt Systems", descriptionDetail: "Please take a moment to review yor school's Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedAdultStudentOnboardingTasks: [OnBoardingTask] = []
    
    
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
