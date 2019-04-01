//
//  PaymentBillingTypeCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension PaymentBillingTypeCD {
    
    // convenience initializer to allow creation of an BillingTypeCD object via Academia CoreDataStack's managedObjectContext
    convenience init(billingType: String?,
                     paymentProgram: PaymentProgramCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.billingType = billingType
        self.paymentProgram = paymentProgram
    }
    
    // convenience initializer to simply create and initialize the PaymentBillingTypeCD object with its string value
    convenience init(billingType: String?,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.billingType = billingType
    }
    
}
