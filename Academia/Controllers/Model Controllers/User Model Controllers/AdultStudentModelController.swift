//
//  AdultStudentModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class AdultStudentModelController {
    
    static let shared = AdultStudentModelController()
    
    var adults = [AdultStudent]()
    var adultStudentAttendance = [Date]()
    
    var numberTasksCompleted: Int = 0
    
    var adultStudentOnboardingTasks: [OnBoardingTask] = [
        
        OnBoardingTask(onboardingTaskUID: UUID(), name: "welcome", title: "Welcome!", descriptionDetail: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "setUpPaymentPrograms", title: "Sign Up For Your Program", descriptionDetail: "Please choose the appropriate program according to your teacher.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "messagingGroups", title: "News From The Source", descriptionDetail: "Please have your teacher add you to your academy's message group(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "viewClassSchedule", title: "View Upcoming Classes", descriptionDetail: "Here you can view the academy's full schedule.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: UUID(), name: "learnTheBeltSystems", title: "Learn The Belt Systems", descriptionDetail: "Please take a moment to review yor school's Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedAdultStudentOnboardingTasks: [OnBoardingTask] = []
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(birthdate: Date,
                belt: Belt,
                profilePic: UIImage?,
                username: String,
                password: String,
                firstName: String,
                lastName: String,
                addressLine1: String,
                addressLine2: String,
                city: String,
                state: String,
                zipCode: String,
                phone: String,
                mobile: String,
                email: String,
                emergencyContactName: String,
                emergencyContactPhone: String,
                emergencyContactRelationship: String) {
        
        let adult = AdultStudent(adultStudentUID: UUID(),
                                 isInstructor: false,
                                 dateCreated: Date(),
                                 dateEdited: Date(),
                                 birthdate: birthdate,
                                 promotions: nil,
                                 mostRecentPromotion: nil,
                                 attendance: nil,
                                 studentStatus: [StudentStatus.active],
                                 groups: nil,
                                 paymentProgram: nil,
                                 permission: [UserPermissions.adultStudent],
                                 belt: belt,
                                 profilePic: profilePic,
                                 username: username,
                                 password: password,
                                 firstName: firstName,
                                 lastName: lastName,
                                 addressLine1: addressLine1,
                                 addressLine2: addressLine2,
                                 city: city,
                                 state: state,
                                 zipCode: zipCode,
                                 phone: phone,
                                 mobile: mobile,
                                 email: email,
                                 emergencyContactName: emergencyContactName,
                                 emergencyContactPhone: emergencyContactPhone,
                                 emergencyContactRelationship: emergencyContactRelationship)
        
        adults.append(adult)
    }
    
    // Read
    
    
    // Update
    func updateProfileInfo(adultStudent: AdultStudent,
                           birthdate: Date?,
                           groups: [Group]?,
                           permission: [UserPermissions]?,
                           belt: Belt?,
                           profilePic: UIImage?,
                           username: String?,
                           firstName: String?,
                           lastName: String?,
                           addressLine1: String?,
                           addressLine2: String?,
                           city: String?,
                           state: String?,
                           zipCode: String?,
                           phone: String?,
                           mobile: String?,
                           email: String?,
                           emergencyContactName: String?,
                           emergencyContactPhone: String?,
                           emergencyContactRelationship: String?) {
        
        adultStudent.dateEdited = Date()
        
        if let birthdate = birthdate {
            adultStudent.birthdate = birthdate
            
        } else if let groups = groups {
            adultStudent.groups = groups
            
        } else if let permission = permission {
            adultStudent.permission = permission
            
        } else if let belt = belt {
            adultStudent.belt = belt
            
        } else if let profilePic = profilePic {
            adultStudent.profilePic = profilePic
            
        } else if let username = username {
            adultStudent.username = username
            
        } else if let firstName = firstName {
            adultStudent.firstName = firstName
            
        } else if let lastName = lastName {
            adultStudent.lastName = lastName
            
        } else if let addressLine1 = addressLine1 {
            adultStudent.addressLine1 = addressLine1
            
        } else if let addressLine2 = addressLine2 {
            adultStudent.addressLine2 = addressLine2
            
        } else if let city = city {
            adultStudent.city = city
            
        } else if let state = state {
            adultStudent.state = state
            
        } else if let zipCode = zipCode {
            adultStudent.zipCode = zipCode
            
        } else if let phone = phone {
            adultStudent.phone = phone
            
        } else if let mobile = mobile {
            adultStudent.mobile = mobile
            
        } else if let email = email {
            adultStudent.email = email
            
        } else if let emergencyContactName = emergencyContactName {
            adultStudent.emergencyContactName = emergencyContactName
            
        } else if let emergencyContactPhone = emergencyContactPhone {
            adultStudent.emergencyContactPhone = emergencyContactPhone
            
        } else if let emergencyContactRelationship = emergencyContactRelationship {
            adultStudent.emergencyContactRelationship = emergencyContactRelationship
        }
    }
    
    func promote(adultStudent: AdultStudent, belt: Belt, mostRecentPromotion: Date, promotions: [String: Date]) {
        adultStudent.belt = belt
        adultStudent.mostRecentPromotion = mostRecentPromotion
        adultStudent.promotions = promotions
    }
    
    func markAttendaence(adultStudent: AdultStudent, attendance: Date) {
        self.adultStudentAttendance.append(attendance)
        adultStudent.attendance = self.adultStudentAttendance
    }
    
    
    // Delete
    func delete(adultStudent: AdultStudent) {
        guard let index = self.adults.index(of: adultStudent) else { return }
        self.adults.remove(at: index)
    }
    
}


























