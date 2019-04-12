//
//  ContactInfoViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class ContactInfoViewController: UIViewController, UITextInputTraits {

    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var parentGuardian: String?
    var profilePic: UIImage?
    var birthdate: Date?
    var beltLevel: InternationalStandardBJJBelts?
    var numberOfStripes: Int?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var phone: String?
    var mobile: String?
    var email: String?
    
    var inEditingMode: Bool?
    var userCDToEdit: Any?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil

    @IBOutlet weak var whatIsYourContactInfoLabelOutlet: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // CoreData Properties
    var owner: OwnerCD?
    var studentAdult: StudentAdultCD?
    var studentKid: StudentKidCD?
    var groupCD: GroupCD?

    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // turns off auto-correct in these UITextFields
        phoneTextField.autocorrectionType = UITextAutocorrectionType.no
        mobileTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        phoneTextField.autocapitalizationType = UITextAutocapitalizationType.none
        mobileTextField.autocapitalizationType = UITextAutocapitalizationType.none
        emailTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
        mobileTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.mobile.rawValue, attributes: beltBuilder.avenirFont)
        emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)
        
        phoneTextField.delegate = self
        mobileTextField.delegate = self
        emailTextField.delegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    // MARK: - Actions
    
    @IBAction func tapAnywhereToDismissKeyboardTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        // dismiss keyboard when leaving VC scene
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        } else if mobileTextField.isFirstResponder {
            mobileTextField.resignFirstResponder()
        } else if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        }
    }
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        } else if mobileTextField.isFirstResponder {
            mobileTextField.resignFirstResponder()
        } else if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if phoneTextField.text == "" || emailTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if phoneTextField.text == "" {
                
                phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.errorAvenirFont)
            
            } else {
                
                phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if emailTextField.text == "" {
                
                emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            // save not allowed, so we exit function
            return
        }
        
        if let isOwner = isOwner {
            if isOwner {
                // Owner update profile info
                updateOwnerInfo()
                self.returnToOwnerInfo()
            }
        }
        if let isKid = isKid {
            if isKid{
                // kidStudent update profile info
                updateKidStudentInfo()
                self.returnToStudentInfo()
            } else {
                // adultStudent update profile info
                updateAdultStudentInfo()
                self.returnToStudentInfo()
            }
        }
        
        inEditingMode = false
        
        // reset textfield placeholder text color to gray upon succesful save
        phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
        emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)

    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        } else if mobileTextField.isFirstResponder {
            mobileTextField.resignFirstResponder()
        } else if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if phoneTextField.text == "" || emailTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if phoneTextField.text == "" {
                
                phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if emailTextField.text == "" {
                
                emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            // save not allowed, so we exit function
            return
        }
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toEmergencyContactInfo") as! EmergencyContactViewController
        
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
        
        // required fields
        let phone = phoneTextField.text ?? ""
        let email = emailTextField.text ?? ""
        // not a required field
        let mobile = mobileTextField.text ?? ""
        
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.parentGuardian = parentGuardian
        destViewController.profilePic = profilePic
        destViewController.birthdate = birthdate
        destViewController.beltLevel = beltLevel
        destViewController.numberOfStripes = numberOfStripes
        destViewController.addressLine1 = addressLine1
        destViewController.addressLine2 = addressLine2
        destViewController.city = city
        destViewController.state = state
        destViewController.zipCode = zipCode
        destViewController.phone = phone
        destViewController.mobile = mobile
        destViewController.email = email
        
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        destViewController.groupCD = groupCD
        
        destViewController.inEditingMode = inEditingMode
        destViewController.userCDToEdit = userCDToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        if let isOwner = isOwner {
            if isOwner {
                updateOwnerInfo()
            }
        }
        if let isKid = isKid {
            if isKid {
                updateKidStudentInfo()
            } else {
                updateAdultStudentInfo()
            }
        }
        
        // reset textfield placeholder text color to gray upon succesful save
        phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
        emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)
        
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension ContactInfoViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            // CoreData Owner update profile info
            guard let ownerCD = userCDToEdit as? OwnerCD else { return }
            
            OwnerCDModelController.shared.update(owner: ownerCD, isInstructor: nil, birthdate: nil, mostRecentPromotion: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContact: nil)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateKidStudentInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            // CoreData Owner update profile info
            guard let studentKidCD = userCDToEdit as? StudentKidCD else { return }
            
            StudentKidCDModelController.shared.update(studentKid: studentKidCD, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, parentGuardian: nil, address: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContact: nil)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateAdultStudentInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            // CoreData Owner update profile info
            guard let studentAdultCD = userCDToEdit as? StudentAdultCD else { return }
            
                StudentAdultCDModelController.shared.update(studentAdult: studentAdultCD, isInstructor: nil, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContact: nil)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            // set editing mode for each user case
            if let isOwner = isOwner {
                if isOwner {
                    ownerEditingSetup(userToEdit: userCDToEdit)
                }
            }
            if let isKid = isKid {
                if isKid {
                    kidStudentEditingSetup(userToEdit: userCDToEdit)
                } else {
                    adultStudentEditingSetup(userToEdit: userCDToEdit)
                }
            }
        }
        
        print("ContactInfoVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerToEdit = userToEdit as? OwnerCD else {
            return
        }
        
        whatIsYourContactInfoLabelOutlet.text = "Welcome \(ownerToEdit.firstName ?? "")"
        
        phoneTextField.text = ownerToEdit.phone
        mobileTextField.text = ownerToEdit.mobile
        emailTextField.text = ownerToEdit.email
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? StudentKidCD else {
            return
        }
        
        whatIsYourContactInfoLabelOutlet.text = "Welcome \(kidToEdit.firstName ?? "")"
        
        phoneTextField.text = kidToEdit.phone
        mobileTextField.text = kidToEdit.mobile
        emailTextField.text = kidToEdit.email
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? StudentAdultCD else {
            return
        }
        
        whatIsYourContactInfoLabelOutlet.text = "Welcome \(adultToEdit.firstName ?? "")"
        
        phoneTextField.text = adultToEdit.phone
        mobileTextField.text = adultToEdit.mobile
        emailTextField.text = adultToEdit.email
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension ContactInfoViewController: UITextFieldDelegate {
    
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
    
    // UITextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == phoneTextField {
            mobileTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == mobileTextField {
            emailTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == emailTextField {
            emailTextField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}
