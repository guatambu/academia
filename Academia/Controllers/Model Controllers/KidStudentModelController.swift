//
//  KidStudentModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class KidStudentModelController {
    
    static let shared = KidStudentModelController()
    
    var numberTasksCompleted: Int = 0
    
    var kidStudentOnboardingTasks: [OnBoardingTask] = [
        
        OnBoardingTask(onboardingTaskUID: "001", name: "welcome", title: "Welcome!", description: "This is your Home's Dashboard. Here you stay current with your academy.", isCompleted: true, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "002", name: "setUpPaymentPrograms", title: "Sign Up For Your Program", description: "Please choose the appropriate program according to your teacher.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "003", name: "messagingGroups", title: "News From The Source", description: "Please have your teacher add you to your academy's message group(s).", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "004", name: "viewClassSchedule", title: "View Upcoming Classes", description: "Here you can view the academy's full schedule.", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil),
        OnBoardingTask(onboardingTaskUID: "005", name: "learnTheBeltSystems", title: "Learn The Belt Systems", description: "Please take a moment to review yor school's Belt Systems", isCompleted: false, dateCompleted: nil, dateOfMostRecentChange: nil)
    ]
    
    var deletedKidStudentOnboardingTasks: [OnBoardingTask] = []
    
}
























