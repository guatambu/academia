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
                billingSignature: String?) {
        
        if let billingSignature = billingSignature {
            paymentBillingSignature.billingSignature = billingSignature
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
