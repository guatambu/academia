//
//  GroupInfoDetailsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class GroupInfoDetailsTableViewController: UITableViewController {
    
    
    // create a fetchedRequestController with predicate to grab the current GroupCD's StudentKidCD and StudentAdultCD  objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsControllerKids: NSFetchedResultsController<StudentKidCD>!
    var fetchedResultsControllerAdults: NSFetchedResultsController<StudentAdultCD>!

    // MARK: - Properties
    var group: Group?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    
    // CoreData Properties
    var groupCD: GroupCD?
    var groupCDToEdit: GroupCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // create fetch request and initialize results
        initializeFetchedResultsControllerKids()
        initializeFetchedResultsControllerAdults()
        
        populateCompletedGroupInfo()
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func addStudentButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toStudentChoiceVC") as! StudentChoiceViewController
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
        
        // TODO: - follow the isOwnerAddingNewStudent workflow for CoreData implementaiton
        
        // set properties on destinationVC
        destViewController.isOwner = false
        destViewController.isOwnerAddingStudent = true
        destViewController.group = group
        destViewController.groupCD = groupCD
        
    }
    
    @IBAction func deleteGroupButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Group", message: "are you sure you want to delete this group?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive) { (alert) in
            
//            GroupModelController.shared.delete(group: GroupModelController.shared.groups[0])
            
            guard let groupCD = self.groupCD else {
                print("ERROR: nil value found for groupCD in GroupInfoDetailsViewController.swift -> deleteGroupButtonTapped(sender:) - line 92.")
                return
            }
            GroupCDModelController.shared.remove(group: groupCD)
            
            // programmatically performing the segue
            guard let viewControllers = self.navigationController?.viewControllers else { return }
            
            for viewController in viewControllers {
                
                if viewController is OwnerGroupListTableViewController{
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
            
            print("how many location we got now: \(GroupModelController.shared.groups.count)")
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
    
    // MARK: - editButtonTapped()
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toGroupNameAndDescription") as! GroupNameAndDescriptionViewController
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
        
        // set properties on destinationVC
        destViewController.inEditingMode = true
        
        groupToEdit = group
        destViewController.groupToEdit = groupToEdit
        destViewController.groupCDToEdit = groupCD
        
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
        
//        guard let group = group else {
//            print("ERROR: nil value for group property in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 184")
//            return 0
//        }
//
//        guard let kidMembers = group.kidMembers, let adultMembers = group.adultMembers else {
//
//            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 190")
//            return 0
//        }
        
        // CoreData versions
        guard let groupCD = groupCD else {
            
            print("ERROR: nil value for groupCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 208")
            return 0
        }
        
        guard let kidMembersCD = groupCD.kidMembers, let adultMembersCD = groupCD.adultMembers else {
            
            print("ERROR: nil value for either kidMembersCD and/or adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 214")
            return 0
        }

        if section == 0 {
//            return kidMembers.count
            return kidMembersCD.count
            
        } else if section == 1 {
//            return adultMembers.count
            return adultMembersCD.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let group = group else {
//            print("ERROR: nil value for group property in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 143")
//            return UITableViewCell()
//        }
//
//        guard let kidMembers = group.kidMembers, let adultMembers = group.adultMembers else {
//
//            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 149")
//            return UITableViewCell()
//        }
        
        // CoreData versions
        guard let groupCD = groupCD else {
            
            print("ERROR: nil value for groupCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 208")
            return UITableViewCell()
        }
        
        guard let kidMembersCD = groupCD.kidMembers, let adultMembersCD = groupCD.adultMembers else {
            
            print("ERROR: nil value for either kidMembersCD and/or adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 214")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "kidStudentCell", for: indexPath) as? KidGroupInfoDetailsTableViewCell else {
                
                return UITableViewCell()
            }
            
//            print("\(kidMembers[indexPath.row].firstName)")
//            print("\(String(describing: kidMembers[indexPath.row].profilePic?.scale))")
//            cell.kidStudent = kidMembers[indexPath.row]
//
//            return cell
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let kids = kidMembersCD.sortedArray(using: [nameSort])
            
            guard let studentKidCD = kids [indexPath.row] as? StudentKidCD else { return UITableViewCell() }
            
            print("\(String(describing: studentKidCD.firstName))")
            
            if let profilePicData = studentKidCD.profilePic, let profilePic = UIImage(data: profilePicData) {
                print("\(profilePic.scale)")
            }
            
            cell.studentKidCD = studentKidCD
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "adultStudentCell", for: indexPath) as? AdultGroupInfoDetailsTableViewCell else {
                
                return UITableViewCell()
            }
            
//            cell.adultStudent = adultMembers[indexPath.row]
            
            // CoreData Version
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultMembersCD.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults [indexPath.row] as? StudentAdultCD else { return UITableViewCell() }
            
            cell.studentAdultCD = studentAdultCD
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let group = group else {
//            print("ERROR: nil value for group property in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 173")
//            return
//        }
//
//        guard let kidMembers = group.kidMembers, let adultMembers = group.adultMembers else {
//
//            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 179")
//            return
//        }
        
        // CoreData versions
        guard let groupCD = groupCD else {
            
            print("ERROR: nil value for groupCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 208")
            return
        }
        
        guard let kidMembersCD = groupCD.kidMembers, let adultMembersCD = groupCD.adultMembers else {
            
            print("ERROR: nil value for either kidMembersCD and/or adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 214")
            return
        }
        
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
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if indexPath.section == 0 {
            // kidStudent setup
//            let kid = kidMembers[indexPath.row]
//
//            destViewController.kid = kid
            
            
            // CoreData Version
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let kids = kidMembersCD.sortedArray(using: [nameSort])
            
            guard let studentKidCD = kids[indexPath.row] as? StudentKidCD else {
                print("ERROR: nil value for either studentKidCD in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 214")
                return
            }
            
            destViewController.studentKidCD = studentKidCD
            
        } else if indexPath.section == 1 {
            
            // adultStudent setup
//            let adult = adultMembers[indexPath.row]
//            
//            destViewController.adult = adult
            
            // CoreData Version
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultMembersCD.sortedArray(using: [nameSort])

            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for either studentAdultCD in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 379")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
            
        }
    }
}


extension GroupInfoDetailsTableViewController {
    
    func populateCompletedGroupInfo() {
        
        guard let group = group else {
            print("there was a nil value in the group passed to GroupInfoDetailsTableViewController.swift -> populateCompletedGroupInfo() - line 256")
            return
        }
        // VC title
        groupNameLabelOutlet.text = group.name
        // active outlet
        if group.active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        lastChangedLabelOutlet.text = "\(group.dateEdited)"
        // payment program description
        groupDescriptionTextView.text = group.description
    }
}


// MARK: - NSFetchedREsultsController initializer method
extension GroupInfoDetailsTableViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsControllerKids() {
        
        let requestKids = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupCD")
        let groupSort = NSSortDescriptor(key: "kidMembers", ascending: true)
        let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
        requestKids.sortDescriptors = [groupSort, nameSort]
        
        let moc = CoreDataStack.context
        fetchedResultsControllerKids = NSFetchedResultsController(fetchRequest: requestKids, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<StudentKidCD>
        fetchedResultsControllerKids.delegate = self
        
        do {
            try fetchedResultsControllerKids.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsControllerKids: \(error)")
        }
    }
    
    func initializeFetchedResultsControllerAdults() {
        
        let requestAdults = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupCD")
        let groupSort = NSSortDescriptor(key: "adultMembers", ascending: true)
        let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
        requestAdults.sortDescriptors = [groupSort, nameSort]
        
        let moc = CoreDataStack.context
        fetchedResultsControllerAdults = NSFetchedResultsController(fetchRequest: requestAdults, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<StudentAdultCD>
        fetchedResultsControllerAdults.delegate = self
        
        do {
            try fetchedResultsControllerAdults.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsControllerAdults: \(error)")
        }
    }
}

// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and group profileVC
extension UIViewController {
    
    func returnToGroupInfo() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is GroupInfoDetailsTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}
