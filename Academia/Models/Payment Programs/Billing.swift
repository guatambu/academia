//
//  Billing.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class Billing {
    
    
    enum BillingType: String {
        case dropIn = "drop in"
        case monthly = "monthly"
        case threeMonths = "3 months"
        case sixMonths = "6 months"
        case twelveMonths = "12 months"
    }
    
    enum BillingOption: String {
        case firstOfTheMonth = "1st of the month"
        case fifthOfTheMonth = "5th of the month"
        case fifteenthOfTheMonth = "15th of the month"
        case twentiethOfTheMonth = "2oth of the month"
        case registrationDay = "registration day"
        case singleDay = "single day of classes"
    }
    
    enum BillingSignature: String {
        case digitallyTyped = "digital"
        case paperContract = "paper contract"
        case digitalFingerSignature = "sign with your finger"
        case touchID = "touchID"
        case faceID = "faceID"
        case otherBioMetric = "other BioMetric"
    }

    // arrays of Billing details to be used throughout app
    let types: [BillingType] = [.dropIn, .monthly, .threeMonths, .sixMonths, .twelveMonths]
    let options: [BillingOption] = [.firstOfTheMonth, .fifthOfTheMonth, .fifteenthOfTheMonth, .twentiethOfTheMonth, .registrationDay, .singleDay]
    let signatures: [BillingSignature] = [.digitallyTyped, .paperContract, .digitalFingerSignature, .touchID, .faceID, .otherBioMetric]

}
