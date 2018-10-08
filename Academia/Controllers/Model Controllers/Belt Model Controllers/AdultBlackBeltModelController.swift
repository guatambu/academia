//
//  AdultBlackBeltModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 10/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class AdultBlackBeltModelController {
    
    static let shared = AdultBlackBeltModelController()
    
    var adultBlackBelts = [AdultBlackBelt]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(name: String, active: Bool, elligibleForNextBelt: Bool, belt: UIColor, leftTeacherBar: UIColor, rightTeacherBar: UIColor, redBar: UIColor, coralBar: UIColor?, firstWhiteDegree: Bool, secondWhiteDegree: Bool, thirdWhiteDegree: Bool, fourthWhiteDegree: Bool, fifthWhiteDegree: Bool, sixthWhiteDegree: Bool, seventhWhiteDegree: Bool, eigthWhiteDegree: Bool, ninthWhiteDegree: Bool, tenthWhiteDegree: Bool, beltTimeLabel: String?, labelFirstDegreeTime: String?, labelSecondDegreeTime: String?, labelThirdDegreeTime: String?, labelFourthDegreeTime: String?, labelFifthDegreeTime: String?, labelSixthDegreeTime: String?, labelSeventhDegreeTime: String?, labelEigthDegreeTime: String?, labelNinthDegreeTime: String?, labelTenthDegreeTime: String?) {
        
        let adultBlackBelt = AdultBlackBelt(adultBlackBeltUID: "0002", dateCreated: Date(), dateEdited: Date(), name: name, active: active, elligibleForNextBelt: elligibleForNextBelt, belt: belt, leftTeacherBar: leftTeacherBar, rightTeacherBar: rightTeacherBar, redBar: redBar, coralBar: coralBar, firstWhiteDegree: firstWhiteDegree, secondWhiteDegree: secondWhiteDegree, thirdWhiteDegree: thirdWhiteDegree, fourthWhiteDegree: fourthWhiteDegree, fifthWhiteDegree: fifthWhiteDegree, sixthWhiteDegree: sixthWhiteDegree, seventhWhiteDegree: seventhWhiteDegree, eigthWhiteDegree: eigthWhiteDegree, ninthWhiteDegree: ninthWhiteDegree, tenthWhiteDegree: tenthWhiteDegree, beltTimeLabel: beltTimeLabel, labelFirstDegreeTime: labelFirstDegreeTime, labelSecondDegreeTime: labelSecondDegreeTime, labelThirdDegreeTime: labelThirdDegreeTime, labelFourthDegreeTime: labelFourthDegreeTime, labelFifthDegreeTime: labelFifthDegreeTime, labelSixthDegreeTime: labelSixthDegreeTime, labelSeventhDegreeTime: labelSeventhDegreeTime, labelEigthDegreeTime: labelEigthDegreeTime, labelNinthDegreeTime: labelNinthDegreeTime, labelTenthDegreeTime: labelTenthDegreeTime)
        
        adultBlackBelts.append(adultBlackBelt)
    }
    
    // Read
    
    
    // Update
    func update(adultBlackBelt: AdultBlackBelt, name: String, active: Bool, elligibleForNextBelt: Bool, belt: UIColor, leftTeacherBar: UIColor, rightTeacherBar: UIColor, redBar: UIColor, coralBar: UIColor?, firstWhiteDegree: Bool, secondWhiteDegree: Bool, thirdWhiteDegree: Bool, fourthWhiteDegree: Bool, fifthWhiteDegree: Bool, sixthWhiteDegree: Bool, seventhWhiteDegree: Bool, eigthWhiteDegree: Bool, ninthWhiteDegree: Bool, tenthWhiteDegree: Bool, beltTimeLabel: String?, labelFirstDegreeTime: String?, labelSecondDegreeTime: String?, labelThirdDegreeTime: String?, labelFourthDegreeTime: String?, labelFifthDegreeTime: String?, labelSixthDegreeTime: String?, labelSeventhDegreeTime: String?, labelEigthDegreeTime: String?, labelNinthDegreeTime: String?, labelTenthDegreeTime: String?) {
        
        adultBlackBelt.dateEdited = Date()
        adultBlackBelt.name = name
        adultBlackBelt.active = active
        adultBlackBelt.elligibleForNextBelt = elligibleForNextBelt
        adultBlackBelt.belt = belt
        adultBlackBelt.beltTimeLabel = beltTimeLabel
        adultBlackBelt.leftTeacherBar = leftTeacherBar
        adultBlackBelt.rightTeacherBar = rightTeacherBar
        adultBlackBelt.redBar = redBar
        adultBlackBelt.coralBar = coralBar
        
        adultBlackBelt.labelFirstDegreeTime = labelFirstDegreeTime
        adultBlackBelt.labelSecondDegreeTime = labelSecondDegreeTime
        adultBlackBelt.labelThirdDegreeTime = labelThirdDegreeTime
        adultBlackBelt.labelFourthDegreeTime = labelFourthDegreeTime
        adultBlackBelt.labelFifthDegreeTime = labelFifthDegreeTime
        adultBlackBelt.labelSixthDegreeTime = labelSixthDegreeTime
        adultBlackBelt.labelSeventhDegreeTime = labelSeventhDegreeTime
        adultBlackBelt.labelEigthDegreeTime = labelEigthDegreeTime
        adultBlackBelt.labelNinthDegreeTime = labelNinthDegreeTime
        adultBlackBelt.labelTenthDegreeTime = labelTenthDegreeTime
        
        adultBlackBelt.firstWhiteDegree = firstWhiteDegree
        adultBlackBelt.secondWhiteDegree = secondWhiteDegree
        adultBlackBelt.thirdWhiteDegree = thirdWhiteDegree
        adultBlackBelt.fourthWhiteDegree = fourthWhiteDegree
        adultBlackBelt.fifthWhiteDegree = fifthWhiteDegree
        adultBlackBelt.sixthWhiteDegree = sixthWhiteDegree
        adultBlackBelt.seventhWhiteDegree = seventhWhiteDegree
        adultBlackBelt.eigthWhiteDegree = eigthWhiteDegree
        adultBlackBelt.ninthWhiteDegree = ninthWhiteDegree
        adultBlackBelt.tenthWhiteDegree = tenthWhiteDegree
    }
    
    
    // Delete
    func delete(adultBlackBelt: AdultBlackBelt) {
        guard let index = self.adultBlackBelts.index(of: adultBlackBelt) else { return }
        self.adultBlackBelts.remove(at: index)
    }
    
    
}













































