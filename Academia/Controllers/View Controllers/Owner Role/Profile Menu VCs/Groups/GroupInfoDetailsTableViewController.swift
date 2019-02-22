//
//  GroupInfoDetailsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class GroupInfoDetailsTableViewController: UITableViewController {

    // MARK: - Properties
    var group: Group?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedGroupInfo()
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let group = group else {
            print("ERROR: found nil value when unwrapping group property in StudentListTableViewController.swift -> viewDidLoad() - line 37.")
            return
        }
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        title = group.name
        
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
        
        // set properties on destinationVC
        destViewController.isOwner = false
        destViewController.isOwnerAddingStudent = true
        destViewController.group = group
        
    }
    
    @IBAction func deleteGroupButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Group", message: "are you sure you want to delete this group?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive) { (alert) in
            
            GroupModelController.shared.delete(group: GroupModelController.shared.groups[0])
            
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
        
        guard let group = group else {
            print("ERROR: nil value for group property in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 124")
            return 0
        }
        
        guard let kidMembers = group.kidMembers, let adultMembers = group.adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 130")
            return 0
        }
        
        if section == 0 {
            return kidMembers.count
            
        } else if section == 1 {
            return adultMembers.count
            
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let group = group else {
            print("ERROR: nil value for group property in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 143")
            return UITableViewCell()
        }
        
        guard let kidMembers = group.kidMembers, let adultMembers = group.adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 149")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "kidStudentCell", for: indexPath) as? KidGroupInfoDetailsTableViewCell else {
                
                return UITableViewCell()
            }
            
            print("\(kidMembers[indexPath.row].firstName)")
            print("\(String(describing: kidMembers[indexPath.row].profilePic?.scale))")
            cell.kidStudent = kidMembers[indexPath.row]
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "adultStudentCell", for: indexPath) as? AdultGroupInfoDetailsTableViewCell else {
                
                return UITableViewCell()
            }
            
            cell.adultStudent = adultMembers[indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let group = group else {
            print("ERROR: nil value for group property in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 173")
            return
        }
        
        guard let kidMembers = group.kidMembers, let adultMembers = group.adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 179")
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
            let kid = kidMembers[indexPath.row]
            
            destViewController.isOwner = false
            destViewController.isKid = true
            destViewController.username = kid.username
            destViewController.password = kid.password
            destViewController.firstName = kid.firstName
            destViewController.lastName = kid.lastName
            destViewController.parentGuardian = kid.parentGuardian
            destViewController.profilePic = kid.profilePic
            destViewController.birthdate = kid.birthdate
            destViewController.beltLevel = kid.belt.beltLevel
            destViewController.numberOfStripes = kid.belt.numberOfStripes
            destViewController.addressLine1 = kid.addressLine1
            destViewController.addressLine2 = kid.addressLine2
            destViewController.city = kid.city
            destViewController.state = kid.state
            destViewController.zipCode = kid.zipCode
            destViewController.phone = kid.phone
            destViewController.mobile = kid.mobile
            destViewController.email = kid.email
            destViewController.emergencyContactName = kid.emergencyContactName
            destViewController.emergencyContactRelationship = kid.emergencyContactRelationship
            destViewController.emergencyContactPhone = kid.emergencyContactPhone
            
        } else if indexPath.section == 1 {
            // adultStudent setup
            let adult = adultMembers[indexPath.row]
            
            destViewController.isOwner = false
            destViewController.isKid = false
            destViewController.username = adult.username
            destViewController.password = adult.password
            destViewController.firstName = adult.firstName
            destViewController.lastName = adult.lastName
            destViewController.profilePic = adult.profilePic
            destViewController.birthdate = adult.birthdate
            destViewController.beltLevel = adult.belt.beltLevel
            destViewController.numberOfStripes = adult.belt.numberOfStripes
            destViewController.addressLine1 = adult.addressLine1
            destViewController.addressLine2 = adult.addressLine2
            destViewController.city = adult.city
            destViewController.state = adult.state
            destViewController.zipCode = adult.zipCode
            destViewController.phone = adult.phone
            destViewController.mobile = adult.mobile
            destViewController.email = adult.email
            destViewController.emergencyContactName = adult.emergencyContactName
            destViewController.emergencyContactRelationship = adult.emergencyContactRelationship
            destViewController.emergencyContactPhone = adult.emergencyContactPhone
            
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
        self.title = group.name
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
