//
//  AdultBasicBelt.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultBasicBelt {
    
    // MARK: - Properties
    
    // UID
    let adultBasicBeltUID: String
    
    var dateCreated: Date
    var dateEdited: Date
    var name: String
    var active: Bool
    var elligibleForNextBelt: Bool

    
    // belt constructors
    var belt: UIColor
    var blackBar: UIColor
    var firstWhiteStripe: Bool
    var secondWhiteStripe: Bool
    var thirdWhiteStripe: Bool
    var fourthWhiteStripe: Bool
    
    // Labels
    var beltTime: String?
    var firstStripeTime: String?
    var secondStripeTime: String?
    var thirdStripeTime: String?
    var fourthStripeTime: String?
    
    
    // Memberwise Initializer
    
    init(adultBasicBeltUID: String,
         dateCreated: Date,
         dateEdited: Date,
         name: String,
         active: Bool,
         elligibleForNextBelt: Bool,
         belt: UIColor,
         blackBar: UIColor,
         firstWhiteStripe: Bool,
         secondWhiteStripe: Bool,
         thirdWhiteStripe: Bool,
         fourthWhiteStripe: Bool,
         beltTime: String?,
         firstStripeTime: String?,
         secondStripeTime: String?,
         thirdStripeTime: String?,
         fourthStripeTime: String?
         ) {
        
        self.adultBasicBeltUID = adultBasicBeltUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.belt = belt
        self.blackBar = blackBar
        self.firstWhiteStripe = firstWhiteStripe
        self.secondWhiteStripe = secondWhiteStripe
        self.thirdWhiteStripe = thirdWhiteStripe
        self.fourthWhiteStripe = fourthWhiteStripe
        self.beltTime = beltTime
        self.firstStripeTime = firstStripeTime
        self.secondStripeTime = secondStripeTime
        self.thirdStripeTime = thirdStripeTime
        self.fourthStripeTime = fourthStripeTime
        
    }
}








































