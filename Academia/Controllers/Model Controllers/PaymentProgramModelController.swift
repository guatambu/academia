//
//  PaymentProgramModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 10/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgramModelController {
    
    static let shared = PaymentProgramModelController()
    
    var paymentPrograms = [PaymentProgram]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNewPaymentProgram(profilePic: UIImage?, active: Bool, programName: String, billingType: [String], billingOptions: [String], paymentDescription: String, paymentAgreement: String, signatureType: [String]) {
        
        let paymentProgram = PaymentProgram(paymentProgramUID: "007", active: active, programName: programName, dateCreated: Date(), dateEdited: Date(), billingType: billingType, billingOptions: billingOptions, paymentDescription: paymentDescription, paymentAgreement: paymentAgreement, signatureType: signatureType)
        
        paymentPrograms.append(paymentProgram)
    }
    
    // Read
    
    
    // Update
    
    
    // Delete
    func deletePaymentProgram(paymentProgram: PaymentProgram) {
        guard let index = self.paymentPrograms.index(of: paymentProgram) else { return }
        self.paymentPrograms.remove(at: index)
    }
    
    
}
