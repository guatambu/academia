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
    
    let programAgreementTextViewPlaceholderString = PlaceholderStrings.paymentProgramAgreement.rawValue
    
    // CoreData properties
    var paymentProgramCD: PaymentProgramCD?
    var paymentProgramCDToEdit: PaymentProgramCD?
    
    let agreementStackViewTopToSafeAreaConstraintOriginalValue: CGFloat = 72.0
    // constraint outlets
    @IBOutlet weak var nextButtonToBottomAgreementStackViewConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var agreementStackViewTopToSafeAreaConstraintOutlet: NSLayoutConstraint!
    // label outlets
    @IBOutlet weak var addPaymentProgramAgreementLabelOutlet: UILabel!
    // program agreement textView
    @IBOutlet weak var programAgreementTextView: UITextView!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        programAgreementTextView.attributedText = NSAttributedString(string: programAgreementTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        
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
        
        if programAgreementTextView.isFirstResponder {
            programAgreementTextView.resignFirstResponder()
        }
        
        // Location update profile info
        if programAgreementTextView.text != "" {
            
            updatePaymentProgramInfo()
            
            self.returnToPaymentProgramInfo()
            
        }
        inEditingMode = false
    }
    
    @IBAction func tapAnywhereToDismissKeyboardTapped(_ sender: Any) {
        view.endEditing(true)
        programAgreementTextView.resignFirstResponder()
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        if programAgreementTextView.isFirstResponder {
            programAgreementTextView.resignFirstResponder()
        }
        
        // programmatically performing the segue
        
        print("to review and create program segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkflow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toReviewAndCreatePaymentProgram") as! ReviewAndCreatePaymentProgramViewController
        
        // run check to see is there is a paymentProgramName
        guard programAgreementTextView.text != "" else {
            
            addPaymentProgramAgreementLabelOutlet.textColor = beltBuilder.redBeltRed
            return
        }
        
        programAgreement = programAgreementTextView.text
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
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
//        guard let paymentProgramToEdit = paymentProgramToEdit else { return }
        // payment program update info
        if programAgreementTextView.text != "" {
//            PaymentProgramModelController.shared.update(paymentProgram: paymentProgramToEdit, programName: nil, active: nil, paymentDescription: nil, billingTypes: nil, billingDates: nil, signatureTypes: nil, paymentAgreement: programAgreementTextView.text)
//            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].paymentAgreement)")
            
            
            // CoreData PaymentProgramCD update info
            guard let paymentProgramCDToEdit = paymentProgramCDToEdit else { return }
            
            PaymentProgramCDModelController.shared.update(paymentProgramn: paymentProgramCDToEdit, active: nil, programName: nil, paymentAgreement: programAgreementTextView.text, paymentDescription: nil)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
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
        
        guard let paymentProgramCDToEdit = paymentProgramCDToEdit else {
            return
        }
        
        addPaymentProgramAgreementLabelOutlet.text = "Program: \(paymentProgramCDToEdit.programName ?? "")"
        
        programAgreementTextView.text = paymentProgramCDToEdit.paymentAgreement
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension PaymentProgramAgreementViewController: UITextViewDelegate {
    
    // method to call in viewWillAppear() to subscribe to desired UIResponder keyboard notifications
    func subscribeToKeyboardNotifications() {
        
        // notifications unique to keyboard itself
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // notifications unique to editing of programDescriptionTextView text
        NotificationCenter.default.addObserver(self, selector: #selector(texfViewWillEdit(notificaiton:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(texfViewWillEdit(notificaiton:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    // method to be called in viewWillDisappear() to unsubscribe from desired UIResponder keyboard notifications
    func unsubscribeToKeyboardNotifications() {
        
        // notifications unique to keyboard itself
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // notifications unique to editing of programDescriptionTextView text
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    // funciton to handle UITextView user editing
    @objc func texfViewWillEdit(notificaiton: Notification) {
        
        // check for start of editing with placeholder text in place
        if notificaiton.name == UITextView.textDidBeginEditingNotification && programAgreementTextView.text == programAgreementTextViewPlaceholderString {
            
            // change to input fontstyle and empty textView.text ready for user input
            programAgreementTextView.font = UIFont(name: "Avenir-Light", size: 16)
            programAgreementTextView.text = ""
            
            // check for end of editing and no user input
        } else if notificaiton.name == UITextView.textDidEndEditingNotification && programAgreementTextView.text == "" {
            
            // reset to placeholder text
            programAgreementTextView.attributedText = NSAttributedString(string: programAgreementTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        }
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
        
        // *******
        
        // TODO: - fix agreement TextView to accommodate small screen when keyboard comes up
        
        // *******
        let bottomPadding = view.safeAreaInsets.bottom
        
        // move view up the height of keyboard and back down to original position
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            // check to see if physical screen includes iPhoneX__ form factor
            if #available(iOS 11.0, *) {
                
                self.view.frame.origin.y = -(keyboardCGRectValue.height - bottomPadding)
                self.agreementStackViewTopToSafeAreaConstraintOutlet.constant = (agreementStackViewTopToSafeAreaConstraintOriginalValue + 64.0)
                self.nextButtonToBottomAgreementStackViewConstraintOutlet.constant = 8.0
                
            } else {
                
                self.view.frame.origin.y = -keyboardCGRectValue.height
                self.agreementStackViewTopToSafeAreaConstraintOutlet.constant = (agreementStackViewTopToSafeAreaConstraintOriginalValue)
                
                self.nextButtonToBottomAgreementStackViewConstraintOutlet.constant = 40.0
            }
            
        } else {
            
            self.view.frame.origin.y = 0
            
            self.agreementStackViewTopToSafeAreaConstraintOutlet.constant = (agreementStackViewTopToSafeAreaConstraintOriginalValue)
            
            self.nextButtonToBottomAgreementStackViewConstraintOutlet.constant = 40
        }
    }
}


