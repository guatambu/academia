//
//  PaymentProgramCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension PaymentProgramCD {
    
    // convenience initializer to allow creation of a PaymentProgramCD object via Academia CoreDataStack's managedObjectContext
    convenience init(paymentProgramUUID: UUID,
                     active: Bool,
                     dateCreated: Date,
                     dateEdited: Date,
                     programName: String,
                     paymentDescription: String,
                     paymentAgreement: String,
                     studentAdult: StudentAdultCD,
                     studentKid: StudentKidCD,
                     paymentBillingDate: NSOrderedSet,
                     paymentBillingSignature: NSOrderedSet,
                     paymentBillingType: NSOrderedSet,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.paymentProgramUUID = paymentProgramUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.programName = programName
        self.paymentDescription = paymentDescription
        self.paymentAgreement = paymentAgreement
        self.paymentBillingDate = paymentBillingDate
        self.paymentBillingSignature = paymentBillingSignature
        self.paymentBillingType = paymentBillingType
    }
    
}
