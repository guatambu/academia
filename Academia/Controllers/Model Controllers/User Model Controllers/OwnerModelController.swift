//
//  OwnerModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/22/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class OwnerModelController {
    
    // MARK: - Properties
    
    static let shared = OwnerModelController()
    
    var owners = [Owner]()
    var ownerAttendance = [Date]()
    
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
        
        let owner = Owner(ownerUID: UUID(),
                          isInstructor: true,
                          dateCreated: Date(),
                          dateEdited: Date(),
                          birthdate: birthdate,
                          promotions: nil,
                          mostRecentPromotion: nil,
                          attendance: nil,
                          groups: nil,
                          permission: UserPermissions.owner,
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
        
        owners.append(owner)
    }
    
    // Read
    
    // Update
    func updateProfileInfo(owner: Owner,
                           isInstructor: Bool?,
                           birthdate: Date?,
                           groups: [Group]?,
                           permission: UserPermissions?,
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
        
        owner.dateEdited = Date()
        
        if let isInstructor = isInstructor {
        owner.isInstructor = isInstructor
            
        } else if let birthdate = birthdate {
            owner.birthdate = birthdate
            
        } else if let groups = groups {
            owner.groups = groups
            
        } else if let permission = permission {
            owner.permission = permission
            
        } else if let profilePic = profilePic {
            owner.profilePic = profilePic
            
        } else if let username = username {
            owner.username = username
            
        } else if let firstName = firstName {
            owner.firstName = firstName
            
        } else if let lastName = lastName {
            owner.lastName = lastName
            
        } else if let addressLine1 = addressLine1 {
            owner.addressLine1 = addressLine1
            
        } else if let addressLine2 = addressLine2 {
            owner.addressLine2 = addressLine2
            
        } else if let city = city {
            owner.city = city
            
        } else if let state = state {
            owner.state = state
            
        } else if let zipCode = zipCode {
            owner.zipCode = zipCode
            
        } else if let phone = phone {
            owner.phone = phone
            
        } else if let mobile = mobile {
            owner.mobile = mobile
            
        } else if let email = email {
            owner.email = email
            
        } else if let emergencyContactName = emergencyContactName {
            owner.emergencyContactName = emergencyContactName
            
        } else if let emergencyContactPhone = emergencyContactPhone {
            owner.emergencyContactPhone = emergencyContactPhone
            
        } else if let emergencyContactRelationship = emergencyContactRelationship {
            owner.emergencyContactRelationship = emergencyContactRelationship
        }
    }
    
    func promote(owner: Owner, belt: Belt, mostRecentPromotion: Date, promotions: [String: Date]) {
        owner.belt = belt
        owner.mostRecentPromotion = mostRecentPromotion
        owner.promotions = promotions
    }
    
    func markAttendaence(owner: Owner, attendance: Date) {
        self.ownerAttendance.append(attendance)
        owner.attendance = self.ownerAttendance
        
    }
    
    // Delete
    func delete(owner: Owner) {
        guard let index = self.owners.index(of: owner) else { return }
        self.owners.remove(at: index)
    }
    
    
    

}


























