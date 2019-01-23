//
//  ClassTimeViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassTimeViewController: UIViewController  {

    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays] = []
    var time: String?
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // instances
    let beltBuilder = BeltBuilder()
    let classTimeComponents = ClassTimeComponents()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var daysOfTheWeekLabelOutlet: UILabel!
    @IBOutlet weak var classTimeDetailsLabelOutlet: UILabel!
    
    // class time UIPickerView
    @IBOutlet weak var classTimePickerView: UIPickerView!
    
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classTimePickerView.delegate = self
        classTimePickerView.dataSource = self
        
        //populateCompletedProfileInfo()
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("no aulaName, active, or aulaDescription passed to: ClassLocationAndTimeVC -> viewDidLoad() - line 73")
            return
        }
        
        print("program name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        guard let _ = time else {
            
            print("ERROR: nil value found for time property in ClassTimeViewController.swift -> saveButtonTapped() - line 72.")
            
            return
        }
            
        updateAulaInfo()
        
        self.returnToPaymentProgramInfo()
        
        print("update class time: \(String(describing: AulaModelController.shared.aulas[0].time))")
        
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
        if segue.identifier == "toAulaTime" {
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassTimeViewController else { return }
            
            // pass data to destViewController
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


// MARK: - Editing Mode for Individual User case specific setup
extension ClassTimeViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        guard let aula = aulaToEdit else { return }

        // class update info
       
        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: daysOfTheWeek, instructor: nil, ownerInstructor: nil, location: nil, students: nil, time: time)
        print("update class day of the week: \(AulaModelController.shared.aulas[0].daysOfTheWeek)")
        
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
extension ClassTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // hours component
        if component == 0 {
            return classTimeComponents.hoursStandardArray.count
            
        // minutes component
        } else if component == 1 {
            return classTimeComponents.minutesArray.count
            
        // AM/PM component
        } else if component == 2 {
            return classTimeComponents.amPmArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // hours component
        if component == 0 {
            return "\(classTimeComponents.hoursStandardArray[row].rawValue)"
            
            // minutes component
        } else if component == 1 {
            
            let minutes = classTimeComponents.minutesArray[row]
            
            switch minutes {
            case .zero: return ": \(minutes.rawValue)"
            case .five: return ": \(minutes.rawValue)"
            case .ten: return ": \(minutes.rawValue)"
            case .fifteen: return ": \(minutes.rawValue)"
            case .twenty: return ": \(minutes.rawValue)"
            case .twentyfive: return ": \(minutes.rawValue)"
            case .thirty: return ": \(minutes.rawValue)"
            case .thirtyfive: return ": \(minutes.rawValue)"
            case .forty: return ": \(minutes.rawValue)"
            case .fortyfive: return ": \(minutes.rawValue)"
            case .fifty: return ": \(minutes.rawValue)"
            case .fiftyfive: return ": \(minutes.rawValue)"
            }
            
            // AM/PM component
        } else if component == 2 {
            return "\(classTimeComponents.amPmArray[row].rawValue)"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.selectedRow(inComponent: 0) >= 11  {
            pickerView.selectRow(1, inComponent: 2, animated: true)
        } else if pickerView.selectedRow(inComponent: 0) < 11  {
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }
        
        let hourSelected = classTimeComponents.hoursStandardArray[pickerView.selectedRow(inComponent: 0)]
        
        let minutesSelected = classTimeComponents.minutesArray[pickerView.selectedRow(inComponent: 1)]
        
        let amPmSelected = classTimeComponents.amPmArray[pickerView.selectedRow(inComponent: 2)]
        
        time = "\(hourSelected.rawValue):\(minutesSelected.rawValue) \(amPmSelected.rawValue)"
        
        if let time = time {
            print(time)
        }
        
    }

}
