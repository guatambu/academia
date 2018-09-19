//
//  BeltSystemsTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltSystemsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var beltSystems: [InternationalStandardBJJBelts] = [.kidBelts, .adultBelts]
    

    // MARK: - ViewController LifeCycle Fucntions
    
    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "GeneralMenuCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "generalMenuCell")

        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
            

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }



    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beltSystems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "generalMenuCell", for: indexPath) as? GeneralMenuTableViewCell {
            
            let myCell = beltSystems[indexPath.row]
            
            if myCell == .adultBelts {
                cell.cellTitleOutlet.text = myCell.rawValue
                print("the following should read 'Adult Belts': \(myCell.rawValue)")
            } else if myCell == .kidBelts {
                cell.cellTitleOutlet.text = myCell.rawValue
                print("the following should read 'Kid Belts': \(myCell.rawValue)")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if beltSystems[indexPath.item] == .adultBelts {
            let destViewController = storyboard?.instantiateViewController(withIdentifier: "toBeltsList") as! BeltsListTableViewController
            destViewController.isKidsBelts = beltSystems[indexPath.item]
            self.navigationController?.pushViewController(destViewController, animated: true)
        }
        else if beltSystems[indexPath.item] == .kidBelts {
            let destViewController = storyboard?.instantiateViewController(withIdentifier: "toBeltsList") as! BeltsListTableViewController
            destViewController.isKidsBelts = beltSystems[indexPath.item]
            self.navigationController?.pushViewController(destViewController, animated: true)
            
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
            
        guard let destinationTVC = segue.destination as? BeltsListTableViewController, let beltsTypeIndex = tableView.indexPathForSelectedRow?.row else { return }
        
        print("segue info: \(beltSystems[beltsTypeIndex].rawValue)")
        
        // Pass the selected object to the new view controller.
        destinationTVC.isKidsBelts = beltSystems[beltsTypeIndex]
        
    }
}
