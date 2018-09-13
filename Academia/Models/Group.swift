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
    var members: [User]?
    var paymentProgram: [PaymentProgram]?
    var location: Location?
    var aula: [Aula]?
    
    // Memberwise Initializer
    
    init(active: Bool, name: String, dateCreated: Date, dateEdited: Date, members: [User]?, paymentProgram: [PaymentProgram]?, location: Location?, aula: [Aula]?) {
        
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

//var kidsParents: Group = Group(active: true, name: "kids Parents", dateCreated: Date(), dateEdited: Date(), members: [kidA, kidB, owner], paymentProgram: [kidsProgram], location: myLocation, aula: [kidsClassA])
//
//var adults: Group = Group(active: true, name: "adults", dateCreated: Date(), dateEdited: Date(), members: [adultA, adultB, instructorA, instructorB, owner], paymentProgram: [adultsProgram], location: myLocation, aula: [adultClassA])
//
//var instructors: Group = Group(active: true, name: "instructors", dateCreated: Date(), dateEdited: Date(), members: [owner, instructorB, instructorA], paymentProgram: [adultsProgram], location: myLocation, aula: [adultClassA])
//
//var allStudents: Group = Group(active: true, name: "all students", dateCreated: Date(), dateEdited: Date(), members: [owner, instructorA, instructorB, adultA, adultB, kidA, kidB], paymentProgram: [adultsProgram, kidsProgram], location: myLocation, aula: [kidsClassA, adultClassA])











































