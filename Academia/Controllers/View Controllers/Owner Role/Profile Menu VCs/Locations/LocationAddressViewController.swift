//
//  LocationAddressViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationAddressViewController: UIViewController, UITextInputTraits{
    
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
    
    var inEditingMode: Bool?
    var locationToEdit: Location?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil

    @IBOutlet weak var whatIsLocationAddressLabelOutlet: UILabel!
    @IBOutlet weak var signUpElementsStackView: UIStackView!
    @IBOutlet weak var addressLine1TextField: UITextField!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    // CoreData properties
    var locationCD: LocationCD?
    var locationCDToEdit: LocationCD?
    
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.avenirFont)
        addressLine2TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.additionalAddress.rawValue, attributes: beltBuilder.avenirFont)
        cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.avenirFont)
        stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.avenirFont)
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.avenirFont)
        
        addressLine1TextField.delegate = self
        addressLine2TextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self
        
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
        
        // check for required information being left blank by user
        if addressLine1TextField.text == "" || cityTextField.text == "" || stateTextField.text == "" || zipCodeTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if addressLine1TextField.text == "" {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if cityTextField.text == "" {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if stateTextField.text == "" {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if zipCodeTextField.text == "" {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            // save not allowed, so we exit function
            return
        }
        
        // reset textField placeholder text color to gray upon succesful save
        addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.avenirFont)
        addressLine2TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.additionalAddress.rawValue, attributes: beltBuilder.avenirFont)
        cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.avenirFont)
        stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.avenirFont)
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.avenirFont)
        
        // Location update profile info
        updateLocationInfo()
        
        self.returnToLocationInfo()
        
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
        
        // check for required information being left blank by user
        if addressLine1TextField.text == "" || cityTextField.text == "" || stateTextField.text == "" || zipCodeTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if addressLine1TextField.text == "" {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if cityTextField.text == "" {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if stateTextField.text == "" {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if zipCodeTextField.text == "" {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            // save not allowed, so we exit function
            return
        }
        
        // reset textField placeholder text color to gray upon succesful save
        addressLine1TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.streetAddress.rawValue, attributes: beltBuilder.avenirFont)
        addressLine2TextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.additionalAddress.rawValue, attributes: beltBuilder.avenirFont)
        cityTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.city.rawValue, attributes: beltBuilder.avenirFont)
        stateTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.state.rawValue, attributes: beltBuilder.avenirFont)
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.zipCode.rawValue, attributes: beltBuilder.avenirFont)
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerLocationWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toLocationContactInfo") as! LocationContactInfoViewController
        
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
        guard let addressLine1 = addressLine1TextField.text else { return }
        guard let city = cityTextField.text else { return }
        guard let state = stateTextField.text else { return }
        guard let zipCode = zipCodeTextField.text else { return }
        
        // not required field
        let addressLine2 = addressLine2TextField.text
        
        // pass data to destViewController
        destViewController.locationName = locationName
        destViewController.ownerName = ownerName
        destViewController.locationPic = locationPic
        destViewController.active = active
        destViewController.addressLine1 = addressLine1
        destViewController.addressLine2 = addressLine2
        destViewController.city = city
        destViewController.state = state
        destViewController.zipCode = zipCode
        
        destViewController.inEditingMode = inEditingMode
        destViewController.locationToEdit = locationToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateLocationInfo()
        destViewController.locationCDToEdit = locationCDToEdit
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension LocationAddressViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateLocationInfo() {
        if addressLine1TextField.text != "" && cityTextField.text != "" && stateTextField.text != "" && zipCodeTextField.text != "" {

            // CoreData LocationCD property update
            guard let locationCD = locationCDToEdit else { return }
            guard let address = locationCD.address else { return }
            
            AddressCDModelController.shared.update(address: address, addressLine1: addressLine1TextField.text, addressLine2: addressLine2TextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: zipCodeTextField.text)
            
            // MARK: - vvv is this necessary? vvv
            LocationCDModelController.shared.update(location: locationCD, locationPic: nil, locationName: nil, address: address, phone: nil, website: nil, email: nil, socialLinks: nil)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
        
        
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            // set editing mode for each user case
            locationEditingSetup(locationToEdit: locationToEdit)
        }
        
        print("LocationAddressVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func locationEditingSetup(locationToEdit: Location?) {
        
        guard let locationCDToEdit = locationCDToEdit else {
            return
        }
        
        whatIsLocationAddressLabelOutlet.text = "Location: \(locationCDToEdit.locationName ?? "")"
        
        addressLine1TextField.text = locationCDToEdit.address?.addressLine1
        addressLine2TextField.text = locationCDToEdit.address?.addressLine2
        cityTextField.text = locationCDToEdit.address?.city
        stateTextField.text = locationCDToEdit.address?.state
        zipCodeTextField.text = locationCDToEdit.address?.zipCode
        
        
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension LocationAddressViewController: UITextFieldDelegate {
    
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
                self.signUpElementsStackView.spacing = 16
                
            } else {
                
                self.view.frame.origin.y = -keyboardCGRectValue.height
            }
            
        } else {
            
            self.view.frame.origin.y = 0
            self.signUpElementsStackView.spacing = 48
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
