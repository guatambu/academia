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
    convenience init(dropIn: Bool,
                     monthly: Bool,
                     sixMonths: Bool,
                     threeMonths: Bool,
                     twelveMonths: Bool,
                     paymentProgram: PaymentProgramCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.dropIn = dropIn
        self.monthly = monthly
        self.sixMonths = sixMonths
        self.threeMonths = threeMonths
        self.twelveMonths = twelveMonths
        self.paymentProgram = paymentProgram
    }
    
}
