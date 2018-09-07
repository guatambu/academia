//
//  AdultBlackBelt.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultBlackBelt {
    
    // MARK: - Properties
    var dateCreated: Date
    var dateEdited: Date
    var name: String
    var active: Bool
    var elligibleForNextBelt: Bool
    
    // belt constructors
    var belt: UIColor
    var leftTeacherBar: UIColor
    var rightTeacherBar: UIColor
    var redBar: UIColor
    var coralBar: UIColor?
    var firstWhiteDegree: Bool
    var secondWhiteDegree: Bool
    var thirdWhiteDegree: Bool
    var fourthWhiteDegree: Bool
    var fifthWhiteDegree: Bool
    var sixthWhiteDegree: Bool
    var seventhWhiteDegree: Bool
    var eigthWhiteDegree: Bool
    var ninthWhiteDegree: Bool
    var tenthWhiteDegree: Bool
    
    // Labels
    var beltTimeLabel: String?
    var labelFirstDegreeTime: String?
    var labelSecondDegreeTime: String?
    var labelThirdDegreeTime: String?
    var labelFourthDegreeTime: String?
    var labelFifthDegreeTime: String?
    var labelSixthDegreeTime: String?
    var labelSeventhDegreeTime: String?
    var labelEigthDegreeTime: String?
    var labelNinthDegreeTime: String?
    var labelTenthDegreeTime: String?
    
    
    
    // Memberwise Initializer
    
    init(dateCreated: Date,
         dateEdited: Date,
         name: String,
         active: Bool,
         elligibleForNextBelt: Bool,
         belt: UIColor,
         leftTeacherBar: UIColor,
         rightTeacherBar: UIColor,
         redBar: UIColor,
         coralBar: UIColor?,
         firstWhiteDegree: Bool,
         secondWhiteDegree: Bool,
         thirdWhiteDegree: Bool,
         fourthWhiteDegree: Bool,
         fifthWhiteDegree: Bool,
         sixthWhiteDegree: Bool,
         seventhWhiteDegree: Bool,
         eigthWhiteDegree: Bool,
         ninthWhiteDegree: Bool,
         tenthWhiteDegree: Bool,
         beltTimeLabel: String?,
         labelFirstDegreeTime: String?,
         labelSecondDegreeTime: String?,
         labelThirdDegreeTime: String?,
         labelFourthDegreeTime: String?,
         labelFifthDegreeTime: String?,
         labelSixthDegreeTime: String?,
         labelSeventhDegreeTime: String?,
         labelEigthDegreeTime: String?,
         labelNinthDegreeTime: String?,
         labelTenthDegreeTime: String?
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.belt = belt
        self.leftTeacherBar = leftTeacherBar
        self.rightTeacherBar = rightTeacherBar
        self.redBar = redBar
        self.coralBar = coralBar
        self.firstWhiteDegree = firstWhiteDegree
        self.secondWhiteDegree = secondWhiteDegree
        self.thirdWhiteDegree = thirdWhiteDegree
        self.fourthWhiteDegree = fourthWhiteDegree
        self.fifthWhiteDegree = fifthWhiteDegree
        self.sixthWhiteDegree = sixthWhiteDegree
        self.seventhWhiteDegree = seventhWhiteDegree
        self.eigthWhiteDegree = eigthWhiteDegree
        self.ninthWhiteDegree = ninthWhiteDegree
        self.tenthWhiteDegree = tenthWhiteDegree
        self.beltTimeLabel = beltTimeLabel
        self.labelFirstDegreeTime = labelFirstDegreeTime
        self.labelSecondDegreeTime = labelSecondDegreeTime
        self.labelThirdDegreeTime = labelThirdDegreeTime
        self.labelFourthDegreeTime = labelFourthDegreeTime
        self.labelFifthDegreeTime = labelFifthDegreeTime
        self.labelSixthDegreeTime = labelSixthDegreeTime
        self.labelSeventhDegreeTime = labelSeventhDegreeTime
        self.labelEigthDegreeTime = labelEigthDegreeTime
        self.labelNinthDegreeTime = labelNinthDegreeTime
        self.labelTenthDegreeTime = labelTenthDegreeTime
        
    }
    
    
    
}


let blackBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.black, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.black, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: false, eigthWhiteDegree: false, ninthWhiteDegree: false, tenthWhiteDegree: false, beltTimeLabel: "31 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: nil, labelEigthDegreeTime: nil, labelNinthDegreeTime: nil, labelTenthDegreeTime: nil)

let redBlackBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.black, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.red, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: false, tenthWhiteDegree: false, beltTimeLabel: "10 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: nil, labelTenthDegreeTime: nil)

let redWhiteBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.red, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: true, tenthWhiteDegree: false, beltTimeLabel: "7 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: "7y", labelTenthDegreeTime: nil)

let redBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.red, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: nil, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: true, tenthWhiteDegree: true, beltTimeLabel: "7 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: "7y", labelTenthDegreeTime: "7y")

var blackBelts = [blackBelt, redBlackBelt, redWhiteBelt, redBelt]























