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
    
    init(dateCreated: Date,
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


let kidsWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: false, thirdRedStripe: false, fourthRedStripe: false, firstBlackStripe: false, secondBlackStripe: false, thirdBlackStripe: false, beltTimeLabel: "6 months", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: nil, labelThirdRedStripe: nil, labelFourthRedStripe: nil, labelFirstBlackStripe: nil, labelSecondBlackStripe: nil, labelThirdBlackStripe: nil)

let grayWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Gray White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let grayBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Gray Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let grayBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Gray Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let yellowWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Yellow White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let yellowBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Yellow Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let yellowBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Yellow Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let orangeWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Orange White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let orangeBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Orange Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let orangeBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Ornge Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let greenWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Green White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let greenBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Green Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

let greenBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Green Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

var kidsBelts = [kidsWhiteBelt, grayWhiteBelt, grayBelt, grayBlackBelt, yellowWhiteBelt, yellowBelt, yellowBlackBelt, orangeWhiteBelt, orangeBelt, orangeBlackBelt, greenWhiteBelt, greenBelt, greenBlackBelt]































