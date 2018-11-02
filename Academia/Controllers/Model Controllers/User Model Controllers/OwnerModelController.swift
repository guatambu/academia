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
        
        OnBoardingTask(onboardingTaskUID: "001", name: "welcome", title: "Welcome!", descriptionDetail: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "002", name: "startGettingPaid", title: "Start getting paid", descriptionDetail: "Set up your account to receive your payments.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "003", name: "setUpPaymentPrograms", title: "$0.00 in sales", descriptionDetail: "Please set the Payment Program(s) for your school.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "004", name: "locationsSetUp", title: "No Locations", descriptionDetail: "Please add your School Location(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "005", name: "messagingGroups", title: "0 Messaging Groups", descriptionDetail: "Please create Messaging Group(s) for your academy.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "006", name: "createClassSchedule", title: "No Classes Scheduled", descriptionDetail: "Please set up Your School's complete Class Schedule", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "007", name: "reviewBeltSystems", title: "Review Belt Systems", descriptionDetail: "Please Take a moment to review the included Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedOwnerOnboardingTasks: [OnBoardingTask] = []
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(birthdate: Date, adultBasicBelt: AdultBasicBelt?, adultBlackBelt: AdultBlackBelt?, profilePic: UIImage?, username: String, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, phone: String, mobile: String, email: String) {
        
        let owner = Owner(ownerUID: "001", isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: birthdate, promotions: nil, mostRecentPromotion: nil, attendance: nil, groups: nil, permission: UserPermissions.owner, adultBasicBelt: adultBasicBelt, blackBelt: adultBlackBelt, profilePic: profilePic, username: username, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email)
        
        owners.append(owner)
    }
    
    // Read
    
    // Update
    func updateProfileInfo(owner: Owner, birthdate: Date, city: String, email: String, firstName: String, groups: [Group]?, isInstructor: Bool, lastNAme: String, mobile: String, permission: UserPermissions, phone: String, profilePic: UIImage?, state: String, streetAddress: String, username: String, zipCode: String) {
        
        owner.birthdate = birthdate
        owner.city = city
        owner.dateEdited = Date()
        owner.email = email
        owner.firstName = firstName
        owner.groups = groups
        owner.isInstructor = isInstructor
        owner.lastName = lastNAme
        owner.mobile = mobile
        owner.permission = permission
        owner.phone = phone
        owner.profilePic = profilePic
        owner.state = state
        owner.streetAddress = streetAddress
        owner.username = username
        owner.zipCode = zipCode
    }
    
    func promote(owner: Owner, adultBasicBelt: AdultBasicBelt, adultBlackBelt: AdultBlackBelt, mostRecentPromotion: Date, promotions: [String: Date]) {
        owner.adultBasicBelt = adultBasicBelt
        owner.blackBelt = adultBlackBelt
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


























