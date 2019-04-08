//
//  StudentHomeTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//


// TODO:
    // maybe want to set up where a parent or family member can manage all of the family in one account, meaning that the studentController sources of truth may have more than one entry... might not be for first time launch.  maybe a later feature.

import UIKit

class StudentHomeTableViewController: UITableViewController, ActiveStudentDelegate {
    
    // MARK: - Properties
    
    var activeStudent: UUID?
    var isKid: Bool = false
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("isKid: \(String(describing: isKid))")
        
        let nib = UINib(nibName: "StudentDashboardCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "studentDashboardCell")
        
        self.tabBarController?.selectedIndex = 1
        
        
        // TODO: - get active student user via UUID from ActiveUserModelController
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if isKid {
            return StudentKidCDModelController.shared.kidStudentOnboardingTasks.count
        } else {
            
            return StudentAdultCDModelController.shared.adultStudentOnboardingTasks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentDashboardCell", for: indexPath) as? StudentDashboardTableViewCell else { return UITableViewCell() }
        
        if isKid {
            let adultStudentTask = StudentAdultCDModelController.shared.adultStudentOnboardingTasks[indexPath.row]
            cell.onBoardTask = adultStudentTask
        } else  {
            let kidStudentTask = StudentKidCDModelController.shared.kidStudentOnboardingTasks[indexPath.row]
            cell.onBoardTask = kidStudentTask
        }
        
        // Configure the cell... via updateViews() practice
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if StudentAdultCDModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "setUpPaymentPrograms" {
            
            // instantiate the relevant storyboard
            let studentProfileFlowView: UIStoryboard = UIStoryboard(name: "StudentProfileFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = studentProfileFlowView.instantiateViewController(withIdentifier: "toStudentPayment") as! StudentPaymentTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.navigationBar.tintColor = UIColor(red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
            
//            destViewController.activeStudentUser = activeStudentUser
            
        } else if StudentAdultCDModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "messagingGroups" {
            
            // instantiate the relevant storyboard
            let ownerStudentsFlowView: UIStoryboard = UIStoryboard(name: "StudentBaseCampFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerStudentsFlowView.instantiateViewController(withIdentifier: "toStudentMessagesList") as! StudentMessagesListTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.navigationBar.tintColor = UIColor(red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
            
        } else if StudentAdultCDModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "viewClassSchedule" {
            
            let ownerBaseCampFlowView: UIStoryboard = UIStoryboard(name: "StudentBaseCampFlow", bundle: nil)
            // instantiate the desired TableViewController on relevant storyboard
            let destViewController = ownerBaseCampFlowView.instantiateViewController(withIdentifier: "toStudentClasses") as! StudentClassesTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.navigationBar.tintColor = UIColor(red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
            
        } else if StudentAdultCDModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "learnTheBeltSystems" {
            
            // instantiate the relevant storyboard
            let ownerBeltSystemFlowView: UIStoryboard = UIStoryboard(name: "OwnerBeltSystemFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerBeltSystemFlowView.instantiateViewController(withIdentifier: "UITableViewController-TZb-1N-cMc") as! BeltSystemsTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.navigationBar.tintColor = UIColor(red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
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
            // add the selected Onboarding task to
            /*
             OwnerModelController.shared.deletedOnboardingTasks
             */
            // delete the OnboardingTask from the source of truth
            /* delete OwnerModelController.shared.ownerOnboardingTasks[indexPath.row]
             */
            
        }
    }
}
