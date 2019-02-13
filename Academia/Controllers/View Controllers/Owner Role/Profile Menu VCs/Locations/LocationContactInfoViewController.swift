//
//  LocationContactInfoViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationContactInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var locationName: String?
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

    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var websiteLabelOutlet: UILabel!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var emailOutlet: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    
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
        
        phoneTextField.delegate = self
        websiteTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        updateLocationInfo()
        
        self.returnToLocationInfo()
        
        print("update location address: \(LocationModelController.shared.locations[0].phone) \n\(String(describing: LocationModelController.shared.locations[0].website)) \n\(String(describing: LocationModelController.shared.locations[0].email))")
        
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
        
        // run check to see is there is phone, mobile, email
        guard let phone = phoneTextField.text, phoneTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        // not a required field
        let website = websiteTextField.text
        
        guard let email = emailTextField.text, emailTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        // pass data to destViewController
        destViewController.locationName = locationName
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
    }
}


// MARK: - Editing Mode for Individual Location case specific setup
extension LocationContactInfoViewController {
    
    // Update Function for case where want to update location info without a segue
    func updateLocationInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            guard let location = locationToEdit else { return }
            
            LocationModelController.shared.update(location: location, active: nil, locationPic: nil, locationName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: phoneTextField.text, website: websiteTextField.text, email: emailTextField.text, social1: nil, social2: nil, social3: nil)
        }
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
        
        guard let locationToEdit = locationToEdit else {
            return
        }
        
        welcomeLabeOutlet.text = "Location: \(locationToEdit.locationName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in location editing mode"
        
        phoneTextField.text = locationToEdit.phone
        websiteTextField.text = locationToEdit.website
        emailTextField.text = locationToEdit.email
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
