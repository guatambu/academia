//
//  PaymentBillingTypeCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class PaymentBillingTypeCDModelController {
    
    // MARK: - Properties
    
    static let shared = PaymentBillingTypeCDModelController()
    
    var paymentBillingTypes: [PaymentBillingTypeCD] {
        let fetchRequest: NSFetchRequest<PaymentBillingTypeCD> = PaymentBillingTypeCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(paymentBillingType: PaymentBillingTypeCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(paymentBillingType: PaymentBillingTypeCD) {
        
        if let moc = paymentBillingType.managedObjectContext {
            
            moc.delete(paymentBillingType)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(paymentBillingType: PaymentBillingTypeCD,
                billingType: String?) {
        
        if let billingType = billingType {
            paymentBillingType.billingType = billingType
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
