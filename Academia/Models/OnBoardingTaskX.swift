//
//  OnBoardingTaskX.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/21/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class OnBoardingTaskX {
    
    // MARK: - Properties
    
    // UID
    let onboardingTaskUID: String
    
    var name: String
    var title: String
    var descriptionDetail: String
    var isCompleted: Bool?
    var dateCompleted: Date?
    var dateOfMostRecentChange: Date?
    
    // MARK: - Memberwise Initializer
    
    init(onboardingTaskUID: String, name: String, title: String, descriptionDetail: String, isCompleted: Bool?, dateCompleted: Date?, dateOfMostRecentChange: Date?) {
        
        self.onboardingTaskUID = onboardingTaskUID
        self.name = name
        self.title = title
        self.descriptionDetail = descriptionDetail
        self.isCompleted = isCompleted
        self.dateCompleted = dateCompleted
        self.dateOfMostRecentChange = dateOfMostRecentChange
        
    }
}

extension OnBoardingTaskX: Equatable {
    
    static func ==(lhs: OnBoardingTaskX, rhs: OnBoardingTaskX) -> Bool {
        if lhs.dateCompleted != rhs.dateCompleted { return false }
        if lhs.dateOfMostRecentChange != rhs.dateOfMostRecentChange { return false }
        if lhs.descriptionDetail != rhs.descriptionDetail { return false }
        if lhs.isCompleted != rhs.isCompleted { return false }
        if lhs.name != rhs.name { return false }
        if lhs.onboardingTaskUID != rhs.onboardingTaskUID { return false }
        if lhs.title != rhs.title { return false }
        
        return true
    }
}


































