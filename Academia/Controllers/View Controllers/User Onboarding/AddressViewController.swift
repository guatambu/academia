//
//  AddressViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class AddressViewController: UIViewController, UITextInputTraits {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var academyChoice: String?
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
    
    var inEditingMode: Bool?
    var userCDToEdit: Any?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    // IBOutlets
    @IBOutlet weak var whatIsYourAddressLabelOutlet: UILabel!
    @IBOutlet weak var thisIsOptionalLabelOutlet: UILabel!
    @IBOutlet weak var addAnyTimeLabelOutlet: UILabel!
    @IBOutlet weak var signUpElementsStackView: UIStackView!
    @IBOutlet weak var addressLine1TextField: UITextField!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    // CoreData Properties
    var owner: OwnerCD?
    var studentAdult: StudentAdultCD?
    var studentKid: StudentKidCD?
    var groupCD: GroupCD?
    // Firebase Properties
    var birthdateTimestamp: Timestamp?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // turns off auto-correct in these UITextFields
        addressLine1TextField.autocorrectionType = UITextAutocorrectionType.no
        addressLine2TextField.autocorrectionType = UITextAutocorrectionType.no
        cityTextField.autocorrectionType = UITextAutocorrectionType.no
        stateTextField.autocorrectionType = UITextAutocorrectionType.no
        zipCodeTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        addressLine1TextField.autocapitalizationType = UITextAutocapitalizationType.none
        addressLine2TextField.autocapitalizationType = UITextAutocapitalizationType.none
        cityTextField.autocapitalizationType = UITextAutocapitalizationType.none
        stateTextField.autocapitalizationType = UITextAutocapitalizationType.none
        zipCodeTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.avenirFont)
        addressLine2TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.additionalAddress.rawValue, attributes: beltBuilder.avenirFont)
        cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.avenirFont)
        stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.avenirFontSmall)
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.avenirFontSmall)
        
        addressLine1TextField.delegate = self
        addressLine2TextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    // MARK: - Actions
    
    @IBAction func tapAnywhereToDismissKeyboardTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        // dismiss keyboard when leaving VC scene
        if addressLine1TextField.isFirstResponder {
            addressLine1TextField.resignFirstResponder()
        } else if addressLine2TextField.isFirstResponder {
            addressLine2TextField.resignFirstResponder()
        } else if cityTextField.isFirstResponder {
            cityTextField.resignFirstResponder()
        } else if stateTextField.isFirstResponder {
            stateTextField.resignFirstResponder()
        } else if zipCodeTextField.isFirstResponder {
            zipCodeTextField.resignFirstResponder()
        }
    }
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if addressLine1TextField.isFirstResponder {
            addressLine1TextField.resignFirstResponder()
        } else if addressLine2TextField.isFirstResponder {
            addressLine2TextField.resignFirstResponder()
        } else if cityTextField.isFirstResponder {
            cityTextField.resignFirstResponder()
        } else if stateTextField.isFirstResponder {
            stateTextField.resignFirstResponder()
        } else if zipCodeTextField.isFirstResponder {
            zipCodeTextField.resignFirstResponder()
        }
        
        // if successful input from user, then we proceed on to save
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
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if addressLine1TextField.isFirstResponder {
            addressLine1TextField.resignFirstResponder()
        } else if addressLine2TextField.isFirstResponder {
            addressLine2TextField.resignFirstResponder()
        } else if cityTextField.isFirstResponder {
            cityTextField.resignFirstResponder()
        } else if stateTextField.isFirstResponder {
            stateTextField.resignFirstResponder()
        } else if zipCodeTextField.isFirstResponder {
            zipCodeTextField.resignFirstResponder()
        }
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toContactInfo") as! ContactInfoViewController
        
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
        let addressLine1 = addressLine1TextField.text ?? ""
        let city = cityTextField.text  ?? ""
        let state = stateTextField.text  ?? ""
        let zipCode = zipCodeTextField.text  ?? ""
        // not a required field
        let addressLine2 = addressLine2TextField.text  ?? ""
        
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.academyChoice = academyChoice
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.parentGuardian = parentGuardian
        destViewController.profilePic = profilePic
        destViewController.birthdate = birthdate
        destViewController.birthdateTimestamp = birthdateTimestamp
        
        destViewController.beltLevel = beltLevel
        destViewController.numberOfStripes = numberOfStripes
        
        destViewController.addressLine1 = addressLine1
        destViewController.addressLine2 = addressLine2
        destViewController.city = city
        destViewController.state = state
        destViewController.zipCode = zipCode
        
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
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension AddressViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        if addressLine1TextField.text != "" && cityTextField.text != "" && stateTextField.text != "" && zipCodeTextField.text != "" {
            
            // CoreData Belt property update
            guard let ownerCD = userCDToEdit as? OwnerCD else { return }
            guard let address = ownerCD.address else { return }
            
            AddressCDModelController.shared.update(address: address, addressLine1: addressLine1TextField.text, addressLine2: addressLine2TextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: zipCodeTextField.text)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateKidStudentInfo() {
        if addressLine1TextField.text != "" && cityTextField.text != "" && stateTextField.text != "" && zipCodeTextField.text != "" {
            
            // CoreData Belt property update
            guard let studentKidCD = userCDToEdit as? StudentKidCD else { return }
            guard let address = studentKidCD.address else { return }
            
            AddressCDModelController.shared.update(address: address, addressLine1: addressLine1TextField.text, addressLine2: addressLine2TextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: zipCodeTextField.text)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateAdultStudentInfo() {
        if addressLine1TextField.text != "" && cityTextField.text != "" && stateTextField.text != "" && zipCodeTextField.text != "" {
            
            // CoreData Belt property update
            guard let studentAdultCD = userCDToEdit as? StudentAdultCD else { return }
            guard let address = studentAdultCD.address else { return }
            
            AddressCDModelController.shared.update(address: address, addressLine1: addressLine1TextField.text, addressLine2: addressLine2TextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: zipCodeTextField.text)
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
        
        print("AddressVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerToEdit = userToEdit as? OwnerCD else {
            return
        }
        
        if ownerToEdit.address?.addressLine1 != "" {
            
            whatIsYourAddressLabelOutlet.text = "Welcome \(ownerToEdit.firstName ?? "")"
            thisIsOptionalLabelOutlet.isHidden = true
            addAnyTimeLabelOutlet.isHidden = true
        }
        
        addressLine1TextField.text = ownerToEdit.address?.addressLine1
        addressLine2TextField.text = ownerToEdit.address?.addressLine2
        cityTextField.text = ownerToEdit.address?.city
        stateTextField.text = ownerToEdit.address?.state
        zipCodeTextField.text = ownerToEdit.address?.zipCode
        
        
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidCDToEdit = userToEdit as? StudentKidCD else {
            return
        }
        
        if kidCDToEdit.emergencyContact?.name != "" {
            
            whatIsYourAddressLabelOutlet.text = "Welcome \(kidCDToEdit.firstName ?? "")"
            thisIsOptionalLabelOutlet.isHidden = true
            addAnyTimeLabelOutlet.isHidden = true
        }
        
        addressLine1TextField.text = kidCDToEdit.address?.addressLine1
        addressLine2TextField.text = kidCDToEdit.address?.addressLine2
        cityTextField.text = kidCDToEdit.address?.city
        stateTextField.text = kidCDToEdit.address?.state
        zipCodeTextField.text = kidCDToEdit.address?.zipCode
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultCDToEdit = userToEdit as? StudentAdultCD else {
            return
        }
        
        if adultCDToEdit.emergencyContact?.name != "" {
            
            whatIsYourAddressLabelOutlet.text = "Welcome \(adultCDToEdit.firstName ?? "")"
            thisIsOptionalLabelOutlet.isHidden = true
            addAnyTimeLabelOutlet.isHidden = true
        }
        
        addressLine1TextField.text = adultCDToEdit.address?.addressLine1
        addressLine2TextField.text = adultCDToEdit.address?.addressLine2
        cityTextField.text = adultCDToEdit.address?.city
        stateTextField.text = adultCDToEdit.address?.state
        zipCodeTextField.text = adultCDToEdit.address?.zipCode
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension AddressViewController: UITextFieldDelegate {
    
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
            print("ERROR: nil value for notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] in AddressViewController.swift -> keyboardWillChange(notification:) - line 415.")
            return
        }
        
        // move view up the height of keyboard and back down to original position
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            // check to see if physical screen includes iPhoneX__ form factor
            if #available(iOS 11.0, *) {
                let bottomPadding = view.safeAreaInsets.bottom
                
                self.view.frame.origin.y = -(keyboardCGRectValue.height - bottomPadding)
                self.signUpElementsStackView.spacing = 8.0
                
            } else {
                
                self.view.frame.origin.y = -keyboardCGRectValue.height
            }
            
        } else {
            
            self.view.frame.origin.y = 0
            self.signUpElementsStackView.spacing = 48.0
        }
    }
    
    // UITextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == addressLine1TextField {
            addressLine2TextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == addressLine2TextField {
            cityTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == cityTextField {
            stateTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == stateTextField {
            zipCodeTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == zipCodeTextField {
            zipCodeTextField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}
