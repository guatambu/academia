//
//  ClassInstructorsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit
import CoreData

class ClassInstructorsTableViewController: UITableViewController, InstructorsDelegate {
    
    // MARK: - Properties
    
    // create a fetchedRequestController with predicate to grab the current OwnerInstructor and AdultInstructors objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsControllerOwnerInstructors: NSFetchedResultsController<OwnerCD>!
    var fetchedResultsControllerAdultInstructors: NSFetchedResultsController<StudentAdultCD>!
    
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
    
    @IBOutlet weak var welcomeInstructions1LabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructions2LabelOutlet: UILabel!
    
    // CoreData Properties
    var aulaCD: AulaCD?
    var aulaCDToEdit: AulaCD?
    
    var locationCD: LocationCD?
    
    var instructorsCD: [StudentAdultCD] = []
    var ownerInstructorsCD: [OwnerCD] = []
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        enterEditingMode(inEditingMode: inEditingMode)
        
        // create fetch request and initialize results
        initializeFetchedResultsController()
        
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
        
        print("ClassInstructorsTVC \naula name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // class update instrcutors info
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
            return fetchedResultsControllerOwnerInstructors.fetchedObjects?.count ?? 0
            
        } else if section == 1 {
            return fetchedResultsControllerAdultInstructors.fetchedObjects?.count ?? 0
            
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
            
            // set the isChosen to true if inEditingMode == true and current onwnerInstructor is present in aulaCDToEdit.ownerInstructor array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                    
                    // set the isChosen to true if inEditingMode == true and current ownerInstructor is present in aulaCDToEdit.ownerInstructor NSSet to display the ownerInstructor as chosen
                    
                    // CoreData version
                    guard let ownerInstructorsCDToEdit = aulaCDToEdit?.ownerInstructorAula else {
                        print("ERROR: nil value for aulaCDToEdit.ownerInstructorAula in ClassInstructorsTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 178")
                        return UITableViewCell()
                    }
                    
                    if ownerInstructorsCDToEdit.count != 0 && (ownerInstructorsCDToEdit.count - 1) >= indexPath.row {
                        
                        if ownerInstructorsCDToEdit.contains(ownerInstructorsCD[indexPath.row]) {
                            cell.isChosen = true
                        }
                    }
                }
            }
            
            guard let ownersCD = fetchedResultsControllerOwnerInstructors.fetchedObjects else { return UITableViewCell() }
            
            cell.ownerInstructorCD = ownersCD[indexPath.row]
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructorCell", for: indexPath) as! InstructorTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.adultMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                        
                    // CoreData version
                    guard let adultInstructorsCDToEdit = aulaCDToEdit?.adultStudentInstructorsAula else {
                        print("ERROR: nil value for aulaCDToEdit.adultInstructorAula in ClassInstructorsTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 221")
                        return UITableViewCell()
                    }
                    if adultInstructorsCDToEdit.count != 0 && (adultInstructorsCDToEdit.count - 1) >= indexPath.row {
                        
                        if adultInstructorsCDToEdit.contains(instructorsCD[indexPath.row]) {
                            cell.isChosen = true
                        }
                    }
                }
                
                guard let instructorsCD = fetchedResultsControllerAdultInstructors.fetchedObjects else { return UITableViewCell() }

                cell.instructorCD = instructorsCD[indexPath.row]
            
                return cell
                
            } else {
                
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toProfileComplete") as! OwnersStudentDetailViewController
        
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage(contentsOfFile: "")
        
        if indexPath.section == 0 {
            // kidStudent setup
            
            // CoreData version
            guard let ownerInstructorsCD = fetchedResultsControllerOwnerInstructors.fetchedObjects else {
                
                print("ERROR: nil value for kidMembersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 242.")
                return
            }
            
            let ownerInstructorsCDSet = NSSet(array: ownerInstructorsCD)
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let owners = ownerInstructorsCDSet.sortedArray(using: [nameSort])
            
            guard let ownerCD = owners[indexPath.row] as? OwnerCD else {
                print("ERROR: nil value for studentKidCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 252.")
                return
            }
            
            destViewController.ownerCD = ownerCD
            
        } else if indexPath.section == 1 {
            // adultStudent setup
            
            // CoreData version
            guard let adultInstructorsCD = fetchedResultsControllerAdultInstructors.fetchedObjects else {
                
                print("ERROR: nil value for adultMembersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 288.")
                return
            }
            
            let adultInstructorsCDSet = NSSet(array: adultInstructorsCD)
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultInstructorsCDSet.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for studentAdultCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 298.")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toClassGroups" {
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
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
            
            destViewController.locationCD = locationCD
            destViewController.ownerInstructorsCD = ownerInstructorsCD
            destViewController.instructorsCD = instructorsCD
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaCDToEdit = aulaCDToEdit
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassInstructorsTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        // CoreData GroupCD update info
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        // reset the instructor NSOrderedSets on aulaCDToEdit
        aulaCDToEdit.ownerInstructorAula = []
        aulaCDToEdit.adultStudentInstructorsAula = []

        // update to the latest version of the instructor arrays
        aulaCDToEdit.ownerInstructorAula = NSOrderedSet(array: ownerInstructorsCD)
        aulaCDToEdit.adultStudentInstructorsAula = NSOrderedSet(array: instructorsCD)

        // save to CoreData
        OwnerCDModelController.shared.saveToPersistentStorage()
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
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else {
            print("ERROR: nil value for aulaCDToEdit in ClassInstructorsTableViewController.swift -> aulaEditingSetup() - line 501")
            return
        }
        guard let instructorsCDToEdit = aulaCDToEdit.adultStudentInstructorsAula else {
            print("ERROR: nil value for aulaToEdit.adultStudentInstructorsAula in ClassInstructorsTableViewController.swift -> aulaEditingSetup() - line 505")
            return
        }
        guard let ownerInstructorsCDToEdit = aulaCDToEdit.ownerInstructorAula else {
            print("ERROR: nil value for aulaToEdit.ownerInstructorAula in ClassInstructorsTableViewController.swift -> aulaEditingSetup() - line 509")
            return
        }
        
        instructorsCD = Array(instructorsCDToEdit) as! [StudentAdultCD]
        ownerInstructorsCD = Array(ownerInstructorsCDToEdit) as! [OwnerCD]
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - NSFetchedREsultsController initializer method
extension ClassInstructorsTableViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsController() {
        
        // initialize ownerInstructor FetchedResultsController
        let requestOwners = NSFetchRequest<NSFetchRequestResult>(entityName: "OwnerCD")
        let ownerNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        
        requestOwners.predicate =  NSPredicate(format: "isInstructor == %@", NSNumber(value: true))
        requestOwners.sortDescriptors = [ownerNameSort]
        
        let moc = CoreDataStack.context
        
        fetchedResultsControllerOwnerInstructors = NSFetchedResultsController(fetchRequest: requestOwners, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<OwnerCD>
        fetchedResultsControllerOwnerInstructors.delegate = self
        
        do {
            try fetchedResultsControllerOwnerInstructors.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
        // initialize instructor FetchedResultsController
        let requestInstructors = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentAdultCD")
        let instructorNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        
        requestInstructors.predicate =  NSPredicate(format: "isInstructor == %@", NSNumber(value: true))
        requestInstructors.sortDescriptors = [instructorNameSort]
        
        fetchedResultsControllerAdultInstructors = NSFetchedResultsController(fetchRequest: requestInstructors, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<StudentAdultCD>
        fetchedResultsControllerAdultInstructors.delegate = self
        
        do {
            try fetchedResultsControllerAdultInstructors.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}

