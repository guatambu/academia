//
//  PaymentProgramBillingDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgramBillingDetailsViewController: UIViewController {

    // MARK: - Properties
    
    var paymentProgramName: String?
    var active: Bool?
    var programDescription: String?
    var billingOptions: String = ""
    var billingType: String = ""
    var signatureType: String = ""
    
    var inEditingMode: Bool?
    var paymentProgramToEdit: PaymentProgram?
    
    let beltBuilder = BeltBuilder()
    
    // payment program info outlets
    @IBOutlet weak var paymentProgramNameLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    // program description textView
    @IBOutlet weak var programDescriptionTextView: UITextView!
    // billing details outlets
    @IBOutlet weak var billingOptionsLabelOutlet: UILabel!
    @IBOutlet weak var billingTypeLabelOutlet: UILabel!
    @IBOutlet weak var signatureTypeLabelOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        populateCompletedProfileInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //populateCompletedProfileInfo()
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        if programNameTextField.text != "" {
            
            updatePaymentProgramInfo()
            
            self.returnToPaymentProgramInfo()
            
            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        }
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        print("to address segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toPaymentProgramBillingDetails") as! PaymentProgramBillingDetailsViewController
        
        // run check to see is there is a paymentProgramName
        guard programNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.paymentProgramName = paymentProgramName
        destViewController.active = active
        destViewController.programDescription = programDescription
        
        destViewController.inEditingMode = inEditingMode
        destViewController.paymentProgramToEdit = paymentProgramToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in onboarding
        updatePaymentProgramInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension PaymentProgramBillingDetailsViewController {
    
    // Update Function for case where want to update user info without a segue
    func updatePaymentProgramInfo() {
        guard let paymentProgram = paymentProgramToEdit else { return }
        // payment program update info
        if programNameTextField.text != "" {
            PaymentProgramModelController.shared.update(paymentProgram: paymentProgram, programName: paymentProgramName, active: active, paymentDescription: programDescription, billingType: nil, billingOptions: nil, signatureType: nil, paymentAgreement: nil)
            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            paymentProgramEditingSetup()
        }
        
        print("PaymentProgramNameAndDescriptionVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func paymentProgramEditingSetup() {
        
        guard let paymentProgramToEdit = paymentProgramToEdit else {
            return
        }
        
        welcomeLabelOutlet.text = "Program: \(paymentProgramToEdit.programName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
        
        programDescriptionTextView.text = paymentProgramToEdit.paymentDescription
        programNameTextField.text = paymentProgramToEdit.programName
    }
}



}
