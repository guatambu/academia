//
//  AddStudentsToGroupTableViewController.swift
//  Academia
//
//  Created by Michel Guatambu Davis on 12/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class AddStudentsToGroupTableViewController: UITableViewController, GroupMembersDelegate {
    
    // MARK: - Properties
    
    // Mock Data
    var mockAdults = [MockData.adultA, MockData.adultB]
    var mockKids = [MockData.kidA, MockData.kidB]
    
    // create a fetchedRequestController with predicate to grab the current GroupCD objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsControllerKids: NSFetchedResultsController<StudentKidCD>!
    var fetchedResultsControllerAdults: NSFetchedResultsController<StudentAdultCD>!
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    var kidMembers: [KidStudent] = []
    var adultMembers: [AdultStudent] = []
    var kidMembersCD: [StudentKidCD] = []
    var adultMembersCD: [StudentAdultCD] = []
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    // welcome label outlets
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    // CoreData Properties
    var groupCD: GroupCD?
    var groupCDToEdit: GroupCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
        
        // create fetch request and initialize results
        initializeFetchedResultsControllers()
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Group update profile info
        updateGroupInfo()
        
        self.returnToGroupInfo()
        
        print("update... \nkidsMembers.count = \(String(describing: self.groupToEdit?.kidMembers?.count))\nadultMembers.count = \(String(describing: self.groupToEdit?.adultMembers?.count))")
        
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toReviewAndCreateGroup") as! ReviewAndCreateGroupTableViewController
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass data to destViewController
        destViewController.groupName = groupName
        destViewController.active = active
        destViewController.groupDescription = groupDescription
        destViewController.kidMembers = kidMembers
        destViewController.adultMembers = adultMembers
        
        destViewController.inEditingMode = inEditingMode
        destViewController.groupToEdit = groupToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateGroupInfo()
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
//            return mockKids.count
            
            guard let fetchedKidsCD =  fetchedResultsControllerKids.fetchedObjects?.count else {
                return 0
            }
            
            return fetchedKidsCD
            
        } else if section == 1 {
//            return mockAdults.count
            
            guard let fetchedAdultsCD = fetchedResultsControllerAdults.fetchedObjects?.count else {
                return 0
            }
            
            return fetchedAdultsCD
            
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kidStudentCell", for: indexPath) as! KidStudentTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.kidMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                    
                    guard let kidsToEdit = groupToEdit?.kidMembers else {
                        print("ERROR: nil value for groupToEdit in AddStudentsToGroupTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 166")
                        return UITableViewCell()
                    }
                    
                    if kidsToEdit.contains(mockKids[indexPath.row]) {
                        
                        cell.isChosen = true
                    }
                    
                    // CoreData version
                    guard let kidsToEditCD = groupCDToEdit?.kidMembers else {
                        print("ERROR: nil value for kidsToEditCE in AddStudentsToGroupTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 205")
                        return UITableViewCell()
                    }
                    
                    guard let fetchedKidCD = self.fetchedResultsControllerKids?.object(at: indexPath) else {
                        fatalError("Attempt to configure cell without a managed object")
                    }
                    
                    if kidsToEditCD.contains(fetchedKidCD) {
                        
                        cell.isChosen = true
                    }
                }
            }
            
            cell.studentKidCD = self.fetchedResultsControllerKids?.object(at: indexPath)
            
            cell.kidStudent = mockKids[indexPath.row]
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adultStudentCell", for: indexPath) as! AdultStudentTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.adultMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                    
                    guard let adultsToEdit = groupToEdit?.adultMembers else {
                        print("ERROR: nil value for groupToEdit.adultMembers in AddStudentsToGroupTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 191")
                        return UITableViewCell()
                    }
                    
                    if adultsToEdit.contains(mockAdults[indexPath.row]) {
                        
                        cell.isChosen = true
                    }
                    
                    // CoreData version
                    guard let adultsToEditCD = groupCDToEdit?.adultMembers else {
                        print("ERROR: nil value for adultsToEditCD in AddStudentsToGroupTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 205")
                        return UITableViewCell()
                    }
                    
                    guard let fetchedAdultCD = self.fetchedResultsControllerAdults?.object(at: indexPath) else {
                        fatalError("Attempt to configure cell without a managed object")
                    }
                    
                    if adultsToEditCD.contains(fetchedAdultCD) {
                        
                        cell.isChosen = true
                    }
                }
            }
            
            cell.studentAdultCD = self.fetchedResultsControllerAdults?.object(at: indexPath)
            
            cell.adultStudent = mockAdults[indexPath.row]
            
            return cell
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
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if indexPath.section == 0 {
            // kidStudent setup
//            let kid = mockKids[indexPath.row]
//
//            destViewController.isOwner = false
//            destViewController.isKid = true
//            destViewController.username = kid.username
//            destViewController.password = kid.password
//            destViewController.firstName = kid.firstName
//            destViewController.lastName = kid.lastName
//            destViewController.parentGuardian = kid.parentGuardian
//            destViewController.profilePic = kid.profilePic
//            destViewController.birthdate = kid.birthdate
//            destViewController.beltLevel = kid.belt.beltLevel
//            destViewController.numberOfStripes = kid.belt.numberOfStripes
//            destViewController.addressLine1 = kid.addressLine1
//            destViewController.addressLine2 = kid.addressLine2
//            destViewController.city = kid.city
//            destViewController.state = kid.state
//            destViewController.zipCode = kid.zipCode
//            destViewController.phone = kid.phone
//            destViewController.mobile = kid.mobile
//            destViewController.email = kid.email
//            destViewController.emergencyContactName = kid.emergencyContactName
//            destViewController.emergencyContactRelationship = kid.emergencyContactRelationship
//            destViewController.emergencyContactPhone = kid.emergencyContactPhone
            
            
            // CoreData version
            
            let kidMembersCDSet = NSSet(array: kidMembersCD)
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let kids = kidMembersCDSet.sortedArray(using: [nameSort])
            
            guard let studentKidCD = kids[indexPath.row] as? StudentKidCD else {
                print("ERROR: nil value for studentKidCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 252.")
                return
            }
            
            destViewController.studentKidCD = studentKidCD
            
        } else if indexPath.section == 1 {
            // adultStudent setup
//            let adult = mockAdults[indexPath.row]
//
//            destViewController.isOwner = false
//            destViewController.isKid = false
//            destViewController.username = adult.username
//            destViewController.password = adult.password
//            destViewController.firstName = adult.firstName
//            destViewController.lastName = adult.lastName
//            destViewController.profilePic = adult.profilePic
//            destViewController.birthdate = adult.birthdate
//            destViewController.beltLevel = adult.belt.beltLevel
//            destViewController.numberOfStripes = adult.belt.numberOfStripes
//            destViewController.addressLine1 = adult.addressLine1
//            destViewController.addressLine2 = adult.addressLine2
//            destViewController.city = adult.city
//            destViewController.state = adult.state
//            destViewController.zipCode = adult.zipCode
//            destViewController.phone = adult.phone
//            destViewController.mobile = adult.mobile
//            destViewController.email = adult.email
//            destViewController.emergencyContactName = adult.emergencyContactName
//            destViewController.emergencyContactRelationship = adult.emergencyContactRelationship
//            destViewController.emergencyContactPhone = adult.emergencyContactPhone
            
            
            // CoreData version
    
            let adultMembersCDSet = NSSet(array: adultMembersCD)
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultMembersCDSet.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for studentAdultCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 298.")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
        }
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension AddStudentsToGroupTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateGroupInfo() {
        guard let group = groupToEdit else { return }
        
        // group update info
        GroupModelController.shared.update(group: group, active: nil, name: nil, description: nil, kidMembers: kidMembers, adultMembers: adultMembers, kidStudent: nil, adultStudent: nil)
        print("how many members in the group: \(GroupModelController.shared.groups.count)")
        
        
        // CoreData GroupCD update info
        guard let groupCDToEdit = groupCDToEdit else { return }
        
        guard let kidsExisting = groupCDToEdit.kidMembers else { return }
        
        guard let adultsExisting = groupCDToEdit.adultMembers else { return }
        
        // here we want to loop through the membersCD arrays and check the existing corresponding group members NSSet to see if it contains the current iterated member object and if it does NOT, then add that iterated member object to the group members NSSet
        
        for kid in kidMembersCD {
            // check to see if current kidMembersCD actually has kid, this should not fail
            let containsKid =  kidsExisting.contains(kid)
            // if the kid is not present, add it to the groupCDToEdit object
            if containsKid == false {
                
                groupCDToEdit.addToKidMembers(kid)
            }
        }
        
        for adult in adultMembersCD {
            
            // check to see if current adultMembersCD actually has adult, this should not fail
            let containsAdult =  adultsExisting.contains(adult) 
            // if the adult is not present, add it to the groupCDToEdit object
            if containsAdult == false {
                
                groupCDToEdit.addToAdultMembers(adult)
            }
        }
        // save to CoreData
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            groupEditingSetup()
            
        } else {
            nextButtonOutlet.isHidden = false
            nextButtonOutlet.isEnabled = true
        }
        
        print("AddStudentsToGroupTVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func groupEditingSetup() {
        
        guard let groupToEdit = groupToEdit else {
            return
        }
        
        welcomeLabelOutlet.text = "Group: \(groupToEdit.name)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        nextButtonOutlet.isHidden = true
        nextButtonOutlet.isEnabled = false
        
        // sync up the grouptoEdit students with this TVC's properties when inEditingMode == true
        kidMembers = groupToEdit.kidMembers ?? []
        adultMembers = groupToEdit.adultMembers ?? []
    }
}


// MARK: - NSFetchedREsultsController initializer method
extension AddStudentsToGroupTableViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsControllers() {
        
        // instantiate the macro managed object context
        let moc = CoreDataStack.context
        
        // fetch results for all StudentKidCD type students
        let requestKids = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentKidCD")
        let kidNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        requestKids.sortDescriptors = [kidNameSort]
        
        fetchedResultsControllerKids = NSFetchedResultsController(fetchRequest: requestKids, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<StudentKidCD>
        fetchedResultsControllerKids.delegate = self
        
        do {
            try fetchedResultsControllerKids.performFetch()
        } catch {
            fatalError("Failed to initialize StudentKidCD FetchedResultsController: \(error)")
        }
        
        // fetch results for all StudentAdultCD type students
        let requestAdults = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentAdultCD")
        let adultNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        requestAdults.sortDescriptors = [adultNameSort]
        
        fetchedResultsControllerAdults = NSFetchedResultsController(fetchRequest: requestAdults, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<StudentAdultCD>
        fetchedResultsControllerAdults.delegate = self
        
        do {
            try fetchedResultsControllerAdults.performFetch()
        } catch {
            fatalError("Failed to initialize StudentADultCD FetchedResultsController: \(error)")
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
