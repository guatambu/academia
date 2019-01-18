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
    var times: [String]?
    var locations: [Location]?
    var kidAttendees: [KidStudent]?
    var adultAttendees: [AdultStudent]?
    var instructor: [AdultStudent]?
    var ownerInstructor: [Owner]?
    var currentDate: Date
    var dateCreated: Date
    var dateEdited: Date
    
    // Memberwise Initializer
    init(aulaUID: UUID,
         active: Bool,
         aulaName: String,
         aulaDescription: String,
         daysOfTheWeek: [ClassTimeComponents.Weekdays],
         times: [String]?,
         locations: [Location]?,
         kidAttendees: [KidStudent]?,
         adultAttendees: [AdultStudent]?,
         instructor: [AdultStudent]?,
         ownerInstructor: [Owner]?,
         currentDate: Date,
         dateCreated: Date,
         dateEdited: Date
        ) {
        
        self.aulaUID = aulaUID
        self.active = active
        self.aulaName = aulaName
        self.aulaDescription = aulaDescription
        self.daysOfTheWeek = daysOfTheWeek
        self.times = times
        self.locations = locations
        self.kidAttendees = kidAttendees
        self.adultAttendees = adultAttendees
        self.instructor = instructor
        self.ownerInstructor = ownerInstructor
        self.currentDate = currentDate
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
    }
    
}

extension Aula: Equatable {
    
    static func ==(lhs: Aula, rhs: Aula) -> Bool {
        if lhs.aulaUID != rhs.aulaUID{ return false }
        if lhs.active != rhs.active { return false }
        if lhs.aulaName != rhs.aulaName { return false }
        if lhs.aulaDescription != rhs.aulaDescription { return false }
        if lhs.daysOfTheWeek != rhs.daysOfTheWeek { return false }
        if lhs.times != rhs.times { return false }
        if lhs.locations != rhs.locations { return false }
        if lhs.kidAttendees != rhs.kidAttendees { return false }
        if lhs.adultAttendees != rhs.adultAttendees { return false }
        if lhs.instructor != rhs.instructor { return false }
        if lhs.ownerInstructor != rhs.ownerInstructor { return false }
        if lhs.currentDate != rhs.currentDate { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        
        
        return true
    }
}










































