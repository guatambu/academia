//
//  PaymentBillingTypeFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol PaymentBillingTypeFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct PaymentBillingTypeFirestore {
    
    var billingType: String?
    var paymentProgram: PaymentProgramFirestore
    
    
    var dictionary: [String : Any] {
        return [
            "billingType" : billingType ?? "",
            "paymentProgram" : paymentProgram
        ]
    }
    
    
    // initializer to allow creation of a PaymentBillingDateFirestore object
    init(billingType: String?,
         paymentProgram: PaymentProgramFirestore
        ) {
        
        self.billingType = billingType
        self.paymentProgram = paymentProgram
    }
}


extension PaymentBillingTypeFirestore: PaymentBillingTypeFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let billingType = dictionary["billingType"] as? String else {
            
            print("ERROR: nil value found for billingDate in firestore dictionary in PaymentBillingTypeFirestore.swift -> init(dictionary:) - line 48.")
            return nil
        }
        
        guard let paymentProgram = dictionary["paymentProgram"] as? PaymentProgramFirestore else {
            
            print("ERROR: nil value found for paymentProgram in firestore dictionary in PaymentBillingTypeFirestore.swift -> init(dictionary:) - line 54.")
            return nil
        }
        
        self.init(billingType: billingType, paymentProgram: paymentProgram)
    }
}
