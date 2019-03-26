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
    
    // create a fetchedRequestController with predicate to grab the current LocationsCD objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsController: NSFetchedResultsController<GroupCD>!
    
    var mockDatGroups = [MockData.allStudents, MockData.allStudents, MockData.allStudents, MockData.allStudents ]
    
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
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructions1LabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructions2LabelOutlet: UILabel!
    
    // CoreData Properties
    var aulaCD: AulaCD?
    var aulaCDToEdit: AulaCD?
    
    var locationCD: LocationCD?
    
    var instructorsCD: [StudentAdultCD] = []
    var ownerInstructorsCD: [OwnerCD] = []
    var classGroupsCD: [GroupCD] = []
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
        
        // create fetch request and initialize results
        initializeFetchedResultsController()
        
        tableView.reloadData()
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

        updateAulaInfo()
        
        self.returnToClassInfo()
        
        print("update aula location: \(String(describing: self.aulaCDToEdit?.location?.locationName))")
        
        inEditingMode = false
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return mockDatGroups.count
        
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
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
                
                if groupsAulaCDArray.isEmpty == false && (groupsAulaCDArray.count - 1) >= indexPath.row {
                    
                    if classGroupsCD.contains(groupsAulaCDArray[indexPath.row]) {
                        
                        cell.isChosen = true
                    }
                }
            }
        }
    
        guard let groupCD = self.fetchedResultsController?.object(at: indexPath) else {
        fatalError("Attempt to configure cell without a managed object")
        }
        cell.groupCD = groupCD
//        cell.group = mockDatGroups[indexPath.row]
        
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
        
        let group = mockDatGroups[indexPath.row]
        
        destViewController.group = group
        
        // CoreData version
        // get the desired paymentProgramCD for the selected cell
        let groupCD = fetchedResultsController.object(at: indexPath)
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
        
//        guard let aula = aulaCDToEdit else { return }
//
//        // class update info
//
//        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: nil, instructor: nil, ownerInstructor: nil, location: nil, students: nil, time: nil, timeCode: nil, classGroups: classGroups)
//        print("update class groups: \(String(describing: AulaModelController.shared.aulas[0].classGroups))")
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        // here we want to loop through the classGroupsCD array and check the existing corresponding groupsAulaCD NSSet to see if it contains the current iterated member object and if it does NOT, then add that iterated member object to the groupsAulaExistingCD NSSet
        for group in classGroupsCD {
            
            // check the aulaCDToEdit.clasGroups NSSet to see if the daysOfTheWeek array contents are present in the NSSet version
            if let groupsAulaExistingCD = aulaCDToEdit.groupsAula {
                
                let predicate = NSPredicate(format: "name == %@", "\(group.name ?? "")")
                // using the predicate, return the filtered result to a new NSSet
                let confirmedPresentGroupsAulaNSSet = groupsAulaExistingCD.filtered(using: predicate)
                
                // if the resulting confirmedPresentGroupsAulaNSSet does not have a group in it, then the current iteration of group is not present in the groupsAulaExistingCD NSSet
                if confirmedPresentGroupsAulaNSSet.count == 0 {
                    // add the group to the existing aulaToEdit.groupsAula property
                    aulaCDToEdit.addToGroupsAula(group)
                }
            }
            // save the update
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
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
        
//        guard let aulaToEdit = aulaToEdit else {
//            return
//        }
//
//        guard let groupsToEdit = aulaToEdit.classGroups else {
//            print("ERROR: nil value for aulaToEdit.classGroups in AddGroupToClassTableViewController.swift -> aulaEditingSetup() - line 222")
//            return
//        }
//
//        welcomeMessageLabelOutlet.text = "\(aulaToEdit.aulaName)"
//
//        welcomeInstructions1LabelOutlet.textColor = beltBuilder.redBeltRed
//        welcomeInstructions1LabelOutlet.text = "you are in class editing mode"
//
//        daysOfTheWeek = aulaToEdit.daysOfTheWeek
//        time = aulaToEdit.time ?? ""
//        classGroups = groupsToEdit
//
//        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else {
            return
        }
        
        guard let groupsCDToEdit = aulaCDToEdit.groupsAula else {
            print("ERROR: nil value for aulaCDToEdit.classGroups in AddGroupToClassTableViewController.swift -> aulaEditingSetup() - line 222")
            return
        }
        
        welcomeMessageLabelOutlet.text = "\(aulaCDToEdit.aulaName ?? "")"
        
        welcomeInstructions1LabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructions1LabelOutlet.text = "you are in class editing mode"
        
        classGroupsCD = Array(groupsCDToEdit) as! [GroupCD]
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - NSFetchedREsultsController initializer method
extension AddGroupToClassTableViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupCD")
        let groupNameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [groupNameSort]
        
        let moc = CoreDataStack.context
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<GroupCD>
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}
