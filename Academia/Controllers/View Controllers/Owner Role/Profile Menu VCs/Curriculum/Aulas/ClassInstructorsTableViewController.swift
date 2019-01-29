//
//  ClassInstructorsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassInstructorsTableViewController: UITableViewController, InstructorsDelegate {
    
    // MARK: - Properties
    
    // MOCK DATA
    let possibleInstructors = [MockData.adultA, MockData.adultB]
    let availableOwners = [MockData.owner]
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var time: String?
    var timeCode: Int?
    var location: Location?

    var instructors: [AdultStudent] = []
    var ownerInstructors: [Owner] = []
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Owners", "Instructors"]
    
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
        
        print("ClassInstructorsTVC \naula name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // class update info
        guard instructors.isEmpty && ownerInstructors.isEmpty else {
            
            welcomeInstructions1LabelOutlet.textColor = beltBuilder.redBeltRed
            
            return
        }
    
        updateAulaInfo()
        
        self.returnToClassInfo()
        
        print("update aula instructors: \(String(describing: self.aulaToEdit?.instructor)) + \(String(describing: self.aulaToEdit?.ownerInstructor))")
        
        inEditingMode = false
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionHeaderLabels.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        sectionHeaderView.backgroundColor = UIColor.white
        
        let avenirFont16 = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        let label = UILabel()
        label.attributedText = NSAttributedString(string: sectionHeaderLabels[section], attributes: avenirFont16)
        label.frame = CGRect(x: 16, y: 0, width: 80, height: 40)
        
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return availableOwners.count
            
        } else if section == 1 {
            return possibleInstructors.count
            
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerInstructorCell", for: indexPath) as! OwnerInstructorTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.kidMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                    
                    guard let ownerInstructorsToEdit = aulaToEdit?.ownerInstructor else {
                        print("ERROR: nil value for aulaToEdit.ownerInstructor in ClassInstructorsTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 117")
                        return UITableViewCell()
                    }
                    
                    if ownerInstructorsToEdit.contains(ownerInstructors[indexPath.row]) {
                        
                        cell.isChosen = true
                    }
                }
            }
            
            cell.ownerInstructor = availableOwners[indexPath.row]
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructorCell", for: indexPath) as! InstructorTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.adultMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                    
                    guard let instructorsToEdit = aulaToEdit?.instructor else {
                        print("ERROR: nil value for aulaToEdit.instructor in ClassInstructorsTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 144")
                        return UITableViewCell()
                    }
                    
                    if instructorsToEdit.contains(possibleInstructors[indexPath.row]) {
                        
                        cell.isChosen = true
                    }
                }
            }
            
            cell.instructor = possibleInstructors[indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toProfileComplete") as! OwnersStudentDetailViewController
        
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        if indexPath.section == 0 {
            // kidStudent setup
            let owner = availableOwners[indexPath.row]
            
            destViewController.isOwner = true
            destViewController.isKid = false
            destViewController.username = owner.username
            destViewController.password = owner.password
            destViewController.firstName = owner.firstName
            destViewController.lastName = owner.lastName
            destViewController.profilePic = owner.profilePic
            destViewController.birthdate = owner.birthdate
            destViewController.beltLevel = owner.belt.beltLevel
            destViewController.numberOfStripes = owner.belt.numberOfStripes
            destViewController.addressLine1 = owner.addressLine1
            destViewController.addressLine2 = owner.addressLine2
            destViewController.city = owner.city
            destViewController.state = owner.state
            destViewController.zipCode = owner.zipCode
            destViewController.phone = owner.phone
            destViewController.mobile = owner.mobile
            destViewController.email = owner.email
            destViewController.emergencyContactName = owner.emergencyContactName
            destViewController.emergencyContactRelationship = owner.emergencyContactRelationship
            destViewController.emergencyContactPhone = owner.emergencyContactPhone
            
        } else if indexPath.section == 1 {
            // adultStudent setup
            let instructor = possibleInstructors[indexPath.row]
            
            destViewController.isOwner = false
            destViewController.isKid = false
            destViewController.username = instructor.username
            destViewController.password = instructor.password
            destViewController.firstName = instructor.firstName
            destViewController.lastName = instructor.lastName
            destViewController.profilePic = instructor.profilePic
            destViewController.birthdate = instructor.birthdate
            destViewController.beltLevel = instructor.belt.beltLevel
            destViewController.numberOfStripes = instructor.belt.numberOfStripes
            destViewController.addressLine1 = instructor.addressLine1
            destViewController.addressLine2 = instructor.addressLine2
            destViewController.city = instructor.city
            destViewController.state = instructor.state
            destViewController.zipCode = instructor.zipCode
            destViewController.phone = instructor.phone
            destViewController.mobile = instructor.mobile
            destViewController.email = instructor.email
            destViewController.emergencyContactName = instructor.emergencyContactName
            destViewController.emergencyContactRelationship = instructor.emergencyContactRelationship
            destViewController.emergencyContactPhone = instructor.emergencyContactPhone
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toClassGroups" {
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? AddGroupToClassTableViewController else { return }
            
            // pass data to destViewController
            destViewController.instructors = instructors
            destViewController.ownerInstructors = ownerInstructors
            destViewController.location = location
            destViewController.time = time
            destViewController.timeCode = timeCode
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
extension ClassInstructorsTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        guard let aula = aulaToEdit else { return }
        
        // class update info
        
        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: daysOfTheWeek, instructor: nil, ownerInstructor: nil, location: location, students: nil, time: nil, timeCode: nil, classGroups: nil)
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
        
        welcomeInstructions1LabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructions1LabelOutlet.text = "you are in group editing mode"
        
        daysOfTheWeek = aulaToEdit.daysOfTheWeek
        time = aulaToEdit.time ?? ""
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}

