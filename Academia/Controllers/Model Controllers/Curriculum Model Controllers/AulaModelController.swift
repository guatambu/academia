//
//  AulaModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 10/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class AulaModelController {
    
    static let shared = AulaModelController()
    
    var aulas = [Aula]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(active: Bool, className: String, classDescription: String, daysOfTheWeek: [ClassTimeComponents.Weekdays], timeOfDay: String, location: Location?, kidAttendees: [KidStudent]?, adultAttendees: [AdultStudent]?, instructor: [AdultStudent]?, ownerInstructor: [Owner]?) {
        
        let aula = Aula(aulaUID: UUID(), active: active, aulaName: className, aulaDescription: classDescription, daysOfTheWeek: daysOfTheWeek, timeOfDay: timeOfDay, location: location, kidAttendees: kidAttendees, adultAttendees: adultAttendees, instructor: instructor, ownerInstructor: ownerInstructor, currentDate: Date(), dateCreated: Date(), dateEdited: Date())
        
        aulas.append(aula)
    }
    
    // Read
    
    
    // Update
    func update(aula: Aula, active: Bool, kidAttendees: [KidStudent]?, adultAttendees: [AdultStudent]?, aulaDescription: String, aulaName: String, daysOfTheWeek: [ClassTimeComponents.Weekdays], instructor: [AdultStudent]?, ownerInstructor: [Owner]?, location: Location?, students: [Any]?, timeOfDay: String) {
        
        aula.active = active
        aula.kidAttendees = kidAttendees
        aula.adultAttendees = adultAttendees
        aula.aulaDescription = aulaDescription
        aula.aulaName = aulaName
        aula.dateEdited = Date()
        aula.daysOfTheWeek = daysOfTheWeek
        aula.instructor = instructor
        aula.ownerInstructor = ownerInstructor
        aula.location = location
        aula.timeOfDay = timeOfDay
    }
    
    
    // Delete
    func delete(aula: Aula) {
        guard let index = self.aulas.index(of: aula) else { return }
        self.aulas.remove(at: index)
    }
    
    
}
