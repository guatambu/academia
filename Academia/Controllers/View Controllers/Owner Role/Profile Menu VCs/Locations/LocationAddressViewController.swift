//
//  LocationAddressViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationAddressViewController: UIViewController {
    
    // MARK: - Properties
    
    var locationName: String?
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

    @IBOutlet weak var signUpElementsStackView: UIStackView!
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var addressLine1LabelOutlet: UILabel!
    @IBOutlet weak var addressLine1TextField: UITextField!
    @IBOutlet weak var addressLine2LabelOutlet: UILabel!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var cityLabelOutlet: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateLabelOutlet: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeLabelOutlet: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLine1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        addressLine2TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        cityTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter city", attributes: beltBuilder.avenirFont)
        stateTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter state", attributes: beltBuilder.avenirFont)
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter zip code", attributes: beltBuilder.avenirFont)
        
        addressLine1TextField.delegate = self
        addressLine2TextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self
        
    }
    
    
    // MARK: - Actions
    
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
            
            // warning to user where welcome instructions text changes to red
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if addressLine1TextField.text == "" {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.errorAvenirFont)
                
                //                firstNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
                
                //                firstNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if cityTextField.text == "" {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter city", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter city", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if stateTextField.text == "" {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter state", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter state", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if zipCodeTextField.text == "" {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter zip code", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter zip code", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            // save not allowed, so we exit function
            return
        }
        
        // reset textField placeholder text color to gray upon succesful save
        addressLine1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        addressLine2TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        cityTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        stateTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        // reset welcome instructions text color and message upon succesful save
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.blackBeltBlack
        welcomeInstructionsLabelOutlet.text = "please enter the following"

        
        // Location update profile info
        updateLocationInfo()
        
        self.returnToLocationInfo()
        
        print("update location address: \(LocationModelController.shared.locations[0].addressLine1) \n\(LocationModelController.shared.locations[0].addressLine2) \n\(LocationModelController.shared.locations[0].city) \(LocationModelController.shared.locations[0].state) \(LocationModelController.shared.locations[0].zipCode)")
        
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
            
            // warning to user where welcome instructions text changes to red
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if addressLine1TextField.text == "" {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.errorAvenirFont)
                
                //                firstNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                addressLine1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
                
                //                firstNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if cityTextField.text == "" {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter city", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                cityTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter city", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if stateTextField.text == "" {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter state", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                stateTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter state", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if zipCodeTextField.text == "" {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter zip code", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter zip code", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            // save not allowed, so we exit function
            return
        }
        
        // reset textField placeholder text color to gray upon succesful save
        addressLine1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        addressLine2TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        cityTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        stateTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter address", attributes: beltBuilder.avenirFont)
        // reset welcome instructions text color and message upon succesful save
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.blackBeltBlack
        welcomeInstructionsLabelOutlet.text = "please enter the following"
        
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
        
        // required fields
        let addressLine1 = addressLine1TextField.text
        let city = cityTextField.text
        let state = stateTextField.text
        let zipCode = zipCodeTextField.text
        
        // not required field
        let addressLine2 = addressLine2TextField.text
        
        // pass data to destViewController
        destViewController.locationName = locationName
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
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension LocationAddressViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateLocationInfo() {
        if addressLine1TextField.text != "" && cityTextField.text != "" && stateTextField.text != "" && zipCodeTextField.text != "" {
            
            guard let location = locationToEdit else { return }
            
            LocationModelController.shared.update(location: location, active: nil, locationPic: nil, locationName: nil, addressLine1: addressLine1TextField.text, addressLine2: addressLine2TextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: zipCodeTextField.text, phone: nil, website: nil, email: nil, social1: nil, social2: nil, social3: nil)
        }
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
        
        guard let locationToEdit = locationToEdit else {
            return
        }
        
        welcomeLabeOutlet.text = "Location: \(locationToEdit.locationName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in location editing mode"
        
        addressLine1TextField.text = locationToEdit.addressLine1
        addressLine2TextField.text = locationToEdit.addressLine2
        cityTextField.text = locationToEdit.city
        stateTextField.text = locationToEdit.state
        zipCodeTextField.text = locationToEdit.zipCode
        
        
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
