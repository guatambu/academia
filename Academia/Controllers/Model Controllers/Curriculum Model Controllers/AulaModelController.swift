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
    func add(active: Bool, className: String, classDescription: String, daysOfTheWeek: [ClassTimeComponents.Weekdays], timeOfDay: String, location: Location?, kidAttendees: [KidStudent]?, adultAttendees: [AdultStudent]?, instructor: [AdultStudent]?, ownerInstructor: [Owner]?) {
        
        let aula = Aula(aulaUID: UUID(), active: active, aulaName: className, aulaDescription: classDescription, daysOfTheWeek: daysOfTheWeek, timeOfDay: timeOfDay, location: location, kidAttendees: kidAttendees, adultAttendees: adultAttendees, instructor: instructor, ownerInstructor: ownerInstructor, currentDate: Date(), dateCreated: Date(), dateEdited: Date())
        
        aulas.append(aula)
    }
    
    // Read
    
    
    // Update
    func update(aula: Aula, active: Bool?, kidAttendees: [KidStudent]?, adultAttendees: [AdultStudent]?, aulaDescription: String?, aulaName: String?, daysOfTheWeek: [ClassTimeComponents.Weekdays]?, instructor: [AdultStudent]?, ownerInstructor: [Owner]?, location: Location?, students: [Any]?, timeOfDay: String?) {
        
        aula.dateEdited = Date()
        
        if let active = active {
            aula.active = active
        }
        if let kidAttendees = kidAttendees {
            aula.kidAttendees = kidAttendees
        }
        if let adultAttendees = adultAttendees {
            aula.adultAttendees = adultAttendees
        }
        if let aulaDescription = aulaDescription {
            aula.aulaDescription = aulaDescription
        }
        if let aulaName = aulaName {
            aula.aulaName = aulaName
        }
        if let daysOfTheWeek = daysOfTheWeek {
            aula.daysOfTheWeek = daysOfTheWeek
        }
        if let instructor = instructor {
            aula.instructor = instructor
        }
        if let ownerInstructor = ownerInstructor {
            aula.ownerInstructor = ownerInstructor
        }
        if let location = location {
            aula.location = location
        }
        if let timeOfDay = timeOfDay {
            aula.timeOfDay = timeOfDay
        }
    }
    
    
    // Delete
    func delete(aula: Aula) {
        guard let index = self.aulas.index(of: aula) else { return }
        self.aulas.remove(at: index)
    }
    
    
}
