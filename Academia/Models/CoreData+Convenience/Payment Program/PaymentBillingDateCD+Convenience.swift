//
//  PaymentBillingDateCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension PaymentBillingDateCD {
    
    // convenience initializer to allow creation of an BillingDateCD object via Academia CoreDataStack's managedObjectContext
    convenience init(fifteenthOfTheMonth: Bool,
                     fifthOfTheMonth: Bool,
                     firstOfTheMonth: Bool,
                     registrationDay: Bool,
                     singleDay: Bool,
                     twentiethOfTheMonth: Bool,
                     paymentProgram: PaymentProgramCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.fifteenthOfTheMonth = fifteenthOfTheMonth
        self.fifthOfTheMonth = fifthOfTheMonth
        self.firstOfTheMonth = firstOfTheMonth
        self.registrationDay = registrationDay
        self.singleDay = singleDay
        self.twentiethOfTheMonth = twentiethOfTheMonth
        self.paymentProgram = paymentProgram
    }
}
