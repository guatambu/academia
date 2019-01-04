//
//  ReviewAndCreateGroupTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 12/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ReviewAndCreateGroupTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    var kidMembers: [KidStudent]?
    var adultMembers: [AdultStudent]?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 68")
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addNewGroupStudentImageMenuCell", for: indexPath) as! AddNewStudentGroupImageMenuTableViewCell
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 89")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            cell.kidStudent = kidMembers[indexPath.row]
            
        } else if indexPath.section == 1 {
            cell.adultStudent = adultMembers[indexPath.row]
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            
            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 109")
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
