//
//  PaymentProgramModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 10/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class PaymentProgramModelController {
    
    static let shared = PaymentProgramModelController()
    
    var paymentPrograms = [PaymentProgram]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(active: Bool, programName: String, billingTypes: [Billing.BillingType], billingDates: [Billing.BillingDate], signatureTypes: [Billing.BillingSignature], paymentDescription: String, paymentAgreement: String) {
        
        let paymentProgram = PaymentProgram(paymentProgramUID: UUID(), active: active, programName: programName, dateCreated: Date(), dateEdited: Date(), billingTypes: billingTypes, billingDates: billingDates, signatureTypes: signatureTypes,  paymentDescription: paymentDescription, paymentAgreement: paymentAgreement)
        
        paymentPrograms.append(paymentProgram)
    }
    
    // Read
    
    
    // Update
    
    func update(paymentProgram:PaymentProgram,
                programName: String?,
                active: Bool?,
                paymentDescription: String?,
                billingTypes: [Billing.BillingType]?,
                billingDates: [Billing.BillingDate]?,
                signatureTypes: [Billing.BillingSignature]?,
                paymentAgreement: String?
        ) {
        
        paymentProgram.dateEdited = Date()
        
        if let active = active {
            paymentProgram.active = active
        }
        if let programName = programName {
            paymentProgram.programName = programName
        }
        if let paymentDescription = paymentDescription {
            paymentProgram.paymentDescription = paymentDescription
        }
        if let billingTypes = billingTypes {
            paymentProgram.billingTypes = billingTypes
        }
        if let billingDates = billingDates {
            paymentProgram.billingDates = billingDates
        }
        if let signatureTypes = signatureTypes {
            paymentProgram.signatureTypes = signatureTypes
        }
        if let paymentAgreement = paymentAgreement {
            paymentProgram.paymentAgreement = paymentAgreement
        }
    
    }
    
    
    // Delete
    func delete(paymentProgram: PaymentProgram) {
        guard let index = self.paymentPrograms.firstIndex(of: paymentProgram) else { return }
        self.paymentPrograms.remove(at: index)
    }
    
    
}
