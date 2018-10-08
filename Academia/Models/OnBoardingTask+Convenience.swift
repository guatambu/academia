//
//  OnBoardingTask+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

extension OnBoardingTask {
    
    convenience init(onboardingTaskUID: String, name: String, title: String, descriptionDetail: String, isComplete: Bool?, dateComplete: Date?, dateEdited: Date?, context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.onboardingTaskUID = onboardingTaskUID
        self.name = name
        self.title = title
        self.descriptionDetail = descriptionDetail
        self.isComplete = isComplete
        self.dateComplete = dateComplete
        self.dateEdited = dateEdited
        
    }
    
}

//extension OnBoardingTask: Equatable {
//    
//    static func ==(lhs: OnBoardingTask, rhs: OnBoardingTask) -> Bool {
//        if lhs.dateComplete != rhs.dateComplete { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.descriptionDetail != rhs.descriptionDetail { return false }
//        if lhs.isComplete != rhs.isComplete { return false }
//        if lhs.name != rhs.name { return false }
//        if lhs.onboardingTaskUID != rhs.onboardingTaskUID { return false }
//        if lhs.title != rhs.title { return false }
//        
//        return true
//    }
//}

