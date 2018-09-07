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
    
    init(dateCreated: Date,
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


let whiteBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 year", firstStripeTime: "3m", secondStripeTime: "3m", thirdStripeTime: "3m", fourthStripeTime: "3m")

let blueBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "Blue Belt", active: true, elligibleForNextBelt: true, belt: UIColor.blue, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "2 years", firstStripeTime: "4m", secondStripeTime: "6m", thirdStripeTime: "6m", fourthStripeTime: "4m")

let purpleBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "Purple Belt", active: true, elligibleForNextBelt: true, belt: UIColor.purple, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 1/2 years", firstStripeTime: "3m", secondStripeTime: "4m", thirdStripeTime: "4m", fourthStripeTime: "4m")

let brownBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "Brown Belt", active: true, elligibleForNextBelt: true, belt: UIColor.brown, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 1/2 years", firstStripeTime: "3m", secondStripeTime: "4m", thirdStripeTime: "4m", fourthStripeTime: "4m")

var adultBasicBelts = [whiteBelt, blueBelt, purpleBelt, brownBelt]






































