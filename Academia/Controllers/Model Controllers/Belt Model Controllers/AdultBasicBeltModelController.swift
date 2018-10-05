//
//  AdultBasicBeltModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 10/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultBasicBeltModelController {
    
    static let shared = AdultBasicBeltModelController()
    
    var adultBasicBelts = [AdultBasicBelt]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(name: String, active: Bool, elligibleForNextBelt: Bool, belt: UIColor, blackBar: UIColor, firstWhiteStripe: Bool, secondWhiteStripe: Bool, thirdWhiteStripe: Bool, fourthWhiteStripe: Bool, beltTime: String?, firstStripeTime: String?, secondStripeTime: String?, thirdStripeTime: String?, fourthStripeTime: String?) {
        
        let adultBasicBelt = AdultBasicBelt(adultBasicBeltUID: "003", dateCreated: Date(), dateEdited: Date(), name: name, active: active, elligibleForNextBelt: elligibleForNextBelt, belt: belt, blackBar: blackBar, firstWhiteStripe: firstWhiteStripe, secondWhiteStripe: secondWhiteStripe, thirdWhiteStripe: thirdWhiteStripe, fourthWhiteStripe: fourthWhiteStripe, beltTime: beltTime, firstStripeTime: firstStripeTime, secondStripeTime: secondStripeTime, thirdStripeTime: thirdStripeTime, fourthStripeTime: fourthStripeTime)
        
        adultBasicBelts.append(adultBasicBelt)
    }
    
    // Read
    
    
    // Update
    func update(adultBasicBelt: AdultBasicBelt, name: String, active: Bool, elligibleForNextBelt: Bool, belt: UIColor, blackBar: UIColor, firstWhiteStripe: Bool, secondWhiteStripe: Bool, thirdWhiteStripe: Bool, fourthWhiteStripe: Bool, beltTime: String?, firstStripeTime: String?, secondStripeTime: String?, thirdStripeTime: String?, fourthStripeTime: String?) {
        
        adultBasicBelt.dateEdited = Date()
        adultBasicBelt.name = name
        adultBasicBelt.active = active
        adultBasicBelt.elligibleForNextBelt = elligibleForNextBelt
        adultBasicBelt.belt = belt
        adultBasicBelt.blackBar = blackBar
        adultBasicBelt.beltTime = beltTime
        
        adultBasicBelt.firstStripeTime = firstStripeTime
        adultBasicBelt.secondStripeTime = secondStripeTime
        adultBasicBelt.thirdStripeTime = thirdStripeTime
        adultBasicBelt.fourthStripeTime = fourthStripeTime
        
        adultBasicBelt.firstWhiteStripe = firstWhiteStripe
        adultBasicBelt.secondWhiteStripe = secondWhiteStripe
        adultBasicBelt.thirdWhiteStripe = thirdWhiteStripe
        adultBasicBelt.fourthWhiteStripe = fourthWhiteStripe
    }
    
    
    // Delete
    func delete(adultBasicBelt: AdultBasicBelt) {
        guard let index = self.adultBasicBelts.index(of: adultBasicBelt) else { return }
        self.adultBasicBelts.remove(at: index)
    }
    
    
}














































