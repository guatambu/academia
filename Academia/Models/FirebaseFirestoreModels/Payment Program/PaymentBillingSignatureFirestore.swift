//
//  PaymentBillingSignatureFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol PaymentBillingSignatureFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct PaymentBillingSignatureFirestore {
    
    var billingSignature: String?
    var paymentProgram: PaymentProgramFirestore
    
    
    var dictionary: [String : Any] {
        return [
            "billingSignature" : billingSignature ?? "",
            "paymentProgram" : paymentProgram
        ]
    }
    
    
    // initializer to allow creation of a PaymentBillingDateFirestore object
    init(billingSignature: String?,
         paymentProgram: PaymentProgramFirestore
        ) {
        
        self.billingSignature = billingSignature
        self.paymentProgram = paymentProgram
    }
}


extension PaymentBillingSignatureFirestore: PaymentBillingSignatureFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let billingSignature = dictionary["billingSignature"] as? String else {
            
            print("ERROR: nil value found for billingSignature in firestore dictionary in PaymentBillingSignatureFirestore.swift -> init(dictionary:) - line 48.")
            return nil
        }
        
        guard let paymentProgram = dictionary["paymentProgram"] as? PaymentProgramFirestore else {
            
            print("ERROR: nil value found for paymentProgram in firestore dictionary in PaymentBillingSignatureFirestore.swift -> init(dictionary:) - line 54.")
            return nil
        }
        
        self.init(billingSignature: billingSignature, paymentProgram: paymentProgram)
    }
}
