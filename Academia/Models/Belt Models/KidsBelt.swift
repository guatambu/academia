//
//  KidsBelt.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class KidsBelt {
    
    // MARK: - Properties
    
    // UID
    let kidsBeltUID: String
    
    var dateCreated: Date
    var dateEdited: Date
    var name: String
    var active: Bool
    var elligibleForNextBelt: Bool
    
    // belt constructors
    var belt: UIColor
    var beltCenterRibbonView: UIColor?
    var blackBar: UIColor
    var firstWhiteStripe: Bool
    var secondWhiteStripe: Bool
    var thirdWhiteStripe: Bool
    var fourthWhiteStripe: Bool
    var firstRedStripe: Bool
    var secondRedStripe: Bool
    var thirdRedStripe: Bool
    var fourthRedStripe: Bool
    var firstBlackStripe: Bool
    var secondBlackStripe: Bool
    var thirdBlackStripe: Bool
    
    // Labels
    var beltTimeLabel: String?
    var labelFirstWhiteStripe: String?
    var labelSecondWhiteStripe: String?
    var labelThirdWhiteStripe: String?
    var labelFourthWhiteStripe: String?
    var labelFirstRedStripe: String?
    var labelSecondRedStripe: String?
    var labelThirdRedStripe: String?
    var labelFourthRedStripe: String?
    var labelFirstBlackStripe: String?
    var labelSecondBlackStripe: String?
    var labelThirdBlackStripe: String?
    
    
    // Memberwise Initializer
    
    init(kidsBeltUID: String,
         dateCreated: Date,
         dateEdited: Date,
         name: String,
         active: Bool,
         elligibleForNextBelt: Bool,
         belt: UIColor,
         beltCenterRibbonView: UIColor?,
         blackBar: UIColor,
         firstWhiteStripe: Bool,
         secondWhiteStripe: Bool,
         thirdWhiteStripe: Bool,
         fourthWhiteStripe: Bool,
         firstRedStripe: Bool,
         secondRedStripe: Bool,
         thirdRedStripe: Bool,
         fourthRedStripe: Bool,
         firstBlackStripe: Bool,
         secondBlackStripe: Bool,
         thirdBlackStripe: Bool,
         beltTimeLabel: String?,
         labelFirstWhiteStripe: String?,
         labelSecondWhiteStripe: String?,
         labelThirdWhiteStripe: String?,
         labelFourthWhiteStripe: String?,
         labelFirstRedStripe: String?,
         labelSecondRedStripe: String?,
         labelThirdRedStripe: String?,
         labelFourthRedStripe: String?,
         labelFirstBlackStripe: String?,
         labelSecondBlackStripe: String?,
         labelThirdBlackStripe: String?
        ) {
        
        self.kidsBeltUID = kidsBeltUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.beltCenterRibbonView = beltCenterRibbonView
        self.belt = belt
        self.blackBar = blackBar
        self.firstWhiteStripe = firstWhiteStripe
        self.secondWhiteStripe = secondWhiteStripe
        self.thirdWhiteStripe = thirdWhiteStripe
        self.fourthWhiteStripe = fourthWhiteStripe
        self.firstRedStripe = firstRedStripe
        self.secondRedStripe = secondRedStripe
        self.thirdRedStripe = thirdRedStripe
        self.fourthRedStripe = fourthRedStripe
        self.firstBlackStripe = firstBlackStripe
        self.secondBlackStripe = secondBlackStripe
        self.thirdBlackStripe = thirdBlackStripe
        self.beltTimeLabel = beltTimeLabel
        self.labelFirstWhiteStripe = labelFirstWhiteStripe
        self.labelSecondWhiteStripe = labelSecondWhiteStripe
        self.labelThirdWhiteStripe = labelThirdWhiteStripe
        self.labelFourthWhiteStripe = labelFourthWhiteStripe
        self.labelFirstRedStripe = labelFirstRedStripe
        self.labelSecondRedStripe = labelSecondRedStripe
        self.labelThirdRedStripe = labelThirdRedStripe
        self.labelFourthRedStripe = labelFourthRedStripe
        self.labelFirstBlackStripe = labelFirstBlackStripe
        self.labelSecondBlackStripe = labelSecondBlackStripe
        self.labelThirdBlackStripe = labelThirdBlackStripe
    }
    
    
    
    
    
}
































