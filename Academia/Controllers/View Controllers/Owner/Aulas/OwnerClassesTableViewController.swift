//
//  OwnerClassesTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class OwnerClassesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let adultClass1: Aula = Aula(active: true, className: "adult 1", daysOfTheWeek: [Aula.Weekdays.Monday, Aula.Weekdays.Wednesday, Aula.Weekdays.Friday], timeOfDay: [Aula.ClassTimes.nineteen], location: MockData.myLocation, groups: [MockData.allStudents], students: [MockData.adultA], instructor: [MockData.adultA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [MockData.adultA])
    let adultClass2: Aula = Aula(active: true, className: "adult 2", daysOfTheWeek: [Aula.Weekdays.Monday, Aula.Weekdays.Wednesday, Aula.Weekdays.Friday], timeOfDay: [Aula.ClassTimes.nineteen], location: MockData.myLocation, groups: [MockData.allStudents], students: [MockData.adultA], instructor: [MockData.adultA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [MockData.adultA])
    let kidClass1: Aula = Aula(active: true, className: "kid 1", daysOfTheWeek: [Aula.Weekdays.Tuesday, Aula.Weekdays.Thursday, Aula.Weekdays.Saturday], timeOfDay: [Aula.ClassTimes.eighteen], location: MockData.myLocation, groups: [MockData.allStudents], students: [MockData.adultA], instructor: [MockData.adultA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [MockData.adultA])
    let kidClass2: Aula = Aula(active: true, className: "kid 2", daysOfTheWeek: [Aula.Weekdays.Tuesday, Aula.Weekdays.Thursday, Aula.Weekdays.Saturday], timeOfDay: [Aula.ClassTimes.eighteen], location: MockData.myLocation, groups: [MockData.allStudents], students: [MockData.adultA], instructor: [MockData.adultA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [MockData.adultA])
    
    var classes = [Aula]()
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "GeneralMenuCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "generalMenuCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // may want to have sections with titles here
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        classes = [adultClass1, adultClass2, kidClass1, kidClass2]
        return classes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "generalMenuCell", for: indexPath) as? GeneralMenuTableViewCell else { return UITableViewCell() }

        classes = [adultClass1, adultClass2, kidClass1, kidClass2]
        
        let classTitle = classes[indexPath.row].className
        // Configure the cell...
        cell.title = classTitle
        
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

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "" {
            guard let destinationTVC = segue.destination as? ClassDetailTableViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let aula = classes[indexPath.row]
            
            // Pass the selected object to the new view controller.
            destinationTVC.aula = aula
        }
    }

}
