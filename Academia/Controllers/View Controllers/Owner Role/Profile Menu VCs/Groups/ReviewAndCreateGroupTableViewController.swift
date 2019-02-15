//
//  ReviewAndCreateGroupTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ReviewAndCreateGroupTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var groupName: String?
    var active: Bool?
    var groupDescription: String?
    var kidMembers: [KidStudent]?
    var adultMembers: [AdultStudent]?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    @IBOutlet weak var studentAdvisoryLabelOutlet: UILabel!

    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        populateCompletedGroupInfo()
        
        // run checks to produce advisory info to user regarding student types selected to a group
        if let kidMembers = kidMembers, let adultMembers = adultMembers, kidMembers.isEmpty && adultMembers.isEmpty {
            
            studentAdvisoryLabelOutlet.isHidden = false
            studentAdvisoryLabelOutlet.text = "no students added to group"
        
        } else if let kidMembers = kidMembers, kidMembers.isEmpty {
            
            studentAdvisoryLabelOutlet.isHidden = false
            studentAdvisoryLabelOutlet.text = "no kids added to group"
            
        } else if let adultMembers = adultMembers, adultMembers.isEmpty {
            
            studentAdvisoryLabelOutlet.isHidden = false
            studentAdvisoryLabelOutlet.text = "no adults added to group"
            
        } else {
            
            studentAdvisoryLabelOutlet.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Actions
    
    @IBAction func createGroupButtonTapped(_ sender: DesignableButton) {
            
        // create the new location in the LocationModelController source of truth
        createGroup()
        
        // programmatic segue back to the MyLocations TVC to view the current locations
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is OwnerGroupListTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
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
        
        return 32
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 133")
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
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 154")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewKidStudentCell", for: indexPath) as! ReviewKidStudentTableViewCell
            
            cell.kidStudent = kidMembers[indexPath.row]
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewAdultStudentCell", for: indexPath) as! ReviewAdultStudentTableViewCell
            
            if adultMembers.isEmpty {
                cell.adultStudent = nil
            } else {
                cell.adultStudent = adultMembers[indexPath.row]
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 186")
            return
        }
        
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


// MARK: - Helper Methods -> populateCompletedGroupInfo(), createGroup()
extension ReviewAndCreateGroupTableViewController {
    
    func populateCompletedGroupInfo() {
        
        guard let groupName = groupName, let groupDescription = groupDescription else {
                print("there was a nil value in the groupName and/or groupDescription passed to ReviewAndCreateGroupTVC.swift -> populateCompletedGroupInfo() - line 267")
                return
        }
        // name outlet
        groupNameLabelOutlet.text = groupName
        // active outlet
        if active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        lastChangedLabelOutlet.text = "\(Date())"
        // payment program description
        groupDescriptionTextView.text = "\(groupDescription)"
    }
    
    func createGroup() {
        
        guard let groupName = groupName else { print("fail groupName"); return }
        guard let active = active else { print("fail active");  return }
        guard let groupDescription = groupDescription else { print("fail groupDescription"); return }
        guard let kidMembers = kidMembers else { print("fail kidMembers"); return }
        guard let adultMembers = adultMembers else { print("fail adultMembers"); return }
        
        GroupModelController.shared.add(active: active, name: groupName, description: groupDescription, kidMembers: kidMembers, adultMembers: adultMembers)
    }
}
