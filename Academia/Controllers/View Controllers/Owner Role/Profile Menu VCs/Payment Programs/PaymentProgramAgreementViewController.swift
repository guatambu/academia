//
//  PaymentProgramAgreementViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgramAgreementViewController: UIViewController {

    // MARK: - Properties
    
    var paymentProgramName: String?
    var active: Bool?
    var programDescription: String?
    var programAgreement: String?
    var billingTypes: [Billing.BillingType]?
    var billingDates: [Billing.BillingDate]?
    var signatureTypes: [Billing.BillingSignature]?
    
    var inEditingMode: Bool?
    var paymentProgramToEdit: PaymentProgram?
    
    let beltBuilder = BeltBuilder()
    
    // welcome label outlets
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    // payment program info outlets
    @IBOutlet weak var paymentProgramAgreementLabelOutlet: UILabel!
    // program agreement textView
    @IBOutlet weak var programAgreementTextView: UITextView!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        programAgreementTextView.delegate = self
        
        nextButtonOutlet.isEnabled = true
        nextButtonOutlet.isHidden = false
        
        guard let paymentProgramName = paymentProgramName, let active = active, let programDescription = programDescription else {
            print("no paymentProgramName, active, or programDescription passed to: PaymentProgramBillingDetailsVC -> viewDidLoad() - line 53")
            return
        }
        print("program name: \(paymentProgramName) \nactive: \(active) \ndescription: \(programDescription)")
        
        guard let billingTypes = billingTypes, let billingDates = billingDates, let signatureTypes = signatureTypes else {
            print("no billingTypes, billingDates, or signatureTypes passed to: PaymentProgramAgreementVC -> viewDidLoad() - line 59")
            return
        }
        print(billingTypes)
        print(billingDates)
        print(signatureTypes)
        
        //populateCompletedProfileInfo()
    }
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        if programAgreementTextView.text != "" {
            
            updatePaymentProgramInfo()
            
            self.returnToPaymentProgramInfo()
            
            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        }
        inEditingMode = false
    }
    
    @IBAction func tapAnywhereToDismissKeyboardTapped(_ sender: Any) {
        view.endEditing(true)
        programAgreementTextView.resignFirstResponder()
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        print("to review and create program segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkflow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toReviewAndCreatePaymentProgram") as! ReviewAndCreatePaymentProgramViewController
        
        // run check to see is there is a paymentProgramName
        guard programAgreementTextView.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        programAgreement = programAgreementTextView.text
        
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
        destViewController.billingDates = billingDates
        destViewController.billingTypes = billingTypes
        destViewController.signatureTypes = signatureTypes
        destViewController.programAgreement = programAgreement
        
        destViewController.inEditingMode = inEditingMode
        destViewController.paymentProgramToEdit = paymentProgramToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updatePaymentProgramInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension PaymentProgramAgreementViewController {
    
    // Update Function for case where want to update user info without a segue
    func updatePaymentProgramInfo() {
        guard let paymentProgram = paymentProgramToEdit else { return }
        // payment program update info
        if programAgreementTextView.text != "" {
            PaymentProgramModelController.shared.update(paymentProgram: paymentProgram, programName: nil, active: nil, paymentDescription: nil, billingTypes: nil, billingDates: nil, signatureTypes: nil, paymentAgreement: programAgreementTextView.text)
            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].paymentAgreement)")
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            paymentProgramEditingSetup()
        }
        
        nextButtonOutlet.isHidden = true
        nextButtonOutlet.isEnabled = false
        
        print("PaymentProgramNameAndDescriptionVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func paymentProgramEditingSetup() {
        
        guard let paymentProgramToEdit = paymentProgramToEdit else {
            return
        }
        
        welcomeLabelOutlet.text = "Program: \(paymentProgramToEdit.programName)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in payment program editing mode"
        
        programAgreementTextView.text = paymentProgramToEdit.paymentAgreement
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension PaymentProgramAgreementViewController: UITextViewDelegate {
    
    // method to call in viewWillAppear() to subscribe to desired UIResponder keyboard notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // method to be called in viewWillDisappear() to unsubscribe from desired UIResponder keyboard notifications
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // keyboardWillChange to handle Keyboard Notifications
    @objc func keyboardWillChange(notification: Notification) {
        
        // uncomment for print statement ensuring this method is properly called
        // print("Keyboard will change: \(notification.name.rawValue) - \(notification.description)")
        
        // get the size of the keyboard
        guard let keyboardCGRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            print("ERROR: nil value for notification.userInfo[UIKeyboardFrameEndUserInfoKey] in SignUpLoginViewController.swift -> keyboardWillChange(notification:) - line 225")
            return
        }
        
        // move view up the height of keyboard and back down to original position
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            // check to see if physical screen includes iPhoneX__ form factor
            if #available(iOS 11.0, *) {
                let bottomPadding = view.safeAreaInsets.bottom
                
                self.view.frame.origin.y = -(keyboardCGRectValue.height - bottomPadding)
                
            } else {
                
                self.view.frame.origin.y = -keyboardCGRectValue.height
            }
            
        } else {
            
            self.view.frame.origin.y = 0
        }
    }
}


