//
//  KidsBelt+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

extension KidsBelt {
    
    convenience init(kidsBeltUID: String,
                     dateCreated: Date,
                     dateEdited: Date,
                     name: String,
                     active: Bool,
                     elligibleForNextBelt: Bool,
                     beltColor: UIColor,
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
                     labelThirdBlackStripe: String?,
                     context: NSManagedObjectContext
        ) {
        
        self.init(context: context)
        
        self.kidsBeltUID = kidsBeltUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.beltCenterRibbonView = beltCenterRibbonView
        self.beltColor = beltColor
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


//extension KidsBelt: Equatable {
//    
//    static func ==(lhs: KidsBelt, rhs: KidsBelt) -> Bool {
//        
//        if lhs.active != rhs.active { return false }
//        if lhs.kidsBeltUID != rhs.kidsBeltUID { return false }
//        if lhs.belt != rhs.belt { return false }
//        if lhs.blackBar != rhs.blackBar { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.elligibleForNextBelt != rhs.elligibleForNextBelt { return false }
//        if lhs.name != rhs.name { return false }
//        
//        if lhs.firstWhiteStripe != rhs.firstWhiteStripe { return false }
//        if lhs.secondWhiteStripe != rhs.secondWhiteStripe { return false }
//        if lhs.thirdWhiteStripe != rhs.thirdWhiteStripe { return false }
//        if lhs.fourthWhiteStripe != rhs.fourthWhiteStripe { return false }
//        if lhs.firstRedStripe != rhs.firstRedStripe { return false }
//        if lhs.secondRedStripe != rhs.secondRedStripe { return false }
//        if lhs.thirdRedStripe != rhs.thirdRedStripe { return false }
//        if lhs.fourthRedStripe != rhs.fourthRedStripe { return false }
//        if lhs.firstBlackStripe != rhs.firstBlackStripe { return false }
//        if lhs.secondBlackStripe != rhs.secondBlackStripe { return false }
//        if lhs.thirdBlackStripe != rhs.thirdBlackStripe { return false }
//        
//        return true
//    }
//}

