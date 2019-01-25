//
//  ClassLocationViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/20/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassLocationViewController: UIViewController {

    // MARK: - Properties
    
    // MOCK DATA
    var locations = [MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation]
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var time: String?
    var location:Location?
    
    // to hold the compiled string for the classLocationLabelOutlet
    var locationString = ""
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // instances
    let beltBuilder = BeltBuilder()
    let classTimeComponents = ClassTimeComponents()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var classLocationLabelOutlet: UILabel!
    
    // class time UIPickerView
    @IBOutlet weak var classLocationPickerView: UIPickerView!
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classLocationPickerView.delegate = self
        classLocationPickerView.dataSource = self
        
        classLocationLabelOutlet.text = locations[classLocationPickerView.selectedRow(inComponent: 0)].locationName
        
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("no aulaName, active, or aulaDescription passed to: ClassLocationVC -> viewDidLoad() - line 61")
            return
        }
        
        print("program name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        if classLocationLabelOutlet.text != "" {

            updateAulaInfo()

            self.returnToClassInfo()
            
            print("update aula location: \(String(describing: self.aulaToEdit?.location?.locationName))")
        }
        inEditingMode = false
    }
    
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // check for errors before performing segue, and if error, block navigation
        if time == nil {
            
            welcomeMessageLabelOutlet.textColor = beltBuilder.redBeltRed
            
            return false
            
        } else {
            
            return true
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // confirm appropriate segue via segue.identifier
        if segue.identifier == "toClassInstructors" {
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassInstructorsTableViewController else { return }
            
            // pass data to destViewController
            destViewController.location = location
            destViewController.time = time
            destViewController.daysOfTheWeek = daysOfTheWeek
            destViewController.aulaName = aulaName
            destViewController.active = active
            destViewController.aulaDescription = aulaDescription
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaToEdit = aulaToEdit
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
        
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassLocationViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        guard let aula = aulaToEdit else { return }
        
        // class update info
        
        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: daysOfTheWeek, instructor: nil, ownerInstructor: nil, location: location, students: nil, time: nil, classGroups: nil)
        print("update class location: \(String(describing: AulaModelController.shared.aulas[0].location?.locationName))")
        
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            aulaEditingSetup()
        }
        
        print("ClassLocationAndTimeVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
        guard let aulaToEdit = aulaToEdit else {
            return
        }
        
        welcomeMessageLabelOutlet.text = "Aula: \(aulaToEdit.aulaName)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        daysOfTheWeek = aulaToEdit.daysOfTheWeek
        time = aulaToEdit.time ?? ""
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - UIPickerView Protocol Conformance & Methods
extension ClassLocationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // locations component
        if component == 0 {
            return locations.count

        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // locations component
        if component == 0 {
            return "\(locations[row].locationName)"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let locationSelected = locations[pickerView.selectedRow(inComponent: 0)]
        
        locationString = "\(locationSelected.locationName)"
        
        classLocationLabelOutlet.text = locationString
        
        if let location = location {
            print(location.locationName)
        }
    }
}



