//
//  AulaModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 10/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AulaModelController {
    
    static let shared = AulaModelController()
    
    var aulas = [Aula]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNewAula(active: Bool, className: String, classDescription: String, daysOfTheWeek: [Weekdays], timeOfDay: Aula.ClassTimes, location: String, students: [Any]?, instructor: [Any]?) {
        
        let aula = Aula(aulaUID: "005", active: active, className: className, classDescription: classDescription, daysOfTheWeek: daysOfTheWeek, timeOfDay: timeOfDay, location: location, students: students, instructor: instructor, currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: nil)
        
        aulas.append(aula)
    }
    
    // Read
    
    
    // Update
    
    
    // Delete
    func deleteAula(aula: Aula) {
        guard let index = self.aulas.index(of: aula) else { return }
        self.aulas.remove(at: index)
    }
    
    
}
