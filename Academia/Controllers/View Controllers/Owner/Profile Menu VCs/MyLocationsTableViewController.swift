//
//  MyLocationsTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class MyLocationsTableViewController: UITableViewController {

    var myLocation1 = Location(active: true, dateCreated: Date(), dateEdited: Date(), profilePic: #imageLiteral(resourceName: "location1.jpg"), locationName: "my location 1", streetAddress: "1267 the spot blvd.", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social: nil)
    var myLocation2 = Location(active: true, dateCreated: Date(), dateEdited: Date(), profilePic: #imageLiteral(resourceName: "location2.jpg"), locationName: "my location 2", streetAddress: "1267 the spot blvd.", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social: nil)
    var locations = [Location]()
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        // register required cell nibs
        let nibGenMenu = UINib(nibName: "GeneralMenuCell", bundle: nil)
        self.tableView.register(nibGenMenu, forCellReuseIdentifier: "generalMenuCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        locations = [myLocation1, myLocation2]
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "generalMenuCell", for: indexPath) as? GeneralMenuTableViewCell else { return UITableViewCell() }
        
        locations = [myLocation1, myLocation2]
        
        let locationTitle = locations[indexPath.row].locationName
        
        // Configure the cell...
        cell.title = locationTitle

        return cell
    }

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        // pass any object as parameter, i.e. the tapped row
//        performSegue(withIdentifier: "toLocationDetail", sender: indexPath.row)
//    }
    
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
        
        locations = [myLocation1, myLocation2]
        
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toLocationDetail" {
            guard let destinationTVC = segue.destination as? MyLocationsDetailTableViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let location = locations[indexPath.row]
            
            // Pass the selected object to the new view controller.
            destinationTVC.location = location
        }
    }
}
