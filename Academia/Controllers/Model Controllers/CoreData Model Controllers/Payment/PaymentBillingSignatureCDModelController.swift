//
//  PaymentBillingSignatureCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class PaymentBillingSignatureCDModelController {
    
    // MARK: - Properties
    
    static let shared = PaymentBillingSignatureCDModelController()
    
    var paymentBillingSignatures: [PaymentBillingSignatureCD] {
        let fetchRequest: NSFetchRequest<PaymentBillingSignatureCD> = PaymentBillingSignatureCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(paymentBillingSignature: PaymentBillingSignatureCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(paymentBillingSignature: PaymentBillingSignatureCD) {
        
        if let moc = paymentBillingSignature.managedObjectContext {
            
            moc.delete(paymentBillingSignature)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(paymentBillingSignature: PaymentBillingSignatureCD,
                biometricEyeIris: Bool?,
                biometricFinger: Bool?,
                biometricFace: Bool?,
                biometricOther: Bool?,
                paperContract: Bool?,
                digitallyTyped: Bool?,
                digitalFingerSignature: Bool?) {
        
        if let biometricEyeIris = biometricEyeIris {
            paymentBillingSignature.biometricEyeIris = biometricEyeIris
        }
        if let biometricFinger = biometricFinger {
            paymentBillingSignature.biometricFinger = biometricFinger
        }
        if let biometricFace = biometricFace {
            paymentBillingSignature.biometricFace = biometricFace
        }
        if let biometricOther = biometricOther {
            paymentBillingSignature.biometricOther = biometricOther
        }
        if let paperContract = paperContract {
            paymentBillingSignature.paperContract = paperContract
        }
        if let digitallyTyped = digitallyTyped {
            paymentBillingSignature.digitallyTyped = digitallyTyped
        }
        if let digitalFingerSignature = digitalFingerSignature {
            paymentBillingSignature.digitalFingerSignature = digitalFingerSignature
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
