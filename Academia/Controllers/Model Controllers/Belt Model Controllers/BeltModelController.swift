//
//  BeltModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 10/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class BeltModelController {
    
    static let shared = BeltModelController()
    
    var belts = [Belt]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(name: String,
                active: Bool,
                elligibleForNextBelt: Bool,
                classesToNextPromotion: Int,
                beltLevel: InternationalStandardBJJBelts,
                numberOfStripes: Int,
                beltTime: String,
                minAgeRequirement: String,
                iStripe: String?,
                iiStripe: String?,
                iiiStripe: String?,
                ivStripe: String?,
                vStripe: String?,
                viStripe: String?,
                viiStripe: String?,
                viiiStripe: String?,
                ixStripe: String?,
                xStripe: String?,
                xiStripe: String?) {
        
        let belt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: name, active: active, elligibleForNextBelt: elligibleForNextBelt, classesToNextPromotion: classesToNextPromotion, beltLevel: beltLevel, numberOfStripes: numberOfStripes, beltTime: beltTime, minAgeRequirement: minAgeRequirement, iStripe: iStripe, iiStripe: iiStripe, iiiStripe: iiiStripe, ivStripe: ivStripe, vStripe: vStripe, viStripe: viStripe, viiStripe: viiStripe, viiiStripe: viiiStripe, ixStripe: ixStripe, xStripe: xiStripe, xiStripe: xiStripe)
        
        belts.append(belt)
    }
    
    // Read
    
    
    // Update
    func update(belt: Belt, name: String, active: Bool, elligibleForNextBelt: Bool, classesToNextPromotion: Int, beltLevel: InternationalStandardBJJBelts, numberOfStripes: Int) {
        
        belt.dateEdited = Date()
        belt.name = name
        belt.active = active
        belt.elligibleForNextBelt = elligibleForNextBelt
        belt.classesToNextPromotion = classesToNextPromotion
        belt.beltLevel = beltLevel
        belt.numberOfStripes = numberOfStripes
        
    }
    
    
    // Delete
    func delete(belt: Belt) {
        guard let index = self.belts.index(of: belt) else { return }
        self.belts.remove(at: index)
    }
    
    
}














































