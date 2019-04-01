//
//  PaymentBillingDateCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class PaymentBillingDateCDModelController {
    
    // MARK: - Properties
    
    static let shared = PaymentBillingDateCDModelController()
    
    var paymentBillingDates: [PaymentBillingDateCD] {
        let fetchRequest: NSFetchRequest<PaymentBillingDateCD> = PaymentBillingDateCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(paymentBillingDate: PaymentBillingDateCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(paymentBillingDate: PaymentBillingDateCD) {
        
        if let moc = paymentBillingDate.managedObjectContext {
            
            moc.delete(paymentBillingDate)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(paymentBillingDate: PaymentBillingDateCD,
                billingDate: String?) {
        
        if let billingDate = billingDate {
            paymentBillingDate.billingDate = billingDate
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
