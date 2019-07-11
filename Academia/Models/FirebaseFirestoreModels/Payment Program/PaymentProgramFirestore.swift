//
//  PaymentProgramFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol PaymentProgramFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct PaymentProgramFirestore {
    
    var paymentProgramUUID: String
    var active: Bool
    var dateCreated: Date
    var dateEdited: Date
    var programName: String
    var paymentDescription: String
    var paymentAgreement: String
    
    
    var dictionary: [String : Any] {
        return [
            "paymentProgramUUID" : paymentProgramUUID,
            "active" : active,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "programName" : programName,
            "paymentDescription" : paymentDescription
        ]
    }
    
    
    // initializer to allow creation of a PaymentProgramFirestore object
    init(paymentProgramUUID: String = "\(UUID())",
         active: Bool,
         dateCreated: Date = Date(),
         dateEdited: Date = Date(),
         programName: String,
         paymentDescription: String,
         paymentAgreement: String
        ) {
        
        self.paymentProgramUUID = paymentProgramUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.active = active
        self.programName = programName
        self.paymentDescription = paymentDescription
        self.paymentAgreement = paymentAgreement
    }
}


extension PaymentProgramFirestore: PaymentProgramFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let paymentProgramUUID = dictionary["paymentProgramUUID"] as? String else {
            
            print("ERROR: nil value found for paymentProgramUUID in firestore dictionary in TestModel.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in TestModel.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in TestModel.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in TestModel.swift -> init(dictionary:) - line 136.")
            return nil
        }
        
        guard let programName = dictionary["programName"] as? String else {
            
            print("ERROR: nil value found programName in firestore dictionary in TestModel.swift -> init(dictionary:) - line 160.")
            return nil
        }
        
        guard let paymentDescription = dictionary["paymentDescription"] as? String else {
            
            print("ERROR: nil value found for paymentDescription in firestore dictionary in TestModel.swift -> init(dictionary:) - line 106.")
            return nil
        }
        
        guard let paymentAgreement = dictionary["paymentAgreement"] as? String else {
            
            print("ERROR: nil value found for paymentAgreement in firestore dictionary in TestModel.swift -> init(dictionary:) - line 112.")
            return nil
        }
        
        self.init(paymentProgramUUID: paymentProgramUUID, active: active, dateCreated: dateCreated, dateEdited: dateEdited, programName: programName, paymentDescription: paymentDescription, paymentAgreement: paymentAgreement)
    }
}
