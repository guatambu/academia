//
//  BlackBelt+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension BlackBelt {
    
    convenience init(adultBlackBeltUID: String,
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
                     labelTenthDegreeTime: String?,
                     context: NSManagedObjectContext
        ) {
        
        self.init(context: context)
        
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


//extension BlackBelt: Equatable {
//    
//    static func ==(lhs: BlackBelt, rhs: BlackBelt) -> Bool {
//        
//        if lhs.active != rhs.active { return false }
//        if lhs.adultBlackBeltUID != rhs.adultBlackBeltUID { return false }
//        if lhs.belt != rhs.belt { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.elligibleForNextBelt != rhs.elligibleForNextBelt { return false }
//        if lhs.leftTeacherBar != rhs.leftTeacherBar { return false }
//        if lhs.name != rhs.name { return false }
//        if lhs.redBar != rhs.redBar { return false }
//        if lhs.rightTeacherBar != rhs.rightTeacherBar { return false }
//        
//        if lhs.firstWhiteDegree != rhs.firstWhiteDegree { return false }
//        if lhs.secondWhiteDegree != rhs.secondWhiteDegree { return false }
//        if lhs.thirdWhiteDegree != rhs.thirdWhiteDegree { return false }
//        if lhs.fourthWhiteDegree != rhs.fourthWhiteDegree { return false }
//        if lhs.fifthWhiteDegree != rhs.fifthWhiteDegree { return false }
//        if lhs.sixthWhiteDegree != rhs.sixthWhiteDegree { return false }
//        if lhs.seventhWhiteDegree != rhs.seventhWhiteDegree { return false }
//        if lhs.eigthWhiteDegree != rhs.eigthWhiteDegree { return false }
//        if lhs.ninthWhiteDegree != rhs.ninthWhiteDegree { return false }
//        if lhs.tenthWhiteDegree != rhs.tenthWhiteDegree { return false }
//        
//        return true
//    }
//}

