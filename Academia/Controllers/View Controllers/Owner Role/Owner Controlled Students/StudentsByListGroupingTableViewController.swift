//
//  StudentsByListGroupingTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentsByListGroupingTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var allGroups = [MockData.allStudents]
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ownerStudentGroupsMenuCell", for: indexPath) as? StudentGroupGeneralMenuTableViewCell else { return UITableViewCell() }
        
        let group = allGroups[indexPath.row]
        
        // Configure the cell...
        cell.title = group.name

        return cell
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
        }
    }


    // MARK: - Navigation
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // programmatically performing the group segue
        
        // instantiate the relevant storyboard
        let ownerStudentFlowView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerStudentFlowView.instantiateViewController(withIdentifier: "toStudentsList") as! StudentListTableViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem

    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toGroupOfStudents" {
            guard let destinationTVC = segue.destination as? StudentListTableViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            
            let studentGroup = allGroups[indexPath.row]
            
            // Pass the selected object to the new view controller.
            destinationTVC.studentGroup = studentGroup
        }
    }
}
