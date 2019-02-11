//
//  AttendanceCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension AttendanceCD {
    
    // convenience initializer to allow creation of a AttendanceCD object via Academia CoreDataStack's managedObjectContext
    convenience init(currentDate: Date?,
                     adultStudentAttendance: AdultStudentCD?,
                     kidStudentAttendance: KidStudentCD?,
                     ownerAttendance: OwnerCD?,
                     aula: AulaCD?,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.currentDate = currentDate
        self.adultStudentAttendance = adultStudentAttendance
        self.kidStudentAttendance = kidStudentAttendance
        self.ownerAttendance = ownerAttendance
        self.aula = aula
    }
    
}