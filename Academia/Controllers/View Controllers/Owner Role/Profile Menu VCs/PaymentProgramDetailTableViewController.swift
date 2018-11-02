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
    @IBOutlet weak var signatureTypeMessageOutlet: UILabel!
    @IBOutlet weak var paymentDescriptionTextViewOutlet: UITextView!
    @IBOutlet weak var paymentAgreementTextViewOutlet: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Actions

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationItem.title = programNameTextFieldOutlet.text;
    }
    
    
    @IBAction func billingTypePickerWheelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func billingOptionsPickerWheelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func signatureTypePickerWheelButtonTapped(_ sender: UIButton) {
    }
    
    
    // MARK: - TableView override methods for dynamically resizing static cells per content
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
