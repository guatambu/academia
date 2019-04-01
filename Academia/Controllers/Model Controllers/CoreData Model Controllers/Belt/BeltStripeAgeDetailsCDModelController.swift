//
//  BeltStripeAgeDetailsCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class BeltStripeAgeDetailsCDModelController {
    
    // MARK: - Properties
    
    static let shared = BeltStripeAgeDetailsCDModelController()
    
    var addresses: [BeltStripeAgeDetailsCD] {
        let fetchRequest: NSFetchRequest<BeltStripeAgeDetailsCD> = BeltStripeAgeDetailsCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(beltStripeAgeDetails: BeltStripeAgeDetailsCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(beltStripeAgeDetails: BeltStripeAgeDetailsCD) {
        
        if let moc = beltStripeAgeDetails.managedObjectContext {
            
            moc.delete(beltStripeAgeDetails)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(beltStripeAgeDetails: BeltStripeAgeDetailsCD,
                beltRequiredTime: String?,
                minAgeRequirements: String?,
                iStripeRequiredTime: String?,
                iiStripeRequiredTime: String?,
                iiiStripeRequiredTime: String?,
                ivStripeRequiredTime: String?,
                vStripeRequiredTime: String?,
                viStripeRequiredTime: String?,
                viiStripeRequiredTime: String?,
                viiiStripeRequiredTime: String?,
                ixStripeRequiredTime: String?,
                xStripeRequiredTime: String?,
                xiStripeRequiredTime: String?) {
        
        beltStripeAgeDetails.dateEdited = Date()
        
        if let beltRequiredTime = beltRequiredTime {
            beltStripeAgeDetails.beltRequiredTime = beltRequiredTime
        }
        if let minAgeRequirements = minAgeRequirements {
            beltStripeAgeDetails.minAgeRequirements = minAgeRequirements
        }
        if let iStripeRequiredTime = iStripeRequiredTime {
            beltStripeAgeDetails.iStripeRequiredTime = iStripeRequiredTime
        }
        if let iiStripeRequiredTime = iiStripeRequiredTime {
            beltStripeAgeDetails.iiStripeRequiredTime = iiStripeRequiredTime
        }
        if let iiiStripeRequiredTime = iiiStripeRequiredTime {
            beltStripeAgeDetails.iiiStripeRequiredTime = iiiStripeRequiredTime
        }
        if let ivStripeRequiredTime = ivStripeRequiredTime {
            beltStripeAgeDetails.ivStripeRequiredTime = ivStripeRequiredTime
        }
        if let vStripeRequiredTime = vStripeRequiredTime {
            beltStripeAgeDetails.vStripeRequiredTime = vStripeRequiredTime
        }
        if let viStripeRequiredTime = viStripeRequiredTime {
            beltStripeAgeDetails.viStripeRequiredTime = viStripeRequiredTime
        }
        if let viiStripeRequiredTime = viiStripeRequiredTime {
            beltStripeAgeDetails.viiStripeRequiredTime = viiStripeRequiredTime
        }
        if let viiiStripeRequiredTime = viiiStripeRequiredTime {
            beltStripeAgeDetails.viiiStripeRequiredTime = viiiStripeRequiredTime
        }
        if let ixStripeRequiredTime = ixStripeRequiredTime {
            beltStripeAgeDetails.ixStripeRequiredTime = ixStripeRequiredTime
        }
        if let xStripeRequiredTime = xStripeRequiredTime {
            beltStripeAgeDetails.xStripeRequiredTime = xStripeRequiredTime
        }
        if let xiStripeRequiredTime = xiStripeRequiredTime {
            beltStripeAgeDetails.xiStripeRequiredTime = xiStripeRequiredTime
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
