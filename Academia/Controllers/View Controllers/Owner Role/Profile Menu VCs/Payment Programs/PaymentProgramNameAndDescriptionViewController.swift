//
//  PaymentProgramNameAndDescriptionViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgramNameAndDescriptionViewController: UIViewController, UITextInputTraits {

    // MARK: - Properties
    
    var paymentProgramName: String?
    var active: Bool = true
    var programDescription: String?
    
    var inEditingMode: Bool?
    var paymentProgramToEdit: PaymentProgram?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    let programDescriptionTextViewPlaceholderString = "tap to enter program description"
    
    // label outlets
    @IBOutlet weak var addPaymentProgramNameDescriptionLabelOutlet: UILabel!
    // payment program info outlets
    @IBOutlet weak var programNameTextField: UITextField!
    // active switch + details
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    // program description textView
    @IBOutlet weak var programDescriptionTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // turns off auto-correct in these UITextFields
        programNameTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        programNameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        programNameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter program name", attributes: beltBuilder.avenirFont)
        programDescriptionTextView.attributedText = NSAttributedString(string: programDescriptionTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        
        programNameTextField.delegate = self
        programDescriptionTextView.delegate = self
        
        //populateCompletedProfileInfo()
    }
    
    // MARK: - Actions
    
    @IBAction func activeSwitchToggled(_ sender: UISwitch) {
        
        active = !active
        
        print("PaymentProgramNamdAndDescriptionVC active property: \(active)")
    }
    
    @IBAction func tapAnywhereToDismissTapped(_ sender: Any) {
        view.endEditing(true)
        programDescriptionTextView.resignFirstResponder()
    }
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if programNameTextField.isFirstResponder {
            programNameTextField.resignFirstResponder()
        } else if programDescriptionTextView.isFirstResponder {
            programDescriptionTextView.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if programNameTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
        
            programNameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter program name", attributes: beltBuilder.errorAvenirFont)
            
            // save not allowed, so we exit function
            return
            
        } else {
            
            // Location update profile info
            updatePaymentProgramInfo()
            
            self.returnToPaymentProgramInfo()
            
            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        }
        
        inEditingMode = false
        
        // reset textField placeholder text color to gray upon succesful save
        programNameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter payment program name", attributes: beltBuilder.avenirFont)
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if programNameTextField.isFirstResponder {
            programNameTextField.resignFirstResponder()
        } else if programDescriptionTextView.isFirstResponder {
            programDescriptionTextView.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if programNameTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            programNameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter phone", attributes: beltBuilder.errorAvenirFont)
            
            // save not allowed, so we exit function
            return
            
        }
        
        // programmatically performing the segue
        
        print("to billing details segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkflow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toPaymentProgramBillingDetails") as! PaymentProgramBillingDetailsViewController
        
        paymentProgramName = programNameTextField.text
        programDescription = programDescriptionTextView.text
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
        
        destViewController.inEditingMode = inEditingMode
        destViewController.paymentProgramToEdit = paymentProgramToEdit
        destViewController.billingTypes = paymentProgramToEdit?.billingTypes ?? []
        destViewController.billingDates = paymentProgramToEdit?.billingDates ?? []
        destViewController.signatureTypes = paymentProgramToEdit?.signatureTypes ?? []
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updatePaymentProgramInfo()
        
        // reset textField placeholder text color to gray upon succesful save
        programNameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter phone", attributes: beltBuilder.avenirFont)
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension PaymentProgramNameAndDescriptionViewController {
    
    // Update Function for case where want to update user info without a segue
    func updatePaymentProgramInfo() {
        guard let paymentProgram = paymentProgramToEdit else { return }
        // payment program update info
        if programNameTextField.text != "" {
            PaymentProgramModelController.shared.update(paymentProgram: paymentProgram, programName: programNameTextField.text, active: active, paymentDescription: programDescriptionTextView.text, billingTypes: nil, billingDates: nil, signatureTypes: nil, paymentAgreement: nil)
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
        
        addPaymentProgramNameDescriptionLabelOutlet.text = "Program: \(paymentProgramToEdit.programName)"
        
        programDescriptionTextView.attributedText = NSAttributedString(string: paymentProgramToEdit.paymentDescription, attributes: beltBuilder.avenirFontBlack)

        programNameTextField.text = paymentProgramToEdit.programName
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension PaymentProgramNameAndDescriptionViewController: UITextFieldDelegate, UITextViewDelegate {
    
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
    
    // funciton to handle UITextView user editing
    @objc func texfViewWillEdit(notificaiton: Notification) {
        
        // check for start of editing with placeholder text in place
        if notificaiton.name == UITextView.textDidBeginEditingNotification && programDescriptionTextView.text == programDescriptionTextViewPlaceholderString {
            
            // change to input fontstyle and empty textView.text ready for user input
            programDescriptionTextView.font = UIFont(name: "Avenir-Light", size: 16)
            programDescriptionTextView.text = ""
            
        // check for end of editing and no user input
        } else if notificaiton.name == UITextView.textDidEndEditingNotification && programDescriptionTextView.text == "" {
            
            // reset to placeholder text
            programDescriptionTextView.attributedText = NSAttributedString(string: programDescriptionTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        }
    }
    
    // UITextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == programNameTextField {
            programNameTextField.resignFirstResponder()
            print("Next button tapped")
        }
        return true
    }
}

