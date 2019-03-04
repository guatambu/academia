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
                firstOfTheMonth: Bool?,
                fifthOfTheMonth: Bool?,
                fifteenthOfTheMonth: Bool?,
                twentiethOfTheMonth: Bool?,
                registrationDay: Bool?,
                singleDay: Bool?) {
        
        if let firstOfTheMonth = firstOfTheMonth {
            paymentBillingDate.firstOfTheMonth = firstOfTheMonth
        }
        if let fifthOfTheMonth = fifthOfTheMonth {
            paymentBillingDate.fifthOfTheMonth = fifthOfTheMonth
        }
        if let fifteenthOfTheMonth = fifteenthOfTheMonth {
            paymentBillingDate.fifteenthOfTheMonth = fifteenthOfTheMonth
        }
        if let twentiethOfTheMonth = twentiethOfTheMonth {
            paymentBillingDate.twentiethOfTheMonth = twentiethOfTheMonth
        }
        if let registrationDay = registrationDay {
            paymentBillingDate.registrationDay = registrationDay
        }
        if let singleDay = singleDay {
            paymentBillingDate.singleDay = singleDay
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
