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
    var allStudents: [Any] = [MockData.adultA, MockData.kidA]
    
    
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

        return allStudents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentListImageMenuCell", for: indexPath) as? StudentListImageMenuTableViewCell else { return UITableViewCell() }
        
        let student = allStudents[indexPath.row]
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toStudentDetail" {
            guard let studentDetailTVC = segue.destination as? AddNewStudentTableViewController else { return }
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let student = allStudents[indexPath.row]
            
            studentDetailTVC.adultStudent = student as? AdultStudent
            
        } else if segue.identifier == "addNewStudent" {
            
        }
        // Pass the selected object to the new view controller.
    }
}
