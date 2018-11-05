//
//  StudentPaymentTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentPaymentTableViewController: UITableViewController {
    
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
    
    var adultStudent: AdultStudent?
    var kidStudent: KidStudent?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        if let adultStudent = adultStudent {
            self.title = adultStudent.paymentProgram?.programName
        } else if let kidStudent = kidStudent {
            self.title = kidStudent.paymentProgram?.programName
        }
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
