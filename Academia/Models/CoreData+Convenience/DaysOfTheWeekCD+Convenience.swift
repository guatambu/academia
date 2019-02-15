//
//  DaysOfTheWeekCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension DaysOfTheWeekCD {
    
    // convenience initializer to allow creation of a DaysOfTheWeekCD object via Academia CoreDataStack's managedObjectContext
    convenience init(sunday: String,
                     monday: String,
                     tuesday: String,
                     wednesday: String,
                     thursday: String,
                     friday: String,
                     saturday: String,
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
