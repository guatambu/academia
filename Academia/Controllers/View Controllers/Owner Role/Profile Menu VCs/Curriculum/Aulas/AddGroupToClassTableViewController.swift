//
//  AddGroupToClassTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class AddGroupToClassTableViewController: UITableViewController, ClassGroupDelegate {

    // MARK: - Properties
    
    var mockDatGroups = [MockData.allStudents, MockData.allStudents, MockData.allStudents, MockData.allStudents ]
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var time: String?
    var location:Location?
    
    var instructors: [AdultStudent]?
    var ownerInstructors: [Owner]?
    var classGroups: [Group] = []
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructions1LabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructions2LabelOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("no aulaName, active, or aulaDescription passed to: ClassLocationVC -> viewDidLoad() - line 61")
            return
        }
        
        print("AddGroupToClassTVC \naula name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // class group update info
        guard classGroups.isEmpty else {
            
            welcomeInstructions1LabelOutlet.textColor = beltBuilder.redBeltRed
            
            return
        }
            
        updateAulaInfo()
        
        self.returnToClassInfo()
        
        print("update aula location: \(String(describing: self.aulaToEdit?.location?.locationName))")
        
        inEditingMode = false
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mockDatGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "classGroupCell", for: indexPath) as! ClassGroupTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.kidMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                    
                    guard let classGroupsToEdit = aulaToEdit?.classGroups else {
                        print("ERROR: nil value for aulaToEdit.classGroups in AddGroupToClassTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 109")
                        return UITableViewCell()
                    }
                    
                    if classGroupsToEdit.contains(classGroups[indexPath.row]) {
                        
                        cell.isChosen = true
                    }
                }
            }
            
            cell.group = mockDatGroups[indexPath.row]
            
            return cell
            
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toGroupInfoDetails") as! GroupInfoDetailsTableViewController
        
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        let group = mockDatGroups[indexPath.row]
        
        destViewController.group = group
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toClassReviewAndCreate" {
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ReviewAndCreateClassTableViewController else { return }
            
            // pass data to destViewController
            destViewController.classGroups = classGroups
            destViewController.instructors = instructors
            destViewController.ownerInstructors = ownerInstructors
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
extension AddGroupToClassTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        guard let aula = aulaToEdit else { return }
        
        // class update info
        
        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: nil, instructor: nil, ownerInstructor: nil, location: nil, students: nil, time: nil, classGroups: classGroups)
        print("update class location: \(String(describing: AulaModelController.shared.aulas[0].classGroups))")
        
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
        
        welcomeInstructions1LabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructions1LabelOutlet.text = "you are in group editing mode"
        
        daysOfTheWeek = aulaToEdit.daysOfTheWeek
        time = aulaToEdit.time ?? ""
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}
