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
    
    var active: Bool
    var className: String
    var daysOfTheWeek: [Weekdays]
    var timeOfDay: [ClassTimes]
    var location: Location?
    var groups: [Group]?
    var students: [Any]?
    var instructor: [Any]?
    var currentDate: Date
    var dateCreated: Date
    var dateEdited: Date
    var attendees: [Any]?
    
    enum Weekdays {
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        case Sunday
    }
    
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
    
    init(active: Bool,
         className: String,
         daysOfTheWeek: [Weekdays],
         timeOfDay: [ClassTimes],
         location: Location?,
         groups: [Group]?,
         students: [Any]?,
         instructor: [Any]?,
         currentDate: Date,
         dateCreated: Date,
         dateEdited: Date,
         attendees: [Any]?
        ) {
        
        self.active = active
        self.className = className
        self.daysOfTheWeek = daysOfTheWeek
        self.timeOfDay = timeOfDay
        self.location = location
        self.groups = groups
        self.students = students
        self.instructor = instructor
        self.currentDate = currentDate
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.attendees = attendees
    }
    
}












































