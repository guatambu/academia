//
//  LocationSocialLinksViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationSocialLinksViewController: UIViewController {
    
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
    var social1: String?
    var social2: String?
    var social3: String?
    
    var inEditingMode: Bool?
    var locationToEdit: Location?
    
    let beltBuilder = BeltBuilder()

    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
//    @IBOutlet weak var socialLink1LabelOutlet: UILabel!
    @IBOutlet weak var socialLink1TextField: UITextField!
//    @IBOutlet weak var socialLink2LabelOutlet: UILabel!
    @IBOutlet weak var socialLink2TextField: UITextField!
//    @IBOutlet weak var socialLink3Outlet: UILabel!
    @IBOutlet weak var socialLink3TextField: UITextField!
    
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
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
    
        socialLink1TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter Instagram link", attributes: beltBuilder.avenirFont)
        socialLink2TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter facebook link", attributes: beltBuilder.avenirFont)
        socialLink3TextField.attributedPlaceholder = NSAttributedString(string: "tap to enter twitter link", attributes: beltBuilder.avenirFont)
        
        socialLink1TextField.delegate = self
        socialLink2TextField.delegate = self
        socialLink3TextField.delegate = self
        
        // make sure the next button is displayed by default when not inEditingMode
        nextButtonOutlet.isEnabled = true
        nextButtonOutlet.isHidden = false
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if socialLink1TextField.isFirstResponder {
            socialLink1TextField.resignFirstResponder()
        } else if socialLink2TextField.isFirstResponder {
            socialLink2TextField.resignFirstResponder()
        } else if socialLink3TextField.isFirstResponder {
            socialLink3TextField.resignFirstResponder()
        }
        
        // Location update profile info
        updateLocationInfo()
        
        self.returnToLocationInfo()
        
        print("update location social links (if any): \(String(describing: LocationModelController.shared.locations[0].social1)) \n\(String(describing: LocationModelController.shared.locations[0].social2)) \n\(String(describing: LocationModelController.shared.locations[0].social3))")
        
        inEditingMode = false
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if socialLink1TextField.isFirstResponder {
            socialLink1TextField.resignFirstResponder()
        } else if socialLink2TextField.isFirstResponder {
            socialLink2TextField.resignFirstResponder()
        } else if socialLink3TextField.isFirstResponder {
            socialLink3TextField.resignFirstResponder()
        } 
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerLocationWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toReviewAndCreateLocation") as! ReviewAndCreateLocationViewController
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
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
        destViewController.social1 = socialLink1TextField.text
        destViewController.social2 = socialLink2TextField.text
        destViewController.social3 = socialLink3TextField.text
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateLocationInfo()
    }
}


// MARK: - Editing Mode for Individual Location case specific setup
extension LocationSocialLinksViewController {
    
    // Update Function for case where want to update location info without a segue
    func updateLocationInfo() {
        
        guard let location = locationToEdit else { return }
        
        LocationModelController.shared.update(location: location, active: nil, locationPic: nil, locationName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, website: nil, email: nil, social1: socialLink1TextField.text, social2: socialLink2TextField.text, social3: socialLink3TextField.text)
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            locationEditingSetup(userToEdit: locationToEdit)
        }
        
        print("LocationSocialLinksVC -> inEditingMode = \(inEditingMode)")
        
        // hide the next button in favor of the save button being the only choice besides returning tho the previous VC via navigation stack
        nextButtonOutlet.isHidden = true
        nextButtonOutlet.isEnabled = false
    }
    
    // location setup for editing mode
    func locationEditingSetup(userToEdit: Location?) {
        
        guard let locationToEdit = locationToEdit else {
            return
        }
        
        welcomeLabeOutlet.text = "Location: \(locationToEdit.locationName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in location editing mode"
        
        socialLink1TextField.text = locationToEdit.social1
        socialLink2TextField.text = locationToEdit.social2
        socialLink3TextField.text = locationToEdit.social3
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension LocationSocialLinksViewController: UITextFieldDelegate {
    
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
        
        if textField == socialLink1TextField {
            socialLink2TextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == socialLink2TextField {
            socialLink3TextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == socialLink3TextField {
            socialLink3TextField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}
