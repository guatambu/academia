//
//  BeltSystemsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltSystemsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var beltSystems: [InternationalStandardBJJBelts] = [.kidBelts, .adultBelts]
    

    // MARK: - ViewController LifeCycle Fucntions
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "GeneralMenuCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "generalMenuCell")
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1.0)
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
            destViewController.beltSystem = beltSystems[indexPath.item]
            self.navigationController?.pushViewController(destViewController, animated: true)
        }
        else if beltSystems[indexPath.item] == .kidBelts {
            let destViewController = storyboard?.instantiateViewController(withIdentifier: "toBeltsList") as! BeltsListTableViewController
            destViewController.beltSystem = beltSystems[indexPath.item]
            self.navigationController?.pushViewController(destViewController, animated: true)
        }
    }
}
