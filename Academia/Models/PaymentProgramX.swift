//
//  PaymentProgramX.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgramX {
    
    // MARK: - Properties
    
    // UID
    let paymentProgramUID: String
    
    var active: Bool
    var programName: String
    var dateCreated: Date
    var dateEdited: Date
    var billingType: [String]
    var billingOptions: [String]
    var paymentDescription: String
    var paymentAgreement: String
    var signatureType: [String]
    
    // Memberwise Initializer
    
    init(paymentProgramUID: String, active: Bool, programName: String, dateCreated: Date, dateEdited: Date, billingType: [String], billingOptions: [String], paymentDescription: String, paymentAgreement: String, signatureType: [String]) {
        
        self.paymentProgramUID = paymentProgramUID
        self.active = active
        self.programName = programName
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.billingType = billingType
        self.billingOptions = billingOptions
        self.paymentDescription = paymentDescription
        self.paymentAgreement = paymentAgreement
        self.signatureType = signatureType
    }
    
}

extension PaymentProgramX: Equatable {
    
    static func ==(lhs: PaymentProgramX, rhs: PaymentProgramX) -> Bool {
        if lhs.active != rhs.active { return false }
        if lhs.billingType != rhs.billingType { return false }
        if lhs.billingOptions != rhs.billingOptions { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.paymentAgreement != rhs.paymentAgreement { return false }
        if lhs.paymentDescription != rhs.paymentDescription { return false }
        if lhs.paymentProgramUID != rhs.paymentProgramUID { return false }
        if lhs.programName != rhs.programName { return false }
        if lhs.signatureType != rhs.signatureType { return false }
        
        
        return true
    }
}







































