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
    convenience init(paymentProgramUUID: UUID = UUID(),
                     active: Bool = true,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     programName: String,
                     paymentDescription: String,
                     paymentAgreement: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.paymentProgramUUID = paymentProgramUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.programName = programName
        self.paymentDescription = paymentDescription
        self.paymentAgreement = paymentAgreement
    }
}
