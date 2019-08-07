//
//  PaymentProgramFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol PaymentProgramFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct PaymentProgramFirestore {
    
    var isActive: Bool
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var programName: String
    var paymentDescription: String
    var paymentAgreement: String
    
    
    var dictionary: [String : Any] {
        return [
            "isActive" : isActive,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "programName" : programName,
            "paymentDescription" : paymentDescription
        ]
    }
    
    
    // initializer to allow creation of a PaymentProgramFirestore object
    init(isActive: Bool,
         dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         programName: String,
         paymentDescription: String,
         paymentAgreement: String
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.isActive = isActive
        self.programName = programName
        self.paymentDescription = paymentDescription
        self.paymentAgreement = paymentAgreement
    }
}


extension PaymentProgramFirestore: PaymentProgramFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let isActive = dictionary["isActive"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in TestModel.swift -> init(dictionary:) - line 63.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in TestModel.swift -> init(dictionary:) - line 69.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in TestModel.swift -> init(dictionary:) - line 75.")
            return nil
        }
        
        guard let programName = dictionary["programName"] as? String else {
            
            print("ERROR: nil value found programName in firestore dictionary in TestModel.swift -> init(dictionary:) - line 81.")
            return nil
        }
        
        guard let paymentDescription = dictionary["paymentDescription"] as? String else {
            
            print("ERROR: nil value found for paymentDescription in firestore dictionary in TestModel.swift -> init(dictionary:) - line 87.")
            return nil
        }
        
        guard let paymentAgreement = dictionary["paymentAgreement"] as? String else {
            
            print("ERROR: nil value found for paymentAgreement in firestore dictionary in TestModel.swift -> init(dictionary:) - line 93.")
            return nil
        }
        
        self.init(isActive: isActive, dateCreated: dateCreated, dateEdited: dateEdited, programName: programName, paymentDescription: paymentDescription, paymentAgreement: paymentAgreement)
    }
}
