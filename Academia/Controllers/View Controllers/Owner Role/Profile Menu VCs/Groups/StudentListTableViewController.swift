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
        
        guard let students = studentGroup?.members else {
            print("ERROR: nil value for the studentGroup.members array in StudentListTableViewController.swift -> tablewView(tableView:, numberOfRowsInSection:) - line 38 ")
            return 0
        }

        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentListImageMenuCell", for: indexPath) as? StudentListImageMenuTableViewCell else { return UITableViewCell() }
        
        guard let students = studentGroup?.members else {
            print("ERROR: nil value for the studentGroup.members array in StudentListTableViewController.swift -> tablewView(tableView:, cellForRowAt:) - line 50 ")
            return UITableViewCell()
        }
        
        let student = students[indexPath.row]
        
        // Configure the cell...
        cell.adultStudent = student as? AdultStudent
        cell.kidStudent = student as? KidStudent

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
        guard let students = studentGroup?.members else {
            print("ERROR: nil value for the studentGroup.members array in StudentListTableViewController.swift -> tablewView(tableView:, didSelectRowAt:) - line 94 ")
            return
        }
        
        let student = students[indexPath.row]
        
        if student is AdultStudent {
            
            let adultStudent = student as! AdultStudent
            
            // pass data to destViewController
            destViewController.isOwner = false
            destViewController.isKid = false
            destViewController.username = adultStudent.username
            destViewController.password = adultStudent.password
            destViewController.firstName = adultStudent.firstName
            destViewController.lastName = adultStudent.lastName
            destViewController.parentGuardian = nil
            destViewController.profilePic = adultStudent.profilePic
            destViewController.birthdate = adultStudent.birthdate
            destViewController.beltLevel = adultStudent.belt.beltLevel
            destViewController.numberOfStripes = adultStudent.belt.numberOfStripes
            destViewController.addressLine1 = adultStudent.addressLine1
            destViewController.addressLine2 = adultStudent.addressLine2
            destViewController.city = adultStudent.city
            destViewController.state = adultStudent.state
            destViewController.zipCode = adultStudent.zipCode
            destViewController.phone = adultStudent.phone
            destViewController.mobile = adultStudent.mobile
            destViewController.email = adultStudent.email
            destViewController.emergencyContactName = adultStudent.emergencyContactName
            destViewController.emergencyContactRelationship = adultStudent.emergencyContactRelationship
            destViewController.emergencyContactPhone = adultStudent.emergencyContactPhone
            
        } else if student is KidStudent {
            
            let kidStudent = student as! KidStudent
            
            // pass data to destViewController
            destViewController.isOwner = false
            destViewController.isKid = true
            destViewController.username = kidStudent.username
            destViewController.password = kidStudent.password
            destViewController.firstName = kidStudent.firstName
            destViewController.lastName = kidStudent.lastName
            destViewController.parentGuardian = kidStudent.parentGuardian
            destViewController.profilePic = kidStudent.profilePic
            destViewController.birthdate = kidStudent.birthdate
            destViewController.beltLevel = kidStudent.belt.beltLevel
            destViewController.numberOfStripes = kidStudent.belt.numberOfStripes
            destViewController.addressLine1 = kidStudent.addressLine1
            destViewController.addressLine2 = kidStudent.addressLine2
            destViewController.city = kidStudent.city
            destViewController.state = kidStudent.state
            destViewController.zipCode = kidStudent.zipCode
            destViewController.phone = kidStudent.phone
            destViewController.mobile = kidStudent.mobile
            destViewController.email = kidStudent.email
            destViewController.emergencyContactName = kidStudent.emergencyContactName
            destViewController.emergencyContactRelationship = kidStudent.emergencyContactRelationship
            destViewController.emergencyContactPhone = kidStudent.emergencyContactPhone
            
        }
    }
    
}

//
//extension StudentListTableViewController {
//
//    func adultStudentCaster(studentGroup: Group?, indexPath: IndexPath) {
//
//        // unwrap a students object
//        guard let students = studentGroup?.members else {
//            print("ERROR: nil value for the studentGroup.members array in StudentListTableViewController.swift -> tablewView(tableView:, didSelectRowAt:) - line 94 ")
//            return
//        }
//
//
//        // pass data to destViewController
//        destViewController.isOwner = student.isOwner
//        destViewController.isKid = student.isKid
//        destViewController.username = student.username
//        destViewController.password = student.password
//        destViewController.firstName = student.firstName
//        destViewController.lastName = student.lastName
//        destViewController.parentGuardian = student.parentGuardian
//        destViewController.profilePic = student.profilePic
//        destViewController.birthdate = student.birthdate
//        destViewController.beltLevel = student.beltLevel
//        destViewController.numberOfStripes = student.numberOfStripes
//        destViewController.addressLine1 = student.addressLine1
//        destViewController.addressLine2 = student.addressLine2
//        destViewController.city = student.city
//        destViewController.state = student.state
//        destViewController.zipCode = student.zipCode
//        destViewController.phone = student.phone
//        destViewController.mobile = student.mobile
//        destViewController.email = student.email
//        destViewController.emergencyContactName = student.emergencyContactName
//        destViewController.emergencyContactRelationship = student.emergencyContactRelationship
//        destViewController.emergencyContactPhone = student.emergencyContactPhone
//    }
//
//    func kidStudentCaster(student: Any) -> KidStudent {
//
//    }
//}
