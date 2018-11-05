//
//  KidsBeltModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 10/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class KidsBeltModelController {
    
    static let shared = KidsBeltModelController()
    
    var kidsBelts = [KidsBelt]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(name: String, active: Bool, elligibleForNextBelt: Bool, belt: UIColor, beltCenterRibbonView: UIColor?, blackBar: UIColor, firstWhiteStripe: Bool, secondWhiteStripe: Bool, thirdWhiteStripe: Bool, fourthWhiteStripe: Bool, firstRedStripe: Bool, secondRedStripe: Bool, thirdRedStripe: Bool, fourthRedStripe: Bool, firstBlackStripe: Bool, secondBlackStripe: Bool, thirdBlackStripe: Bool, beltTimeLabel: String?, labelFirstWhiteStripe: String?, labelSecondWhiteStripe: String?, labelThirdWhiteStripe: String?, labelFourthWhiteStripe: String?, labelFirstRedStripe: String?, labelSecondRedStripe: String?, labelThirdRedStripe: String?, labelFourthRedStripe: String?, labelFirstBlackStripe: String?, labelSecondBlackStripe: String?, labelThirdBlackStripe: String?) {
        
        let kidsBelt = KidsBelt(kidsBeltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: name, active: active, elligibleForNextBelt: elligibleForNextBelt, belt: belt, beltCenterRibbonView: beltCenterRibbonView, blackBar: blackBar, firstWhiteStripe: firstWhiteStripe, secondWhiteStripe: secondWhiteStripe, thirdWhiteStripe: thirdWhiteStripe, fourthWhiteStripe: fourthWhiteStripe, firstRedStripe: firstRedStripe, secondRedStripe: secondRedStripe, thirdRedStripe: thirdRedStripe, fourthRedStripe: fourthRedStripe, firstBlackStripe: firstBlackStripe, secondBlackStripe: secondBlackStripe, thirdBlackStripe: thirdBlackStripe, beltTimeLabel: beltTimeLabel, labelFirstWhiteStripe: labelFirstWhiteStripe, labelSecondWhiteStripe: labelSecondWhiteStripe, labelThirdWhiteStripe: labelThirdWhiteStripe, labelFourthWhiteStripe: labelFourthWhiteStripe, labelFirstRedStripe: labelFirstRedStripe, labelSecondRedStripe: labelSecondRedStripe, labelThirdRedStripe: labelThirdRedStripe, labelFourthRedStripe: labelFourthRedStripe, labelFirstBlackStripe: labelFirstBlackStripe, labelSecondBlackStripe: labelSecondBlackStripe, labelThirdBlackStripe: labelThirdBlackStripe)
        
        kidsBelts.append(kidsBelt)
    }
    
    // Read
    
    
    // Update
    func update(kidsBelt: KidsBelt, name: String, active: Bool, elligibleForNextBelt: Bool, belt: UIColor, beltCenterRibbonView: UIColor?, blackBar: UIColor, firstWhiteStripe: Bool, secondWhiteStripe: Bool, thirdWhiteStripe: Bool, fourthWhiteStripe: Bool, firstRedStripe: Bool, secondRedStripe: Bool, thirdRedStripe: Bool, fourthRedStripe: Bool, firstBlackStripe: Bool, secondBlackStripe: Bool, thirdBlackStripe: Bool, beltTimeLabel: String?, labelFirstWhiteStripe: String?, labelSecondWhiteStripe: String?, labelThirdWhiteStripe: String?, labelFourthWhiteStripe: String?, labelFirstRedStripe: String?, labelSecondRedStripe: String?, labelThirdRedStripe: String?, labelFourthRedStripe: String?, labelFirstBlackStripe: String?, labelSecondBlackStripe: String?, labelThirdBlackStripe: String?) {
        
        kidsBelt.active = active
        kidsBelt.name = name
        kidsBelt.dateEdited = Date()
        kidsBelt.elligibleForNextBelt = elligibleForNextBelt
        kidsBelt.belt = belt
        kidsBelt.beltCenterRibbonView = beltCenterRibbonView
        kidsBelt.beltTimeLabel = beltTimeLabel
        kidsBelt.blackBar = blackBar
        kidsBelt.name = name
        
        kidsBelt.labelFirstBlackStripe = labelFirstBlackStripe
        kidsBelt.labelFirstRedStripe = labelFirstRedStripe
        kidsBelt.labelThirdWhiteStripe = labelFirstWhiteStripe
        kidsBelt.labelFourthRedStripe = labelFourthRedStripe
        kidsBelt.labelFourthWhiteStripe = labelFourthWhiteStripe
        kidsBelt.labelSecondBlackStripe = labelSecondBlackStripe
        kidsBelt.labelSecondRedStripe = labelSecondRedStripe
        kidsBelt.labelSecondWhiteStripe = labelSecondWhiteStripe
        kidsBelt.labelThirdBlackStripe = labelThirdBlackStripe
        kidsBelt.labelThirdRedStripe = labelThirdRedStripe
        kidsBelt.labelThirdWhiteStripe = labelThirdWhiteStripe
        
        kidsBelt.firstWhiteStripe = firstWhiteStripe
        kidsBelt.secondWhiteStripe = secondWhiteStripe
        kidsBelt.thirdWhiteStripe = thirdWhiteStripe
        kidsBelt.fourthWhiteStripe = fourthWhiteStripe
        kidsBelt.firstRedStripe = firstRedStripe
        kidsBelt.secondRedStripe = secondRedStripe
        kidsBelt.thirdRedStripe = thirdRedStripe
        kidsBelt.fourthRedStripe = fourthRedStripe
        kidsBelt.firstBlackStripe = firstBlackStripe
        kidsBelt.secondBlackStripe = secondBlackStripe
        kidsBelt.thirdBlackStripe = thirdWhiteStripe
    }
    
    
    // Delete
    func delete(kidsBelt: KidsBelt) {
        guard let index = self.kidsBelts.index(of: kidsBelt) else { return }
        self.kidsBelts.remove(at: index)
    }
    
    
}













































