//
//  StudentHomeTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentHomeTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var adultStudent: AdultStudent?
    var kidStudent = MockData.kidA
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        tableView.estimatedRowHeight = 80
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "OnBoardingDashboardCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ownerHomeDashboardCell")
        
        self.tabBarController?.selectedIndex = 1
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AdultStudentModelController.shared.adultStudentOnboardingTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ownerHomeDashboardCell", for: indexPath) as? OwnerDashboardTableViewCell else { return UITableViewCell() }
        
        if adultStudent != nil {
            let adultStudentTask = AdultStudentModelController.shared.adultStudentOnboardingTasks[indexPath.row]
            cell.onBoardTask = adultStudentTask
        } else if kidStudent != nil  {
            let kidStudentTask = KidStudentModelController.shared.kidStudentOnboardingTasks[indexPath.row]
            cell.onBoardTask = kidStudentTask
        }
        
        // Configure the cell... via updateViews() practice
        
        return cell
    }
    
    //
    //
    // need to update the following for the adult student experience
    //
    //
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if AdultStudentModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "setUpPaymentPrograms" {
            
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
            
            print(kidStudent.firstName)
            
            destViewController.adultStudent = adultStudent
            destViewController.kidStudent = kidStudent
            
        } else if AdultStudentModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "messagingGroups" {
            
            // instantiate the relevant storyboard
            let ownerStudentsFlowView: UIStoryboard = UIStoryboard(name: "StudentBaseCampFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerStudentsFlowView.instantiateViewController(withIdentifier: "toOwnerGroups") as! StudentsByListGroupingTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.navigationBar.tintColor = UIColor(red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
            
        } else if AdultStudentModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "viewClassSchedule" {
            
            // instantiate the relevant storyboard
            let studentBaseCampFlowView: UIStoryboard = UIStoryboard(name: "StudentBaseCampFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = studentBaseCampFlowView.instantiateViewController(withIdentifier: "toStudentClasses") as! StudentClassesTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.navigationBar.tintColor = UIColor(red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
            
        } else if AdultStudentModelController.shared.adultStudentOnboardingTasks[indexPath.item].name == "learnTheBeltSystems" {
            
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
