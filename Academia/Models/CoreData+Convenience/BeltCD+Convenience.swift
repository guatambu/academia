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
    convenience init(beltUUID: UUID,
                     active: Bool,
                     elligibleForNextBelt: Bool,
                     dateCreated: Date,
                     dateEdited: Date,
                     beltLevel: String,
                     beltTime: String,
                     minAgeRequirement: String,
                     iStripeTime: String,
                     iiStripeTime: String,
                     iiiStripeTime: String,
                     ivStripeTime: String,
                     vStripeTime: String,
                     viStripeTime: String,
                     viiStripeTime: String,
                     viiiStripeTime: String,
                     ixStripeTime: String,
                     xStripeTime: String,
                     xiStripeTime: String,
                     classesToNextPromotion: Int16,
                     numberOfStripes: Int16,
                     adultStudentCD: AdultStudentCD,
                     kidStudentCD: KidStudentCD,
                     ownerCD: OwnerCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.beltUUID = beltUUID
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.beltLevel = beltLevel
        self.beltTime = beltTime
        self.minAgeRequirement = minAgeRequirement
        self.iStripeTime = iStripeTime
        self.iiStripeTime = iiStripeTime
        self.iiiStripeTime = iiiStripeTime
        self.ivStripeTime = ivStripeTime
        self.vStripeTime = vStripeTime
        self.viStripeTime = viStripeTime
        self.viiStripeTime = viiStripeTime
        self.viiiStripeTime = viiiStripeTime
        self.ixStripeTime = ixStripeTime
        self.xStripeTime = xStripeTime
        self.xiStripeTime = xiStripeTime
        self.classesToNextPromotion = classesToNextPromotion
        self.adultStudentCD = adultStudentCD
        self.kidStudentCD = kidStudentCD
        self.ownerCD = ownerCD
    }
    
}
