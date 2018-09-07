//
//  OnBoardingTask.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/21/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class OnBoardingTask {
    
    // MARK: - Properties
    
    let name: String
    let title: String
    let description: String
    let isCompleted: Bool?
    let dateCompleted: Date?
    let dateOfMostRecentChange: Date?
    
    // MARK: - Memberwise Initializer
    
    init(name: String, title: String, description: String, isCompleted: Bool?, dateCompleted: Date?, dateOfMostRecentChange: Date?) {
        self.name = name
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.dateCompleted = dateCompleted
        self.dateOfMostRecentChange = dateOfMostRecentChange
        
    }
}




































