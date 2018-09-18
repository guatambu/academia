//
//  AdultStudentModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class AdultStudentModelController {
    
    static let shared = AdultStudentModelController()
    
    var numberTasksCompleted: Int = 0
    
    var adultStudentOnboardingTasks: [OnBoardingTask] = [
        
        OnBoardingTask(name: "welcome", title: "Welcome!", description: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(name: "startGettingPaid", title: "Start getting paid", description: "Set up your account to receive your payments.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(name: "setUpPaymentPrograms", title: "$0.00 in sales", description: "Please set the Payment Program(s) for your school.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(name: "locationsSetUp", title: "No Locations", description: "Please add your School Location(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(name: "messagingGroups", title: "0 Messaging Groups", description: "Please create Messaging Group(s) for your academy.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(name: "createClassSchedule", title: "No Classes Scheduled", description: "Please set up Your School's complete Class Schedule", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(name: "reviewBeltSystems", title: "Review Belt Systems", description: "Please Take a moment to review the included Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedAdultStudentOnboardingTasks: [OnBoardingTask] = []
    
}


























