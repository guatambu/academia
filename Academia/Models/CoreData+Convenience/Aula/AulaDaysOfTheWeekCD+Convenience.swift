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
    convenience init(day: String?,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.day = day
    }
    
}
