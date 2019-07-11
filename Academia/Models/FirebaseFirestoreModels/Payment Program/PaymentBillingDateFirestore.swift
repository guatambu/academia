//
//  PaymentBillingDateFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol PaymentBillingDateFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct PaymentBillingDateFirestore {
    
    var billingDate: String?
    var paymentProgram: PaymentProgramFirestore
    
    
    var dictionary: [String : Any] {
        return [
            "billingDate" : billingDate ?? "",
            "paymentProgram" : paymentProgram
        ]
    }
    
    
    // initializer to allow creation of a PaymentBillingDateFirestore object
    init(billingDate: String?,
         paymentProgram: PaymentProgramFirestore
        ) {
        
        self.billingDate = billingDate
        self.paymentProgram = paymentProgram
    }
}


extension PaymentBillingDateFirestore: PaymentBillingDateFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let billingDate = dictionary["billingDate"] as? String else {
            
            print("ERROR: nil value found for billingDate in firestore dictionary in PaymentBillingDateFirestore.swift -> init(dictionary:) - line 48.")
            return nil
        }
        
        guard let paymentProgram = dictionary["paymentProgram"] as? PaymentProgramFirestore else {
            
            print("ERROR: nil value found for paymentProgram in firestore dictionary in PaymentBillingDateFirestore.swift -> init(dictionary:) - line 54.")
            return nil
        }
        
        self.init(billingDate: billingDate, paymentProgram: paymentProgram)
    }
}
