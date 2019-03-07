//
//  EmergencyContactViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class EmergencyContactViewController: UIViewController {

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
    var emergencyContactName: String?
    var emergencyContactPhone: String?
    var emergencyContactRelationship: String?
    
    var inEditingMode: Bool?
    var userToEdit: Any?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var whoIsYourEmergencyContactLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactNameTextField: UITextField!
    @IBOutlet weak var emergencyContactPhoneTextField: UITextField!
    @IBOutlet weak var emergencyContactRelationshipTextField: UITextField!
    
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    @IBOutlet weak var firstProgressDotOutlet: DesignableView!
    
    // CoreData Properties
    var owner: OwnerCD?
    var studentAdult: StudentAdultCD?
    var studentKid: StudentKidCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // to reset from editing mode
        nextButtonOutlet.isHidden = false
        nextButtonOutlet.isEnabled = true
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emergencyContactNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactName.rawValue, attributes: beltBuilder.avenirFont)
        emergencyContactPhoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactPhone.rawValue, attributes: beltBuilder.avenirFont)
        emergencyContactRelationshipTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactRelationship.rawValue, attributes: beltBuilder.avenirFont)
        
        emergencyContactNameTextField.delegate = self
        emergencyContactPhoneTextField.delegate = self
        emergencyContactRelationshipTextField.delegate = self
        
        nextButtonOutlet.isHidden = false
        nextButtonOutlet.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    // MARK: - Actions
    
    @IBAction func tapAnywhereToDismissKeyboardTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        // dismiss keyboard when leaving VC scene
        if emergencyContactNameTextField.isFirstResponder {
            emergencyContactNameTextField.resignFirstResponder()
        } else if emergencyContactNameTextField.isFirstResponder {
            emergencyContactPhoneTextField.resignFirstResponder()
        } else if emergencyContactRelationshipTextField.isFirstResponder {
            emergencyContactRelationshipTextField.resignFirstResponder()
        }
    }
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if emergencyContactNameTextField.isFirstResponder {
            emergencyContactNameTextField.resignFirstResponder()
        } else if emergencyContactNameTextField.isFirstResponder {
            emergencyContactPhoneTextField.resignFirstResponder()
        } else if emergencyContactRelationshipTextField.isFirstResponder {
            emergencyContactRelationshipTextField.resignFirstResponder()
        }
        
        // ADD TO Properties
        var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
        
        // check for required information being left blank by user
        if emergencyContactNameTextField.text == "" || emergencyContactNameTextField.text == "" || emergencyContactRelationshipTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if emergencyContactNameTextField.text == "" {
                
                emergencyContactNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactName.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emergencyContactNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactName.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if emergencyContactPhoneTextField.text == "" {
                
                emergencyContactPhoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactPhone.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emergencyContactPhoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactPhone.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if emergencyContactRelationshipTextField.text == "" {
                
                emergencyContactRelationshipTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactRelationship.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emergencyContactRelationshipTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactRelationship.rawValue, attributes: beltBuilder.avenirFont)
                
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
        emergencyContactNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactName.rawValue, attributes: beltBuilder.avenirFont)
        emergencyContactPhoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactPhone.rawValue, attributes: beltBuilder.avenirFont)
        emergencyContactRelationshipTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactRelationship.rawValue, attributes: beltBuilder.avenirFont)
    
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if emergencyContactNameTextField.isFirstResponder {
            emergencyContactNameTextField.resignFirstResponder()
        } else if emergencyContactPhoneTextField.isFirstResponder {
            emergencyContactPhoneTextField.resignFirstResponder()
        } else if emergencyContactRelationshipTextField.isFirstResponder {
            emergencyContactRelationshipTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if emergencyContactNameTextField.text == "" || emergencyContactPhoneTextField.text == "" || emergencyContactRelationshipTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if emergencyContactNameTextField.text == "" {
                
                emergencyContactNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactName.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emergencyContactNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactName.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if emergencyContactPhoneTextField.text == "" {
                
               emergencyContactPhoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactPhone.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emergencyContactPhoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactPhone.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if emergencyContactRelationshipTextField.text == "" {
                
                emergencyContactRelationshipTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactRelationship.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                emergencyContactRelationshipTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactRelationship.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            // save not allowed, so we exit function
            return
        }
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toProfileComplete") as! CompletedProfileViewController
        
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
        
        // reset textfield placeholder text color to gray upon succesful save
        emergencyContactNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactName.rawValue, attributes: beltBuilder.avenirFont)
        emergencyContactPhoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactPhone.rawValue, attributes: beltBuilder.avenirFont)
        emergencyContactRelationshipTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.emergencyContactRelationship.rawValue, attributes: beltBuilder.avenirFont)
        
        // required fields
        guard let emergencyContactName = emergencyContactNameTextField.text else { print("fail emergencyContactName"); return }
        guard let emergencyContactRelationship = emergencyContactRelationshipTextField.text else { print("fail emergencyContactRelationship"); return }
        guard let emergencyContactPhone = emergencyContactPhoneTextField.text else { print("fail emergencyContactPhone"); return }
        
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
        destViewController.emergencyContactName = emergencyContactName
        destViewController.emergencyContactRelationship = emergencyContactRelationship
        destViewController.emergencyContactPhone = emergencyContactPhone
        
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        
        // initalize the AddressCD object
        let emergencyContact = EmergencyContactCD(name: emergencyContactName, phone: emergencyContactPhone, relationship: emergencyContactRelationship)
        // pass CoreData Properties
        if let owner = owner {
            
            owner.emergencyContact = emergencyContact
            destViewController.owner = owner
            
        } else if let studentAdult = studentAdult  {
            
            studentAdult.emergencyContact = emergencyContact
            destViewController.studentAdult = studentAdult
            
        } else if let studentKid = studentKid  {
            
            studentKid.emergencyContact = emergencyContact
            destViewController.studentKid = studentKid
        }
        
        guard let isOwner = isOwner else { print("fail isOwner"); return }
        guard let isKid = isKid else { print("fail isKid"); return }
        guard profilePic != nil else { print("fail profilePic"); return }
        guard let username = username else { print("fail username"); return }
        guard let password = password else { print("fail password"); return }
        guard let firstName = firstName else { print("fail firtsName"); return }
        guard let lastName = lastName else { print("fail lastName"); return }
        guard let birthdate = birthdate else { print("fail birthdate"); return }
        guard let beltLevel = beltLevel else { print("fail beltLevel"); return }
        guard let numberOfStripes = numberOfStripes else { print("fail stripes"); return }
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        guard let city = city else { print("fail city"); return }
        guard let state = state else { print("fail state"); return }
        guard let zipCode = zipCode else { print("fail zip"); return }
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        // print to console for developer verification
        print("isOwner: \(isOwner) \nisKid: \(isKid) \nusername: \(username) \npassword: \(password) \nfirstName: \(firstName) \nlastName: \(lastName) \nbirthdate: \(birthdate) \nbeltLevel: \(beltLevel.rawValue) \nnumberOfStripes: \(numberOfStripes) \naddressLine1: \(addressLine1) \naddressLine2: \(String(describing: addressLine2)) \ncity: \(city) \nstate: \(state) \nzipCode: \(zipCode) \nphone: \(phone) \nmobile: \(String(describing: mobile)) \nemail: \(email) \nemergencyContactName: \(emergencyContactName) \nemergencyContactRelationship: \(emergencyContactRelationship) \nemergencyContactPhone: \(emergencyContactPhone) \nparentGuardian: \(String(describing: parentGuardian))")
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension EmergencyContactViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        if emergencyContactNameTextField.text != "" && emergencyContactPhoneTextField.text != "" && emergencyContactRelationshipTextField.text != "" {
            
            guard let owner = userToEdit as? Owner else { return }
            
            OwnerModelController.shared.updateProfileInfo(owner: owner, isInstructor: nil, birthdate: nil, groups: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: emergencyContactNameTextField.text, emergencyContactPhone: emergencyContactPhoneTextField.text, emergencyContactRelationship: emergencyContactRelationshipTextField.text)
            
            // CoreData Belt property update
            guard let ownerCD = userToEdit as? OwnerCD else { return }
            guard let emergencyContact = ownerCD.emergencyContact else { return }
            let name = emergencyContactNameTextField.text ?? ""
            let phone = emergencyContactPhoneTextField.text ?? ""
            let relationship = emergencyContactRelationshipTextField.text ?? ""
            
            EmergencyContactCDModelController.shared.update(emergencyContact: emergencyContact, name: name, phone: phone, relationship: relationship)
        }
    }
    
    func updateKidStudentInfo() {
        if emergencyContactNameTextField.text != "" && emergencyContactPhoneTextField.text != "" && emergencyContactRelationshipTextField.text != "" {
            
            guard let kidStudent = userToEdit as? KidStudent else { return }
            
            KidStudentModelController.shared.updateProfileInfo(kidStudent: kidStudent, birthdate: nil, groups: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, parentGuardian: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: emergencyContactNameTextField.text, emergencyContactPhone: emergencyContactPhoneTextField.text, emergencyContactRelationship: emergencyContactRelationshipTextField.text)
            
            // CoreData Belt property update
            guard let studentKidCD = userToEdit as? StudentKidCD else { return }
            guard let emergencyContact = studentKidCD.emergencyContact else { return }
            let name = emergencyContactNameTextField.text ?? ""
            let phone = emergencyContactPhoneTextField.text ?? ""
            let relationship = emergencyContactRelationshipTextField.text ?? ""
            
            EmergencyContactCDModelController.shared.update(emergencyContact: emergencyContact, name: name, phone: phone, relationship: relationship)
        }
    }
    
    func updateAdultStudentInfo() {
        if emergencyContactNameTextField.text != "" && emergencyContactPhoneTextField.text != "" && emergencyContactRelationshipTextField.text != "" {
            
            guard let adultStudent = userToEdit as? AdultStudent else { return }
            
//            let adult = AdultStudentModelController.shared.adults[0]
            AdultStudentModelController.shared.updateProfileInfo(adultStudent: adultStudent, birthdate: nil, groups: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: emergencyContactNameTextField.text, emergencyContactPhone: emergencyContactPhoneTextField.text, emergencyContactRelationship: emergencyContactRelationshipTextField.text)
            
            // CoreData Belt property update
            guard let studentAdultCD = userToEdit as? StudentAdultCD else { return }
            guard let emergencyContact = studentAdultCD.emergencyContact else { return }
            let name = emergencyContactNameTextField.text ?? ""
            let phone = emergencyContactPhoneTextField.text ?? ""
            let relationship = emergencyContactRelationshipTextField.text ?? ""
            
            EmergencyContactCDModelController.shared.update(emergencyContact: emergencyContact, name: name, phone: phone, relationship: relationship)
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            // set editing mode for each user case
            if let isOwner = isOwner {
                if isOwner {
                    ownerEditingSetup(userToEdit: userToEdit)
                }
            }
            if let isKid = isKid {
                if isKid {
                    kidStudentEditingSetup(userToEdit: userToEdit)
                } else {
                    adultStudentEditingSetup(userToEdit: userToEdit)
                }
            }
            nextButtonOutlet.isHidden = true
            nextButtonOutlet.isEnabled = false
        }
        
        print("EmergencyContactVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerToEdit = userToEdit as? Owner else {
            return
        }
        
        whoIsYourEmergencyContactLabelOutlet.text = "Welcome \(ownerToEdit.firstName)"
        
        emergencyContactNameTextField.text = ownerToEdit.emergencyContactName
        emergencyContactPhoneTextField.text = ownerToEdit.emergencyContactPhone
        emergencyContactRelationshipTextField.text = ownerToEdit.emergencyContactRelationship
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? KidStudent else {
            return
        }
        
        whoIsYourEmergencyContactLabelOutlet.text = "Welcome \(kidToEdit.firstName)"
        
        emergencyContactNameTextField.text = kidToEdit.emergencyContactName
        emergencyContactPhoneTextField.text = kidToEdit.emergencyContactPhone
        emergencyContactRelationshipTextField.text = kidToEdit.emergencyContactRelationship
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? AdultStudent else {
            return
        }
        
        whoIsYourEmergencyContactLabelOutlet.text = "Welcome \(adultToEdit.firstName)"
        
        emergencyContactNameTextField.text = adultToEdit.emergencyContactName
        emergencyContactPhoneTextField.text = adultToEdit.emergencyContactPhone
        emergencyContactRelationshipTextField.text = adultToEdit.emergencyContactRelationship
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension EmergencyContactViewController: UITextFieldDelegate {
    
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
        
        if textField == emergencyContactNameTextField {
            emergencyContactPhoneTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == emergencyContactPhoneTextField {
            emergencyContactRelationshipTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == emergencyContactRelationshipTextField {
            emergencyContactRelationshipTextField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}


