//
//  Belt.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/8/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Belt {
    
    // MARK: - Properties
    
    // UID
    let beltUID: UUID
    
    // general properties
    var dateCreated: Date
    var dateEdited: Date
    var name: String
    var active: Bool
    var elligibleForNextBelt: Bool
    var numberOfClassesToNextPromotion: Int
    var beltLevel: InternationalStandardBJJBelts
    
    // belt constructors
    var numberOfStripes: Int

    
    // MARK: - Initialization
    
    // Memberwise Initializer
    init(beltUID: UUID,
         dateCreated: Date,
         dateEdited: Date,
         name: String,
         active: Bool,
         elligibleForNextBelt: Bool,
         numberOfClassesToNextPromotion: Int,
         beltLevel: InternationalStandardBJJBelts,
         numberOfStripes: Int
        ) {
        
        self.beltUID = beltUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.numberOfClassesToNextPromotion = numberOfClassesToNextPromotion
        self.beltLevel = beltLevel
        self.numberOfStripes = numberOfStripes
    }
}

extension Belt: Equatable {
    
    static func ==(lhs: Belt, rhs: Belt) -> Bool {
        if lhs.beltUID != rhs.beltUID { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.name != rhs.name { return false }
        if lhs.active != rhs.active { return false }
        if lhs.elligibleForNextBelt != rhs.elligibleForNextBelt { return false }
        if lhs.numberOfStripes != rhs.numberOfStripes { return false }
        
        return true
    }
}

