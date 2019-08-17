//
//  LocationContactInfoViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class LocationContactInfoViewController: UIViewController, UITextInputTraits {
    
    // MARK: - Properties
    
    var locationName: String?
    var ownerName: String?
    var locationPic: UIImage?
    var active: Bool?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var phone: String?
    var website: String?
    var email: String?
    
    var inEditingMode: Bool?
    var locationToEdit: Location?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil

    @IBOutlet weak var contactInformationForLocationLabelOutlet: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // CoreData properties
    var location: LocationCD?
    var locationCDToEdit: LocationCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // turns off auto-correct in these UITextFields
        phoneTextField.autocorrectionType = UITextAutocorrectionType.no
        websiteTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        phoneTextField.autocapitalizationType = UITextAutocapitalizationType.none
        websiteTextField.autocapitalizationType = UITextAutocapitalizationType.none
        emailTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
        websiteTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.website.rawValue, attributes: beltBuilder.avenirFont)
        emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)
        
        phoneTextField.delegate = self
        websiteTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func tapAnywhereToDismissKeyboard(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        // dismiss keyboard when leaving VC scene
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        } else if websiteTextField.isFirstResponder {
            websiteTextField.resignFirstResponder()
        } else if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        }
    }
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        } else if websiteTextField.isFirstResponder {
            websiteTextField.resignFirstResponder()
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
        
        // reset label text color to black upon succesful save
        phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
        emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)
        
        // Location update profile info
        updateLocationInfo()
        
        self.returnToLocationInfo()
        
        inEditingMode = false
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        } else if websiteTextField.isFirstResponder {
            websiteTextField.resignFirstResponder()
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
        
        // reset label text color to black upon succesful save
        phoneTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.phone.rawValue, attributes: beltBuilder.avenirFont)
        emailTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.email.rawValue, attributes: beltBuilder.avenirFont)
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerLocationWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toLocationSocialLinks") as! LocationSocialLinksViewController
        
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
        let phone = phoneTextField.text
        let email = emailTextField.text
        // not a required field
        let website = websiteTextField.text
        
        // pass data to destViewController
        destViewController.locationName = locationName
        destViewController.ownerName = ownerName
        destViewController.active = active
        destViewController.locationPic = locationPic
        destViewController.addressLine1 = addressLine1
        destViewController.addressLine2 = addressLine2
        destViewController.city = city
        destViewController.state = state
        destViewController.zipCode = zipCode
        destViewController.phone = phone
        destViewController.website = website
        destViewController.email = email
        
        destViewController.inEditingMode = inEditingMode
        destViewController.locationToEdit = locationToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateLocationInfo()
        destViewController.locationCDToEdit = locationCDToEdit
    }
}


// MARK: - Editing Mode for Individual Location case specific setup
extension LocationContactInfoViewController {
    
    // Update Function for case where want to update location info without a segue
    func updateLocationInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            // CoreData LocationCD update info
            guard let locationCD = locationCDToEdit else { return }
            
            LocationCDModelController.shared.update(location: locationCD, locationPic: nil, locationName: nil, address: nil, phone: phoneTextField.text, website: websiteTextField.text, email: emailTextField.text, socialLinks: nil)
            
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            locationEditingSetup(userToEdit: locationToEdit)
        }
        
        print("LocationContactInfoVC -> inEditingMode = \(inEditingMode)")
    }
    
    // location setup for editing mode
    func locationEditingSetup(userToEdit: Location?) {
        
        guard let locationCDToEdit = locationCDToEdit else {
            return
        }
        
        contactInformationForLocationLabelOutlet.text = "Location: \(locationCDToEdit.locationName ?? "")"
        
        phoneTextField.text = locationCDToEdit.phone
        websiteTextField.text = locationCDToEdit.website
        emailTextField.text = locationCDToEdit.email
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension LocationContactInfoViewController: UITextFieldDelegate {
    
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
            websiteTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == websiteTextField {
            emailTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == emailTextField {
            emailTextField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}
