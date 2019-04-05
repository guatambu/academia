//
//  OnBoardingTaskModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 10/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class OnBoardingTaskModelController {
    
    static let shared = OnBoardingTaskModelController()
    
    var ownerOnBoardingTasks = [OnBoardingTask]()
    var kidStudentOnBoardingTasks = [OnBoardingTask]()
    var adultStudentOnBoardingTasks = [OnBoardingTask]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNewOwnerTask(name: String, title: String, description: String, isCompleted: Bool?) {
        
        let ownerOnBoardingTask = OnBoardingTask(onboardingTaskUID: UUID(), name: name, title: title, descriptionDetail: description, isCompleted: isCompleted, dateCompleted: nil, dateOfMostRecentChange: Date())
        
        ownerOnBoardingTasks.append(ownerOnBoardingTask)
    }
    
    func addNewAdultStudentTask(name: String, title: String, description: String, isCompleted: Bool?) {
        
        let adultStudentOnBoardingTask = OnBoardingTask(onboardingTaskUID: UUID(), name: name, title: title, descriptionDetail: description, isCompleted: isCompleted, dateCompleted: nil, dateOfMostRecentChange: Date())
        
        adultStudentOnBoardingTasks.append(adultStudentOnBoardingTask)
    }
    
    func addNewKidStudentTask(name: String, title: String, description: String, isCompleted: Bool?) {
        
        let kidStudentOnBoardingTask = OnBoardingTask(onboardingTaskUID: UUID(), name: name, title: title, descriptionDetail: description, isCompleted: isCompleted, dateCompleted: nil, dateOfMostRecentChange: Date())
        
        kidStudentOnBoardingTasks.append(kidStudentOnBoardingTask)
    }
    
    // Read
    
    
    // Update
    func update(task: OnBoardingTask, name: String, title: String, descriptionDetail: String, isCompleted: Bool?) {
        
        task.descriptionDetail = descriptionDetail
        task.isCompleted = isCompleted
        task.name = name
        task.title = title
        task.dateOfMostRecentChange = Date()
        
        guard let isTaskComplete = task.isCompleted else { return }
        if isTaskComplete {
            task.dateCompleted = Date()
        }
    }
    
    
    // Delete
    func deleteOwnerTask(ownerTask: OnBoardingTask) {
        guard let index = self.ownerOnBoardingTasks.index(of: ownerTask) else { return }
        self.ownerOnBoardingTasks.remove(at: index)
    }
    
    func deleteAdultStudentTask(adultStudentTask: OnBoardingTask) {
        guard let index = self.adultStudentOnBoardingTasks.index(of: adultStudentTask) else { return }
        self.adultStudentOnBoardingTasks.remove(at: index)
    }
    
    func deleteKidStudentTask(kidStudentTask: OnBoardingTask) {
        guard let index = self.kidStudentOnBoardingTasks.index(of: kidStudentTask) else { return }
        self.kidStudentOnBoardingTasks.remove(at: index)
    }
    
    
}










