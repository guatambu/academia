//
//  PaymentProgramCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class PaymentProgramCDModelController {
    
    // MARK: - Properties
    
    static let shared = PaymentProgramCDModelController()
    
    var paymentPrograms: [PaymentProgramCD] {
        let fetchRequest: NSFetchRequest<PaymentProgramCD> = PaymentProgramCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(paymentProgram: PaymentProgramCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(paymentProgram: PaymentProgramCD) {
        
        if let moc = paymentProgram.managedObjectContext {
            
            moc.delete(paymentProgram)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(paymentProgramn: PaymentProgramCD,
                active: Bool?,
                programName: String?,
                paymentAgreement: String?,
                paymentDescription: String?) {
        
        paymentProgramn.dateEdited = Date()
        
        if let programName = programName {
            paymentProgramn.programName = programName
        }
        if let paymentAgreement = paymentAgreement {
            paymentProgramn.paymentAgreement = paymentAgreement
        }
        if let paymentDescription = paymentDescription {
            paymentProgramn.paymentDescription = paymentDescription
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
