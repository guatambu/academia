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
    
    // MAAK: - Properties
    
    static let shared = BeltModelController()
    
    var belts = [Belt]()
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(classesToNextPromotion: Int,
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
        
        let belt = Belt(classesToNextPromotion: classesToNextPromotion, beltLevel: beltLevel, numberOfStripes: numberOfStripes, beltTime: beltTime, minAgeRequirement: minAgeRequirement, iStripe: iStripe, iiStripe: iiStripe, iiiStripe: iiiStripe, ivStripe: ivStripe, vStripe: vStripe, viStripe: viStripe, viiStripe: viiStripe, viiiStripe: viiiStripe, ixStripe: ixStripe, xStripe: xiStripe, xiStripe: xiStripe)
        
        belts.append(belt)
    }
    
    // Read
    
    
    // Update
    func update(belt: Belt, active: Bool?, elligibleForNextBelt: Bool?, classesToNextPromotion: Int?, beltLevel: InternationalStandardBJJBelts, numberOfStripes: Int) {
        
        belt.dateEdited = Date()
        
        if let active = active {
            belt.active = active
            
        } else if let elligibleForNextBelt = elligibleForNextBelt {
            belt.elligibleForNextBelt = elligibleForNextBelt
            
        } else if let classesToNextPromotion = classesToNextPromotion {
            belt.classesToNextPromotion = classesToNextPromotion
            
        }
        
        belt.beltLevel = beltLevel
        belt.numberOfStripes = numberOfStripes
            
        
    }
    
    
    // Delete
    func delete(belt: Belt) {
        guard let index = self.belts.index(of: belt) else { return }
        self.belts.remove(at: index)
    }
    
    
}














































