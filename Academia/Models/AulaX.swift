//
//  AulaX.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AulaX {
    
    // MARK: - Properties
    
    // UID
    let aulaUID: String
    
    var active: Bool
    var className: String
    var classDescription: String
    var daysOfTheWeek: [Weekdays]
    var timeOfDay: ClassTimes
    var location: LocationX?
    var students: [Any]?
    var instructor: [Any]?
    var currentDate: Date
    var dateCreated: Date
    var dateEdited: Date
    var attendees: [Any]?
    
    enum ClassTimes: Int {
        case one = 01
        case two = 02
        case three = 03
        case four = 04
        case five = 05
        case six = 06
        case seven = 07
        case eight = 08
        case nine = 09
        case ten = 10
        case eleven = 11
        case twelve = 12
        case thirteen = 13
        case fourteen = 14
        case fifteen = 15
        case sixteen = 16
        case seventeen = 17
        case eighteen = 18
        case nineteen = 19
        case twenty = 20
        case twentyone = 21
        case twentytwo = 22
        case twentythree = 23
        case twentyfour = 24
    }
    
    // Memberwise Initializer
    
    init(aulaUID: String,
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

extension AulaX: Equatable {
    
    static func ==(lhs: AulaX, rhs: AulaX) -> Bool {
        if lhs.active != rhs.active { return false }
        if lhs.aulaUID != rhs.aulaUID{ return false }
        if lhs.classDescription != rhs.classDescription { return false }
        if lhs.className != rhs.className { return false }
        if lhs.currentDate != rhs.currentDate { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.daysOfTheWeek != rhs.daysOfTheWeek { return false }
        if lhs.timeOfDay != rhs.timeOfDay { return false }
        
        return true
    }
}










































