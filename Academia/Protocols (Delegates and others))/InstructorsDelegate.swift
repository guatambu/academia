//
//  InstructorsDelegate.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

// MARK: - ClassInstructorsTVC to Instructor... & OwnerInstructorTableViewCell Delegate protocol to access TVC's instructors and ownerInstructors array properties
protocol InstructorsDelegate: class {
    var instructors: [AdultStudent] { get set }
    var ownerInstructors: [Owner] { get set }
    
}

