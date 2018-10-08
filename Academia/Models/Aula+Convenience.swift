//
//  Aula+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension Aula {
    
    convenience init(aulaUID: String,
                     active: Bool,
                     aulaName: String,
                     aulaDescription: String,
                     daysOfTheWeek: [Weekdays],
                     timeOfDay: ClassTimes,
                     location: LocationX?,
                     students: [Any]?,
                     instructor: [Any]?,
                     currentDate: Date,
                     dateCreated: Date,
                     dateEdited: Date,
                     attendees: [Any]?,
                     context: NSManagedObjectContext
        ) {
        
        self.init(context: context)
        
        self.aulaUID = aulaUID
        self.active = active
        self.aulaName = aulaName
        self.aulaDescription = aulaDescription
        self.daysOfTheWeek = daysOfTheWeek
        self.timeOfDay = timeOfDay
        self.location = location
        self.students = students
        self.instructor = instructor
        self.currentDate = currentDate
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.attendees = attendees
    }
    
}


//extension Aula: Equatable {
//    
//    static func ==(lhs: Aula, rhs: Aula) -> Bool {
//        if lhs.active != rhs.active { return false }
//        if lhs.aulaUID != rhs.aulaUID{ return false }
//        if lhs.classDescription != rhs.classDescription { return false }
//        if lhs.className != rhs.className { return false }
//        if lhs.currentDate != rhs.currentDate { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.daysOfTheWeek != rhs.daysOfTheWeek { return false }
//        if lhs.timeOfDay != rhs.timeOfDay { return false }
//        
//        return true
//    }
//}

