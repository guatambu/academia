//
//  ActiveUserDelegate.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 4/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

protocol ActiveOwnerDelegate {
    var activeOwner: UUID? { get set }
    
}

protocol ActiveStudentDelegate {
    var activeStudent: UUID? { get set }
}
