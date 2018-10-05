//
//  AdultStudentModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultStudentModelController {
    
    static let shared = AdultStudentModelController()
    
    var adults = [AdultStudent]()
    
    var numberTasksCompleted: Int = 0
    
    var adultStudentOnboardingTasks: [OnBoardingTask] = [
        
        OnBoardingTask(onboardingTaskUID: "001", name: "welcome", title: "Welcome!", description: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "002", name: "setUpPaymentPrograms", title: "Sign Up For Your Program", description: "Please choose the appropriate program according to your teacher.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "003", name: "messagingGroups", title: "News From The Source", description: "Please have your teacher add you to your academy's message group(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "004", name: "viewClassSchedule", title: "View Upcoming Classes", description: "Here you can view the academy's full schedule.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "005", name: "learnTheBeltSystems", title: "Learn The Belt Systems", description: "Please take a moment to review yor school's Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedAdultStudentOnboardingTasks: [OnBoardingTask] = []
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNewAdultStudent(birthdate: Date, adultBasicBelt: AdultBasicBelt?, adultBlackBelt: AdultBlackBelt?, profilePic: UIImage?, username: String, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, phone: String, mobile: String, email: String, emergencyContact: String, emergencyContactPhone: String, emergencyContactRelationship: String) {
        
        let adult = AdultStudent(adultStudentUID: "002", isInstructor: false, dateCreated: Date(), dateEdited: Date(), birthdate: birthdate, promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.inactive], groups: nil, paymentProgram: nil, permission: [UserPermissions.adultStudent], adultBasicBelt: adultBasicBelt, blackBelt: adultBlackBelt, profilePic: profilePic, username: username, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email, emergencyContact: emergencyContact, emergencyContactPhone: emergencyContactPhone, emergencyContactRelationship: emergencyContactRelationship)
        
        adults.append(adult)
    }
    
    // Read
    
    
    // Update
    
    
    // Delete
    func deleteAdultStudent(adultStudent: AdultStudent) {
        guard let index = self.adults.index(of: adultStudent) else { return }
        self.adults.remove(at: index)
    }
    
}


























