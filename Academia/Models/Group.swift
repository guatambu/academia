//
//  Group.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Group {
    
    // MARK: - Properties
    
    var active: Bool
    var name: String
    var dateCreated: Date
    var dateEdited: Date
    var members: [Any]?
    var paymentProgram: [PaymentProgram]?
    var location: Location?
    var aula: [Aula]?
    
    // Memberwise Initializer
    
    init(active: Bool, name: String, dateCreated: Date, dateEdited: Date, members: [Any]?, paymentProgram: [PaymentProgram]?, location: Location?, aula: [Aula]?) {
        
        self.active = active
        self.name = name
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.members = members
        self.paymentProgram = paymentProgram
        self.location = location
        self.aula = aula
    }
}











































