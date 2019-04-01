//
//  BeltStripeAgeDetailsCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/04/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

extension BeltStripeAgeDetailsCD {
    
    // convenience initializer to allow creation of a EmergencyContactCD object via Academia CoreDataStack's managedObjectContext
    convenience init(beltRequiredTime: String?,
                     minAgeRequirements: String?,
                     iStripeRequiredTime: String?,
                     iiStripeRequiredTime: String?,
                     iiiStripeRequiredTime: String?,
                     ivStripeRequiredTime: String?,
                     vStripeRequiredTime: String?,
                     viStripeRequiredTime: String?,
                     viiStripeRequiredTime: String?,
                     viiiStripeRequiredTime: String?,
                     ixStripeRequiredTime: String?,
                     xStripeRequiredTime: String?,
                     xiStripeRequiredTime: String?,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.beltRequiredTime = beltRequiredTime
        self.minAgeRequirements = minAgeRequirements
        self.iStripeRequiredTime = iStripeRequiredTime
        self.iiStripeRequiredTime = iiStripeRequiredTime
        self.iiiStripeRequiredTime = iiiStripeRequiredTime
        self.ivStripeRequiredTime = ivStripeRequiredTime
        self.vStripeRequiredTime = vStripeRequiredTime
        self.viStripeRequiredTime = viStripeRequiredTime
        self.viiStripeRequiredTime = viiStripeRequiredTime
        self.viiiStripeRequiredTime = viiiStripeRequiredTime
        self.ixStripeRequiredTime = ixStripeRequiredTime
        self.xStripeRequiredTime = xStripeRequiredTime
        self.xiStripeRequiredTime = xiStripeRequiredTime
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
    }
}



