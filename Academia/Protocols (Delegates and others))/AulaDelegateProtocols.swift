//
//  AulaDelegateProtocols.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/17/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation


// MARK: - ClassLocationAndTimeVC to DaysOfTheWeekCollectionViewCell Delegate protocol to access VC's days array property
protocol DaysOfTheWeekDelegate: class {
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]? { get set }
    
}


// MARK: - ClassLocationAndTimeVC to TimeOfDayCollectionViewCell Delegate protocol to access VC's timeOfDay property
protocol TimeOfDayDelegate: class {
    var times: [String]? { get set }
    
}


// MARK: - ClassLocationAndTimeVC to LocationCollectionViewCell Delegate protocol to access VC's location property
protocol AulaLocationDelegate: class {
    var locations: [Location]? { get set }
    
}
