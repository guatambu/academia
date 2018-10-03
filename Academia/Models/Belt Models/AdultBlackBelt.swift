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
    
    // UID
    let adultBlackBeltUID: String
    
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
    
    init(adultBlackBeltUID: String,
         dateCreated: Date,
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
        
        self.adultBlackBeltUID = adultBlackBeltUID
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


























