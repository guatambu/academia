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
    var dateCreated: Date
    var dateEdited: Date
    var name: InternationalStandardBJJBelts
    var active: Bool
    var elligibleForNextBelt: Bool
    
    
    // belt constructors
    var kidStripes: Int?
    var adultStripes: Int?
    var blackBeltDegrees: Int?
    var coralBeltDegrees: Int?
    
    // Labels
//    var beltTime: String?
//    var firstStripeTime: String?
//    var secondStripeTime: String?
//    var thirdStripeTime: String?
//    var fourthStripeTime: String?
    
    
    // Memberwise Initializer
    
    init(beltUID: UUID,
         dateCreated: Date,
         dateEdited: Date,
         name: InternationalStandardBJJBelts,
         active: Bool,
         elligibleForNextBelt: Bool,
         kidStripes: Int?,
         adultStripes: Int?,
         blackBeltDegrees: Int?,
         coralBeltDegrees: Int?
        ) {
        
        self.beltUID = beltUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.kidStripes = kidStripes
        self.adultStripes = adultStripes
        self.blackBeltDegrees = blackBeltDegrees
        self.coralBeltDegrees = coralBeltDegrees
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
        if lhs.kidStripes != rhs.kidStripes { return false }
        if lhs.adultStripes != rhs.adultStripes { return false }
        if lhs.blackBeltDegrees != rhs.blackBeltDegrees { return false }
        if lhs.coralBeltDegrees != rhs.coralBeltDegrees { return false }
        
        return true
    }
}

