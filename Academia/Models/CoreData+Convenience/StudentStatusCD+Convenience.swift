//
//  StudentStatusCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension StudentStatusCD {
    
    // convenience initializer to allow creation of an StudentStatusCD object via Academia CoreDataStack's managedObjectContext
    convenience init(active: Bool,
                     medicalMembershipPaused: Bool,
                     membershipPaused: Bool,
                     paid: Bool,
                     adultStudent: AdultStudentCD,
                     kidStudent: KidStudentCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.active = active
        self.medicalMembershipPause = medicalMembershipPaused
        self.membershipPaused = membershipPaused
        self.paid = paid
        self.adultStudent = adultStudent
        self.kidStudent = kidStudent
    }
    
}

