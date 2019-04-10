//
//  BeltCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension BeltCD {
    
    // convenience initializer to allow creation of a BeltCD object via Academia CoreDataStack's managedObjectContext
    convenience init(beltUUID: UUID = UUID(),
                     active: Bool = true,
                     elligibleForNextBelt: Bool = false,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     beltLevel: String,
                     beltPromotionAttendanceCriteria: BeltPromotionAttendanceCriteriaCD?,
                     beltStripeAgeDetails: BeltStripeAgeDetailsCD?,
                     classesToNextPromotion: Int16?,
                     numberOfStripes: Int16,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.beltUUID = beltUUID
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.beltLevel = beltLevel
        self.beltPromotionAttendanceCriteria = beltPromotionAttendanceCriteria
        self.beltStripeAgeDetails = beltStripeAgeDetails
        self.numberOfStripes = numberOfStripes
    }
    
}
