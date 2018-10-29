//
//  PaymentProgram+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension PaymentProgram {
    
    convenience init(paymentProgramUID: String, active: Bool, programName: String, dateCreated: Date, dateEdited: Date, billingType: [String], billingOptions: [String], paymentDescription: String, paymentAgreement: String, signatureType: [String], context: NSManagedObjectContext) {
        
        self.init(context: context)
        
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


//extension PaymentProgram: Equatable {
//    
//    static func ==(lhs: PaymentProgram, rhs: PaymentProgram) -> Bool {
//        if lhs.active != rhs.active { return false }
//        if lhs.billingType != rhs.billingType { return false }
//        if lhs.billingOptions != rhs.billingOptions { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.paymentAgreement != rhs.paymentAgreement { return false }
//        if lhs.paymentDescription != rhs.paymentDescription { return false }
//        if lhs.paymentProgramUID != rhs.paymentProgramUID { return false }
//        if lhs.programName != rhs.programName { return false }
//        if lhs.signatureType != rhs.signatureType { return false }
//        
//        
//        return true
//    }
//}

