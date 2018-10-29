//
//  KidStudentModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/18/18.
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
        
        OnBoardingTask(onboardingTaskUID: "001", name: "welcome", title: "Welcome!", description: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "002", name: "setUpPaymentPrograms", title: "Sign Up For Your Program", description: "Please choose the appropriate program according to your teacher.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "003", name: "messagingGroups", title: "News From The Source", description: "Please have your teacher add you to your academy's message group(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "004", name: "viewClassSchedule", title: "View Upcoming Classes", description: "Here you can view the academy's full schedule.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "005", name: "learnTheBeltSystems", title: "Learn The Belt Systems", description: "Please take a moment to review yor school's Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedKidStudentOnboardingTasks: [OnBoardingTask] = []
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(birthdate: Date, kidsBelt: KidsBelt?, profilePic: UIImage?, username: String, firstName: String, lastName: String, parentGuardian: String?, streetAddress: String, city: String, state: String, zipCode: String, phone: String, mobile: String, email: String, emergencyContact: String, emergencyContactPhone: String, emergencyContactRelationship: String) {
        
        let kid = KidStudent(kidUID: "003", dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.inactive], groups: nil, paymentProgram: nil, permission: [UserPermissions.parentGuardian], kidsBelt: nil, profilePic: profilePic, username: username, firstName: firstName, lastName: lastName, parentGuardian: parentGuardian, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email, emergencyContact: emergencyContact, emergencyContactPhone: emergencyContactPhone, emergencyContactRelationship: emergencyContactRelationship)
        
        kids.append(kid)
    }
    
    // Read
    
    
    // Update
    func updateProfileInfo(kidStudent: KidStudent, birthdate: Date, city: String, email: String, firstName: String, groups: [Group]?, lastNAme: String, mobile: String, parentGuardian: String, permission: [UserPermissions], phone: String, profilePic: UIImage?, state: String, streetAddress: String, username: String, zipCode: String, emergencyContact: String, emergencyContactPhone: String, emergencyContactRelationship: String) {
        
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
        kidStudent.streetAddress = streetAddress
        kidStudent.username = username
        kidStudent.zipCode = zipCode
    }
    
    func promote(kidStudent: KidStudent, kidsBelt: KidsBelt, mostRecentPromotion: Date, promotions: [String: Date]) {
        kidStudent.kidsBelt = kidsBelt
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
























