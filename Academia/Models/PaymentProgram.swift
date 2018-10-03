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

//var kidsProgram = PaymentProgram(active: true, programName: "Kids A", dateCreated: Date(), dateEdited: Date(), groups: [kidsParents], billingType: ["1st of month"], billingOptions: ["online with credit card"], paymentDescription: "long string", paymentAgreement: "legal agreement language", signatureType: ["digital signature"])
//
//var adultsProgram = PaymentProgram(active: true, programName: "Adults A", dateCreated: Date(), dateEdited: Date(), groups: [kidsParents], billingType: ["1st of month", "15th of month"], billingOptions: ["online with credit card"], paymentDescription: "long string", paymentAgreement: "legal agreement language", signatureType: ["digital signature"])







































