//
//  PaymentBillingSignatureCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension PaymentBillingSignatureCD {
    
    // convenience initializer to allow creation of an BillingSignatureCD  object via Academia CoreDataStack's managedObjectContext
    convenience init(billingSignature: String?,
                     paymentProgram: PaymentProgramCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.billingSignature = billingSignature
        self.paymentProgram = paymentProgram
    }
    
    // convenience initializer to simply create and initialize the PaymentBillingSignatureCD object with its string value
    convenience init(billingSignature: String?,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.billingSignature = billingSignature
    }

}
