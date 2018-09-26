//
//  StudentProfileDetailTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentProfileDetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var studentProfileMenuCell: UITableViewCell!
    @IBOutlet weak var beltSystemsMenuCell: UITableViewCell!
    @IBOutlet weak var studentPaymentDetailsMenuCell: UITableViewCell!
    @IBOutlet weak var socialNetworksMenuCell: UITableViewCell!
    @IBOutlet weak var tutorialsMenuCell: UITableViewCell!
    @IBOutlet weak var privacyInfoMenuCell: UITableViewCell!
    @IBOutlet weak var aboutAcademiaMenuCell: UITableViewCell!
    @IBOutlet weak var aboutAcademiaServicesMenuCell: UITableViewCell!
    
    
    //MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Actions
    
    @IBAction func myProfileButtonTapped(_ sender: UIButton) {
    }
    @IBAction func beltSystemsButtonTapped(_ sender: UIButton) {
    }
    @IBAction func studentPaymentDetailsButtonTapped(_ sender: UIButton) {
    }
    @IBAction func socialNetworksButtonTapped(_ sender: UIButton) {
    }
    @IBAction func tutorialsButtonTapped(_ sender: UIButton) {
    }
    @IBAction func privacyInfoButtonTapped(_ sender: UIButton) {
    }
    @IBAction func aboutAcademiaButtonTapped(_ sender: UIButton) {
    }
    @IBAction func aboutAcademiaServicesButtonTapped(_ sender: UIButton) {
    }
    
    
    
    
    
    //MARK: - TabelView Functions
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView {
            
            // instantiate the relevant storyboard
            let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toOwnerPaymentInfo") as! OwnerPaymentInfoTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "setUpPaymentPrograms" {
            
            // instantiate the relevant storyboard
            let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toOwnerPaymentPrograms") as! OwnerPaymentProgramsTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "locationsSetUp" {
            
            // instantiate the relevant storyboard
            let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toOwnerLocationsList") as! MyLocationsTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "messagingGroups" {
            
            // instantiate the relevant storyboard
            let ownerStudentsFlowView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerStudentsFlowView.instantiateViewController(withIdentifier: "toOwnerGroups") as! StudentsByListGroupingTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
        } else if OwnerModelController.shared.ownerOnboardingTasks[indexPath.item].name == "createClassSchedule" {
            
            // instantiate the relevant storyboard
            let ownerBaseCampFlowView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = ownerBaseCampFlowView.instantiateViewController(withIdentifier: "toOwnerClasses") as! OwnerClassesTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
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
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



}
