//
//  AddGroupToClassTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit
import CoreData

class AddGroupToClassTableViewController: UITableViewController, ClassGroupDelegate {

    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var time: String?
    var timeCode: Int?
    var location:Location?
    
    var instructors: [AdultStudent]?
    var ownerInstructors: [Owner]?
    var classGroups: [Group] = []
    
    var inEditingMode: Bool?
    
    let beltBuilder = BeltBuilder()
   
    @IBOutlet weak var welcomeInstructions1LabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructions2LabelOutlet: UILabel!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    
    // CoreData Properties
    var aulaCD: AulaCD?
    var aulaCDToEdit: AulaCD?
    
    var locationCD: LocationCD?
    
    var instructorsCD: [StudentAdultCD] = []
    var ownerInstructorsCD: [OwnerCD] = []
    var classGroupsCD: [GroupCD] = []
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        enterEditingMode(inEditingMode: inEditingMode)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("no aulaName, active, or aulaDescription passed to: ClassLocationVC -> viewDidLoad() - line 61")
            return
        }
        
        print("AddGroupToClassTVC \naula name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // class group update info

        updateAulaInfo()
        
        self.returnToClassInfo()
        
        print("update aula location: \(String(describing: self.aulaCDToEdit?.location?.locationName))")
        
        inEditingMode = false
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return GroupCDModelController.shared.groups.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "classGroupCell", for: indexPath) as! ClassGroupTableViewCell
        
        // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
        cell.delegate = self
            
        // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.kidMembers array to display the student as chosen
        if let inEditingMode = inEditingMode {
            
            if inEditingMode {
                
                guard let groupsAulaCDToEdit = aulaCDToEdit?.groupsAula else {
                    print("ERROR: nil value for aulaToEdit.classGroups in AddGroupToClassTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 109")
                    return UITableViewCell()
                }
                
                let groupsAulaCDArray = Array(groupsAulaCDToEdit) as! [GroupCD]
                // run check to make sure the groupsAulaCDArray is not empty 
                if groupsAulaCDArray.isEmpty == false  {
                    
                    for group in groupsAulaCDArray {
                        
                        // run check to see whether this object.name property matches the current object.name listed at this point in the tableView's cell
                        if GroupCDModelController.shared.groups[indexPath.row].name == group.name {
                            
                            cell.isChosen = true
                        }
                    }
                }
            }
        }

        let groupCD = GroupCDModelController.shared.groups[indexPath.row]
        cell.groupCD = groupCD
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toGroupInfoDetails") as! GroupInfoDetailsTableViewController
        
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // CoreData version
        // get the desired paymentProgramCD for the selected cell
        let groupCD = GroupCDModelController.shared.groups[indexPath.row]
        // pass CoreData payment program on to InfoDetails view
        destViewController.groupCD = groupCD
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toClassReviewAndCreate" {
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ReviewAndCreateClassTableViewController else { return }
            
            // pass data to destViewController
            destViewController.classGroups = classGroups
            destViewController.instructors = instructors
            destViewController.ownerInstructors = ownerInstructors
            destViewController.location = location
            destViewController.time = time
            destViewController.timeCode = timeCode
            destViewController.daysOfTheWeek = daysOfTheWeek
            destViewController.aulaName = aulaName
            destViewController.active = active
            destViewController.aulaDescription = aulaDescription
            
            destViewController.locationCD = locationCD
            destViewController.ownerInstructorsCD = ownerInstructorsCD
            destViewController.instructorsCD = instructorsCD
            destViewController.classGroupsCD = classGroupsCD
            
            destViewController.inEditingMode = inEditingMode
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension AddGroupToClassTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        aulaCDToEdit.groupsAula = NSOrderedSet(array: classGroupsCD)
    
        // save the update
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            nextButtonOutlet.isHidden = true
            nextButtonOutlet.isEnabled = false
            
            aulaEditingSetup()
        } else {
            nextButtonOutlet.isHidden = false
            nextButtonOutlet.isEnabled = true
        }
        
        print("ClassLocationAndTimeVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else {
            return
        }
        
        guard let groupsCDToEdit = aulaCDToEdit.groupsAula else {
            print("ERROR: nil value for aulaCDToEdit.classGroups in AddGroupToClassTableViewController.swift -> aulaEditingSetup() - line 222")
            return
        }
        
//        welcomeMessageLabelOutlet.text = "\(aulaCDToEdit.aulaName ?? "")"
//        
//        welcomeInstructions1LabelOutlet.textColor = beltBuilder.redBeltRed
//        welcomeInstructions1LabelOutlet.text = "you are in class editing mode"
        
        classGroupsCD = Array(groupsCDToEdit) as! [GroupCD]
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


