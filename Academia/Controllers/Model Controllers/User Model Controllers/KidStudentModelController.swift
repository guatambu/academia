//
//  KidStudentModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class KidStudentModelController {
    
    static let shared = KidStudentModelController()
    
    var kids = [KidStudent]()
    var kidStudentAttendance = [Date]()
    
    var numberTasksCompleted: Int = 0
    
    var kidStudentOnboardingTasks: [OnBoardingTask] = [
        
        OnBoardingTask(onboardingTaskUID: UUID(), name: "welcome", title: "Welcome!", descriptionDetail: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "setUpPaymentPrograms", title: "Sign Up For Your Program", descriptionDetail: "Please choose the appropriate program according to your teacher.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "messagingGroups", title: "News From The Source", descriptionDetail: "Please have your teacher add you to your academy's message group(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "viewClassSchedule", title: "View Upcoming Classes", descriptionDetail: "Here you can view the academy's full schedule.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "learnTheBeltSystems", title: "Learn The Belt Systems", descriptionDetail: "Please take a moment to review yor school's Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedKidStudentOnboardingTasks: [OnBoardingTask] = []
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(birthdate: Date, belt: Belt, profilePic: UIImage?, username: String, firstName: String, lastName: String, parentGuardian: String, addressLine1: String, addressLine2: String, city: String, state: String, zipCode: String, phone: String, mobile: String, email: String, emergencyContact: String, emergencyContactPhone: String, emergencyContactRelationship: String) {
        
        let kid = KidStudent(kidUID: UUID(), dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.inactive], groups: nil, paymentProgram: nil, permission: [UserPermissions.parentGuardian], belt: belt, profilePic: profilePic, username: username, firstName: firstName, lastName: lastName, parentGuardian: parentGuardian, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email, emergencyContactName: emergencyContact, emergencyContactPhone: emergencyContactPhone, emergencyContactRelationship: emergencyContactRelationship)
        
        kids.append(kid)
    }
    
    // Read
    
    
    // Update
    func updateProfileInfo(kidStudent: KidStudent, birthdate: Date, city: String, email: String, firstName: String, groups: [Group]?, lastNAme: String, mobile: String, parentGuardian: String, permission: [UserPermissions], phone: String, profilePic: UIImage?, state: String, addressLine1: String, addressLine2: String, username: String, zipCode: String, emergencyContact: String, emergencyContactPhone: String, emergencyContactRelationship: String) {
        
        kidStudent.birthdate = birthdate
        kidStudent.city = city
        kidStudent.dateEdited = Date()
        kidStudent.email = email
        kidStudent.firstName = firstName
        kidStudent.groups = groups
        kidStudent.lastName = lastNAme
        kidStudent.mobile = mobile
        kidStudent.parentGuardian = parentGuardian
        kidStudent.permission = permission
        kidStudent.phone = phone
        kidStudent.profilePic = profilePic
        kidStudent.state = state
        kidStudent.addressLine1 = addressLine1
        kidStudent.addressLine2 = addressLine2
        kidStudent.username = username
        kidStudent.zipCode = zipCode
    }
    
    func promote(kidStudent: KidStudent, belt: Belt, mostRecentPromotion: Date, promotions: [String: Date]) {
        kidStudent.belt = belt
        kidStudent.mostRecentPromotion = mostRecentPromotion
        kidStudent.promotions = promotions
    }
    
    func markAttendaence(kidStudent: KidStudent, attendance: Date) {
        self.kidStudentAttendance.append(attendance)
        kidStudent.attendance = self.kidStudentAttendance
        
    }
    
    
    // Delete
    func delete(kidStudent: KidStudent) {
        guard let index = self.kids.index(of: kidStudent) else { return }
        self.kids.remove(at: index)
    }
    
}
























