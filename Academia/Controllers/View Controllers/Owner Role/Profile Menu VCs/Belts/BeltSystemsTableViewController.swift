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
    
    let beltBuilder = BeltBuilder()
    
    var beltSystems: [InternationalStandardBJJBelts] = [.kidBelts, .adultBelts]
    

    // MARK: - ViewController LifeCycle Fucntions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed

        let nib = UINib(nibName: "GeneralMenuCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "generalMenuCell")
        
        self.navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
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
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        else if beltSystems[indexPath.item] == .kidBelts {
            let destViewController = storyboard?.instantiateViewController(withIdentifier: "toBeltsList") as! BeltsListTableViewController
            destViewController.beltSystem = beltSystems[indexPath.item]
            self.navigationController?.pushViewController(destViewController, animated: true)
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
}
