//
//  ClassTimeComponents.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/7/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

struct ClassTimeComponents {
    
    enum Weekdays: String {
        case Monday = "Monday"
        case Tuesday  = "Tuesday"
        case Wednesday = "Wednesday"
        case Thursday = "Thursday"
        case Friday = "Friday"
        case Saturday = "Saturday"
        case Sunday = "Sunday"
    }
    
    enum Hours24: Int {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
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
    
    enum HoursStandard: Int {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        case ten = 10
        case eleven = 11
        case twelve = 12
    }
    
    enum HourCodes: Int {
        case one = 100
        case two = 200
        case three = 300
        case four = 400
        case five = 500
        case six = 600
        case seven = 700
        case eight = 800
        case nine = 900
        case ten = 1000
        case eleven = 1100
        case twelve = 1200
    }
    
    enum MinuteCodes: Int {
        case zero = 1
        case five = 2
        case ten = 3
        case fifteen = 4
        case twenty = 5
        case twentyfive = 6
        case thirty = 7
        case thirtyfive = 8
        case forty = 9
        case fortyfive = 10
        case fifty = 11
        case fiftyfive = 12
    }
    
    enum MinuteStrings: String {
        case zero = "00"
        case five = "05"
        case ten = "10"
        case fifteen = "15"
        case twenty = "20"
        case twentyfive = "25"
        case thirty = "30"
        case thirtyfive = "35"
        case forty = "40"
        case fortyfive = "45"
        case fifty = "50"
        case fiftyfive = "55"
    }
    
    enum AMPM: String {
        case am = "AM"
        case pm = "PM"
    }
    
    enum AMPMCode: Int {
        case am = 0
        case pm = 10000    }
    
    let weekdaysArray: [Weekdays] = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday]
    
    let hours24Array: [Hours24] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve, .thirteen, .fourteen, .fifteen, .sixteen, .seventeen, .eighteen, .nineteen, .twenty, .twentyone, .twentytwo, .twentythree, .twentyfour]
    
    let hoursStandardArray: [HoursStandard] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve]
    
    let minuteStringsArray: [MinuteStrings] = [.zero, .five, .ten, .fifteen, .twenty, .twentyfive, .thirty, .thirtyfive, .forty, .fortyfive, .fifty, .fiftyfive]
    
    let amPmArray: [AMPM] = [.am,.pm]
}
