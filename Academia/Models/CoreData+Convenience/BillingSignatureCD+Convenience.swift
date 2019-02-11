//
//  BillingSignatureCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension BillingSignatureCD {
    
    // convenience initializer to allow creation of an BillingSignatureCD  object via Academia CoreDataStack's managedObjectContext
    convenience init(biometricEyeIris: Bool,
                     biometricFace: Bool,
                     biometricFinger: Bool,
                     digitalFingerSignature: Bool,
                     digitallyTyped: Bool,
                     otherBiometric: Bool,
                     paperContract: Bool,
                     paymentProgram: PaymentProgramCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.biometricEyeIris = biometricEyeIris
        self.biometricFace = biometricFace
        self.biometricFinger = biometricFinger
        self.digitalFingerSignature = digitalFingerSignature
        self.digitallyTyped = digitallyTyped
        self.otherBiometric = otherBiometric
        self.paperContract = paperContract
        self.paymentProgram = paymentProgram
    }
    
}
