//
//  StudentListTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var studentGroup: Group?

    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let kidMembers = studentGroup?.kidMembers else {
            print("ERROR: nil value for the studentGroup.kidMembers array in StudentListTableViewController.swift -> tablewView(tableView:, numberOfRowsInSection:) - line 38 ")
            return 0
        }
        
        guard let adultMembers = studentGroup?.adultMembers else {
            print("ERROR: nil value for the studentGroup.adultMembers array in StudentListTableViewController.swift -> tablewView(tableView:, numberOfRowsInSection:) - line 43 ")
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let avenirFont16 = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        tableView.sectionHeaderHeight = 40.0
        
        let label = UILabel()
        
        label.backgroundColor = UIColor.lightText
        label.tintColor = UIColor.white
        
        if section == 0 {
            label.attributedText = NSAttributedString(string: "  Kids", attributes: avenirFont16)
            
        } else if section == 1 {
            label.attributedText = NSAttributedString(string: "  Adults", attributes: avenirFont16)
        }
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 32
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentListImageMenuCell", for: indexPath) as? StudentListImageMenuTableViewCell else { return UITableViewCell() }
        
        guard let kidMembers = studentGroup?.kidMembers else {
            print("ERROR: nil value for the studentGroup.kidMembers array in StudentListTableViewController.swift -> tablewView(tableView:, cellForRowAt:) - line 60")
            return UITableViewCell()
        }
        
        guard let adultMembers = studentGroup?.adultMembers else {
            print("ERROR: nil value for the studentGroup.adultMembers array in StudentListTableViewController.swift -> tablewView(tableView:, cellForRowAt:) - line 64")
            return UITableViewCell()
        }
        
        let adultMember = adultMembers[indexPath.row]
        let kidMember = kidMembers[indexPath.row]
        
        // Configure the cell...
        cell.adultStudent = adultMember
        cell.kidStudent = kidMember

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    
    // *** TODO: research how to deal with sections and different type in each section or just acccount for it here ***
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnersStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toOwnersStudentDetail") as! OwnersStudentDetailViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // unwrap a students object
        guard let kidMembers = studentGroup?.kidMembers else {
            print("ERROR: nil value for the studentGroup.kidMembers array in StudentListTableViewController.swift -> tablewView(tableView:, cellForRowAt:) - line 110")
            return
        }
        
        guard let adultMembers = studentGroup?.adultMembers else {
            print("ERROR: nil value for the studentGroup.adultMembers array in StudentListTableViewController.swift -> tablewView(tableView:, cellForRowAt:) - line 115")
            return
        }
        
        let adultMember = adultMembers[indexPath.row]
        let kidMember = kidMembers[indexPath.row]
        
        if adultMembers.isEmpty == false {
            
            // pass data to destViewController
            destViewController.isOwner = false
            destViewController.isKid = false
            destViewController.username = adultMember.username
            destViewController.password = adultMember.password
            destViewController.firstName = adultMember.firstName
            destViewController.lastName = adultMember.lastName
            destViewController.parentGuardian = nil
            destViewController.profilePic = adultMember.profilePic
            destViewController.birthdate = adultMember.birthdate
            destViewController.beltLevel = adultMember.belt.beltLevel
            destViewController.numberOfStripes = adultMember.belt.numberOfStripes
            destViewController.addressLine1 = adultMember.addressLine1
            destViewController.addressLine2 = adultMember.addressLine2
            destViewController.city = adultMember.city
            destViewController.state = adultMember.state
            destViewController.zipCode = adultMember.zipCode
            destViewController.phone = adultMember.phone
            destViewController.mobile = adultMember.mobile
            destViewController.email = adultMember.email
            destViewController.emergencyContactName = adultMember.emergencyContactName
            destViewController.emergencyContactRelationship = adultMember.emergencyContactRelationship
            destViewController.emergencyContactPhone = adultMember.emergencyContactPhone
            
        } else if kidMembers.isEmpty == false {
            
            // pass data to destViewController
            destViewController.isOwner = false
            destViewController.isKid = true
            destViewController.username = kidMember.username
            destViewController.password = kidMember.password
            destViewController.firstName = kidMember.firstName
            destViewController.lastName = kidMember.lastName
            destViewController.parentGuardian = kidMember.parentGuardian
            destViewController.profilePic = kidMember.profilePic
            destViewController.birthdate = kidMember.birthdate
            destViewController.beltLevel = kidMember.belt.beltLevel
            destViewController.numberOfStripes = kidMember.belt.numberOfStripes
            destViewController.addressLine1 = kidMember.addressLine1
            destViewController.addressLine2 = kidMember.addressLine2
            destViewController.city = kidMember.city
            destViewController.state = kidMember.state
            destViewController.zipCode = kidMember.zipCode
            destViewController.phone = kidMember.phone
            destViewController.mobile = kidMember.mobile
            destViewController.email = kidMember.email
            destViewController.emergencyContactName = kidMember.emergencyContactName
            destViewController.emergencyContactRelationship = kidMember.emergencyContactRelationship
            destViewController.emergencyContactPhone = kidMember.emergencyContactPhone
            
        }
    }
    
}

