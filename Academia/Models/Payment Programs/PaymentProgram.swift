//
//  PaymentProgram.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgram {
    
    // MARK: - Properties
    
    // UID
    let paymentProgramUID: UUID
    
    var active: Bool
    var programName: String
    var dateCreated: Date
    var dateEdited: Date
    var billingTypes: [Billing.BillingType]
    var billingDates: [Billing.BillingDate]
    var signatureTypes: [Billing.BillingSignature]
    var paymentDescription: String
    var paymentAgreement: String
    
    // Memberwise Initializer
    
    init(paymentProgramUID: UUID, active: Bool, programName: String, dateCreated: Date, dateEdited: Date, billingTypes: [Billing.BillingType], billingDates: [Billing.BillingDate], signatureTypes: [Billing.BillingSignature], paymentDescription: String, paymentAgreement: String ) {
        
        self.paymentProgramUID = paymentProgramUID
        self.active = active
        self.programName = programName
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.billingTypes = billingTypes
        self.billingDates = billingDates
        self.signatureTypes = signatureTypes
        self.paymentDescription = paymentDescription
        self.paymentAgreement = paymentAgreement
    }
    
}

extension PaymentProgram: Equatable {
    
    static func ==(lhs: PaymentProgram, rhs: PaymentProgram) -> Bool {
        if lhs.paymentProgramUID != rhs.paymentProgramUID { return false }
        if lhs.active != rhs.active { return false }
        if lhs.programName != rhs.programName { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.billingTypes != rhs.billingTypes { return false }
        if lhs.billingDates != rhs.billingDates { return false }
        if lhs.signatureTypes != rhs.signatureTypes { return false }
        if lhs.paymentAgreement != rhs.paymentAgreement { return false }
        if lhs.paymentDescription != rhs.paymentDescription { return false }
        
        
        return true
    }
}







































