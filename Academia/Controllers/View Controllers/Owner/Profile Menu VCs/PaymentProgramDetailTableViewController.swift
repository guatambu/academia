//
//  PaymentProgramDetailTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//


// HEY!!!!


// !!!!!!!!!  remember to disable scrolling in scroll view in attributes inspector for the text views where the program description and agreement are housed this way the full text will be displayed and the textView will dynamically size accordingly!!!!!!!


// HO!!!!



import UIKit

class PaymentProgramDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var saveEditBarButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var statusMessageOutlet: UILabel!
    @IBOutlet weak var programNameTextFieldOutlet: UITextField!
    @IBOutlet weak var switchButtonOutlet: UISwitch!
    @IBOutlet weak var billingTypeMessageOutlet: UILabel!
    @IBOutlet weak var billingOptionsMessageOutlet: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
