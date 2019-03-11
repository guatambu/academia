//
//  ActiveUserModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class ActiveUserModelController {
    
    // MARK: - Properties
    
    static let shared = ActiveUserModelController()
    
    var activeUser: [UUID] = []

    
    // MARK: - Delete
    func remove() {
        
        activeUser.removeAll()
        
    }
}

