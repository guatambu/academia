//
//  OwnerHomeTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/22/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class OwnerHomeTableViewController: UITableViewController, ActiveOwnerDelegate {
   
    // MARK: - Properties
    
    var activeOwner: UUID?
    
    let beltBuilder = BeltBuilder()
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "OwnerOnBoardingDashboardCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ownerHomeDashboardCell")
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return OwnerModelController.shared.ownerOnboardingTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ownerHomeDashboardCell", for: indexPath) as? OwnerDashboardTableViewCell else { return UITableViewCell() }

        let task = OwnerCDModelController.shared.ownerOnboardingTasks[indexPath.row]
        
        cell.onBoardTask = task
        
        
        // Configure the cell... via updateViews() practice

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "startGettingPaid" {
            
            // instantiate the relevant storyboard
            let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
             // instantiate the desired TableViewController on relevant storyboard
            let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toOwnerPaymentInfo") as! OwnerPaymentInfoTableViewController
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
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "setUpPaymentPrograms" {
            
            // instantiate the relevant storyboard
            let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
            // instantiate the desired TableViewController on relevant storyboard
            let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toOwnerPaymentPrograms") as! OwnerPaymentProgramsTableViewController
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
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "locationsSetUp" {
            
            // instantiate the relevant storyboard
            let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
            // instantiate the desired TableViewController on relevant storyboard
            let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toOwnerLocationsList") as! MyLocationsTableViewController
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
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "messagingGroups" {
            
            // instantiate the relevant storyboard
            let ownerStudentsFlowView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
            // instantiate the desired TableViewController on relevant storyboard
            let destViewController = ownerStudentsFlowView.instantiateViewController(withIdentifier: "toOwnerGroupList") as! OwnerGroupListTableViewController
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
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "createClassSchedule" {
            
            // instantiate the relevant storyboard
            let ownerBaseCampFlowView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
            // instantiate the desired TableViewController on relevant storyboard
            let destViewController = ownerBaseCampFlowView.instantiateViewController(withIdentifier: "toOwnerClassList") as! OwnerClassListTableViewController
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
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "reviewBeltSystems" {
            
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
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */
}
