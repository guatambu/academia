//
//  BeltPromotionCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class BeltPromotionCDModelController {
    
    // MARK: - Properties
    
    static let shared = BeltPromotionCDModelController()
    
    var addresses: [BeltPromotionCD] {
        let fetchRequest: NSFetchRequest<BeltPromotionCD> = BeltPromotionCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(beltPromotion: BeltPromotionCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(beltPromotion: BeltPromotionCD) {
        
        if let moc = beltPromotion.managedObjectContext {
            
            moc.delete(beltPromotion)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(beltPromotion: BeltPromotionCD,
                numberOfStripes: Int16?,
                dateOfPromotion: Date?,
                beltLevel: String?) {
        
        if let numberOfStripes = numberOfStripes {
            beltPromotion.numberOfStripes = numberOfStripes
        }
        if let dateOfPromotion = dateOfPromotion {
            beltPromotion.dateOfPromotion = dateOfPromotion
        }
        if let beltLevel = beltLevel {
            beltPromotion.beltLevel = beltLevel
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
