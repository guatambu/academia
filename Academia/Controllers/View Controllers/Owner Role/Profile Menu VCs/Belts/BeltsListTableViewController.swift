//
//  BeltsListTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltsListTableViewController: UITableViewController {

    // MARK: - Properties
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var beltDisclaimerLabelOutlet: UILabel!
    @IBOutlet weak var beltDisclaimerViewOutlet: UIView!
    
    var beltSystem: InternationalStandardBJJBelts?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        beltDisclaimerLabelOutlet.text = InternationalStandardBJJBelts.beltDisclaimer.rawValue
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = 120
        
        guard let beltSystem = beltSystem?.rawValue else { return }
        self.title = beltSystem
        
        let nib = UINib(nibName: "BeltCellNib", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "beltCellNib")
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let beltSystem = beltSystem else { return 0 }
        if beltSystem == .kidBelts {
            return beltBuilder.kidsBelts.count
        } else {
            return beltBuilder.adultBelts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "beltCellNib", for: indexPath) as? BeltTableViewCell else { return UITableViewCell() }
        
        guard let beltSystem = beltSystem else { return UITableViewCell() }
        
        if beltSystem == .kidBelts {

            let belt = beltBuilder.kidsBelts[indexPath.row]
            
            cell.belt = belt
            
            return cell
            
        } else if beltSystem == .adultBelts {
                
            let belt = beltBuilder.adultBelts[indexPath.row]
            
            cell.belt = belt
            
            return cell
            
        }
        return UITableViewCell()
    }
}

