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
    var active: Bool
    var elligibleForNextBelt: Bool
    var classesToNextPromotion: Int
    var beltLevel: InternationalStandardBJJBelts
    // belt constructors
    var numberOfStripes: Int
    // belt promotion specifications
    var beltTime: String?
    var minAgeRequirement: String?
    var iStripe: String?
    var iiStripe: String?
    var iiiStripe: String?
    var ivStripe: String?
    var vStripe: String?
    var viStripe: String?
    var viiStripe: String?
    var viiiStripe: String?
    var ixStripe: String?
    var xStripe: String?
    var xiStripe: String?
    

    
    // MARK: - Initialization
    
    // Memberwise Initializer
    init(beltUID: UUID = UUID(),
         dateCreated: Date = Date(),
         dateEdited: Date = Date(),
         classesToNextPromotion: Int,
         beltLevel: InternationalStandardBJJBelts,
         numberOfStripes: Int,
         beltTime: String?,
         minAgeRequirement: String?,
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
         xiStripe: String?
        ) {
        
        self.beltUID = beltUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.active = true
        self.elligibleForNextBelt = false
        self.classesToNextPromotion = classesToNextPromotion
        self.beltLevel = beltLevel
        self.numberOfStripes = numberOfStripes
        self.beltTime = beltTime
        self.minAgeRequirement = minAgeRequirement
        self.iStripe = iStripe
        self.iiStripe = iiStripe
        self.iiiStripe = iiiStripe
        self.ivStripe = ivStripe
        self.vStripe = vStripe
        self.viStripe = viStripe
        self.viiStripe = viiStripe
        self.viiiStripe = viiiStripe
        self.ixStripe = ixStripe
        self.xStripe = xStripe
        self.xiStripe = xiStripe
    }
    
    // convenience initializer
    convenience init(classesToNextPromotion: Int,
                     beltLevel: InternationalStandardBJJBelts,
                     numberOfStripes: Int) {
        
        self.init(classesToNextPromotion: classesToNextPromotion,
                  beltLevel: beltLevel,
                  numberOfStripes: numberOfStripes,
                  beltTime: nil,
                  minAgeRequirement: nil,
                  iStripe: nil,
                  iiStripe: nil,
                  iiiStripe: nil,
                  ivStripe: nil,
                  vStripe: nil,
                  viStripe: nil,
                  viiStripe: nil,
                  viiiStripe: nil,
                  ixStripe: nil,
                  xStripe: nil,
                  xiStripe: nil)
    }
}

extension Belt: Equatable {
    
    static func ==(lhs: Belt, rhs: Belt) -> Bool {
        if lhs.beltUID != rhs.beltUID { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.active != rhs.active { return false }
        if lhs.elligibleForNextBelt != rhs.elligibleForNextBelt { return false }
        if lhs.classesToNextPromotion != rhs.classesToNextPromotion { return false }
        if lhs.beltLevel != rhs.beltLevel { return false }
        if lhs.numberOfStripes != rhs.numberOfStripes { return false }
        if lhs.beltTime != rhs.beltTime { return false }
        if lhs.minAgeRequirement != rhs.minAgeRequirement { return false }
        if lhs.iStripe != rhs.iStripe { return false }
        if lhs.iiStripe != rhs.iiStripe { return false }
        if lhs.iiiStripe != rhs.iiiStripe { return false }
        if lhs.ivStripe != rhs.ivStripe { return false }
        if lhs.vStripe != rhs.vStripe { return false }
        if lhs.viStripe != rhs.viStripe { return false }
        if lhs.viiStripe != rhs.viiStripe { return false }
        if lhs.viiiStripe != rhs.viiiStripe { return false }
        if lhs.ixStripe != rhs.ixStripe { return false }
        if lhs.xStripe != rhs.xStripe { return false }
        if lhs.xiStripe != rhs.xiStripe { return false }
        
        return true
    }
}

