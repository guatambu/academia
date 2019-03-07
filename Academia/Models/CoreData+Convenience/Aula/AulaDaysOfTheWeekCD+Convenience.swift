//
//  AulaDaysOfTheWeekCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension AulaDaysOfTheWeekCD {
    
    // convenience initializer to allow creation of a DaysOfTheWeekCD object via Academia CoreDataStack's managedObjectContext
    convenience init(sunday: String = ClassTimeComponents.Weekdays.Sunday.rawValue,
                     monday: String = ClassTimeComponents.Weekdays.Monday.rawValue,
                     tuesday: String = ClassTimeComponents.Weekdays.Tuesday.rawValue,
                     wednesday: String = ClassTimeComponents.Weekdays.Wednesday.rawValue,
                     thursday: String = ClassTimeComponents.Weekdays.Thursday.rawValue,
                     friday: String = ClassTimeComponents.Weekdays.Friday.rawValue,
                     saturday: String = ClassTimeComponents.Weekdays.Saturday.rawValue,
                     aula: AulaCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.sunday = sunday
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.aula = aula
    }
    
}
