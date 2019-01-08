//
//  Aula.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Aula {
    
    // MARK: - Properties
    
    // UID
    let aulaUID: UUID
    
    var active: Bool
    var aulaName: String
    var aulaDescription: String
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]
    var timeOfDay: String
    var location: Location?
    var students: [Any]?
    var instructor: [Any]?
    var currentDate: Date
    var dateCreated: Date
    var dateEdited: Date
    var attendees: [Any]?
    
    // Memberwise Initializer
    init(aulaUID: UUID,
         active: Bool,
         aulaName: String,
         aulaDescription: String,
         daysOfTheWeek: [ClassTimeComponents.Weekdays],
         timeOfDay: String,
         location: Location?,
         students: [Any]?,
         instructor: [Any]?,
         currentDate: Date,
         dateCreated: Date,
         dateEdited: Date,
         attendees: [Any]?
        ) {
        
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

extension Aula: Equatable {
    
    static func ==(lhs: Aula, rhs: Aula) -> Bool {
        if lhs.active != rhs.active { return false }
        if lhs.aulaUID != rhs.aulaUID{ return false }
        if lhs.aulaDescription != rhs.aulaDescription { return false }
        if lhs.aulaName != rhs.aulaName { return false }
        if lhs.currentDate != rhs.currentDate { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.daysOfTheWeek != rhs.daysOfTheWeek { return false }
        if lhs.timeOfDay != rhs.timeOfDay { return false }
        
        return true
    }
}










































