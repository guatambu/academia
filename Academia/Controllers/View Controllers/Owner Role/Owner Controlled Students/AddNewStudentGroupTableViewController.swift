//
//  AddNewStudentGroupTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 8/27/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddNewStudentGroupTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var statusMessageOutlet: UILabel!
    @IBOutlet weak var groupNameTextFieldOutlet: UITextField!
    
    // would this be better as a dictionary? a struct?
    // trying to think about properly organizing this data
    
    var studentsInGroup: [[Any]] = [MockData.adultStudents, MockData.kidStudents]
    var groupNamePlaceholderText = "group name"
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        let avenirFontGray = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        let avenirFontBlack = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                               NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFontGray
        
        self.tableView.sectionHeaderHeight = 48
        
        let nib = UINib(nibName: "ImageMenuCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "imageMenuCell")
        
        groupNameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(groupNamePlaceholderText)", attributes: avenirFontGray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func activeGroupSwitchTapped(_ sender: UISwitch) {
    }
    
    @IBAction func addStudentPickerWheelButtonTapped(_ sender: Any) {
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return studentsInGroup.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return studentsInGroup[section].count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitle = UILabel()
        sectionTitle.backgroundColor = UIColor.white
        
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.lightGray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        if section == 0 {
            sectionTitle.attributedText = NSAttributedString(string: "  Adults", attributes: avenirFont)
        } else if section == 1 {
            sectionTitle.attributedText = NSAttributedString(string: "  Kids", attributes: avenirFont)
        }
        
        return sectionTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addNewGroupStudentImageMenuCell", for: indexPath) as? AddNewStudentGroupImageMenuTableViewCell else { return UITableViewCell() }
        
        let student = studentsInGroup[indexPath.section][indexPath.row]
        
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
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
 

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toStudentDetailFromNewGroupTVC" {
            guard let studentDetailTVC = segue.destination as? StudentDetailTableViewController else { return }
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let student = studentsInGroup[indexPath.section][indexPath.row]
            
            // Pass the selected object to the new view controller.
            
            if student is AdultStudent {
                
                guard let adultStudent = student as? AdultStudent else { return }
                studentDetailTVC.adultStudent = adultStudent
                
            } else if student is KidStudent {
                
                guard let kidStudent = student as? KidStudent else { return }
                studentDetailTVC.kidStudent = kidStudent
                
            }
        }
    }
}
