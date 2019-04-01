//
//  LocationPicAndNameViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// TODO: setup activeSwitch to toggle active property

import UIKit

class LocationPicAndNameViewController: UIViewController {
    
    // MARK: - Properties
    
    var locationName: String?
    var locationPic: UIImage?
    var active = true
    
    var inEditingMode: Bool?
    var locationToEdit: Location?
    
    let beltBuilder = BeltBuilder()
    let imagePickerController = UIImagePickerController()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var locationNameAndPicLabelOutlet: UILabel!
    @IBOutlet weak var locationPicImageViewOutlet: UIImageView!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var locationNameTextField: UITextField!
    
    // CoreData properties
    var location: LocationCD?
    var locationCDToEdit: LocationCD?

    
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
        
        locationNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationName.rawValue, attributes: beltBuilder.avenirFont)
        
        locationNameTextField.delegate = self
        
        if active == true {
            activeSwitch.isOn = true
        } else {
            activeSwitch.isOn = false
        }
        
        // instantiate tapGestureRecognizer for the profilePicImageViewOutet
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LocationPicAndNameViewController.profilePicImageTapped))
        locationPicImageViewOutlet.addGestureRecognizer(tapGestureRecognizer)
        locationPicImageViewOutlet.isUserInteractionEnabled = true
        
        imagePickerController.delegate = self
    }
    
    
    // MARK: - Actions
    @IBAction func tapAnywhereToDismissKeyboardTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        // dismiss keyboard when leaving VC scene
        if locationNameTextField.isFirstResponder {
            locationNameTextField.resignFirstResponder()
        }
    }
    
    @IBAction func activeSwitchToggled(_ sender: UISwitch) {
        active = !active
        
        print("LocationPicAndNameVC active property: \(active)")
    }
    
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if locationNameTextField.isFirstResponder {
            locationNameTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if locationNameTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            locationNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationName.rawValue, attributes: beltBuilder.errorAvenirFont)
            
            // save not allowed, so we exit function
            return
        }
    
        // Location update profile info
        if locationNameTextField.text != "" && locationPicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
            
            updateLocationInfo()
            
            self.returnToLocationInfo()
            
            print("update location name: \(locationCDToEdit?.locationName ?? "")")
        }
        
        inEditingMode = false
        
        // reset textField placeholder text to gray upon succesful save
        locationNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationName.rawValue, attributes: beltBuilder.avenirFont)
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if locationNameTextField.isFirstResponder {
            locationNameTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if locationNameTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            locationNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationName.rawValue, attributes: beltBuilder.errorAvenirFont)
            
            // save not allowed, so we exit function
            return
        }
        
        // programmatically performing the segue
        
        print("to address segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerLocationWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toLocationAddress") as! LocationAddressViewController
        
        // reset textField placeholder text to gray upon succesful save
        locationNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationName.rawValue, attributes: beltBuilder.avenirFont)
        
        // run check to see is there is firstName, lastName, and profilePic
        guard let locationName = locationNameTextField.text else { return }
        
        guard let locationPic = locationPicImageViewOutlet.image else { return }
        
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
        destViewController.locationName = locationName
        destViewController.locationPic = locationPic
        destViewController.active = active
        
        destViewController.inEditingMode = inEditingMode
        destViewController.locationToEdit = locationToEdit
        
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateLocationInfo()
        destViewController.locationCDToEdit = locationCDToEdit
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension LocationPicAndNameViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateLocationInfo() {
        // Location update profile info
        if locationNameTextField.text != "" && locationPicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
            
            // CoreData LocationCD update info
            guard let locationCD = locationCDToEdit else { return }
            
            // convert profilePic to Data
            let locationPic = locationPicImageViewOutlet.image
            if let locationPicData = locationPic?.jpegData(compressionQuality: 1) {
                
                LocationCDModelController.shared.update(location: locationCD, locationPic: locationPicData, locationName: locationNameTextField.text, address: nil, phone: nil, website: nil, email: nil, socialLinks: nil)
            }
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            locationEditingSetup()
        }
        
        print("LocationPicAndNameVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func locationEditingSetup() {
        
        guard let locationCDToEdit = locationCDToEdit else {
            return
        }
        
        self.title = locationCDToEdit.locationName
        
        locationNameAndPicLabelOutlet.text = "Location: \(locationCDToEdit.locationName ?? "")"
        
        // profile pic imageView
        if let profilePicData = locationCDToEdit.locationPic {
            
            locationPicImageViewOutlet.image = UIImage(data: profilePicData)
        }
        
        locationNameTextField.text = locationCDToEdit.locationName
    }
}



// MARK: - UINavigationControllerDelegate
extension LocationPicAndNameViewController: UINavigationControllerDelegate {
}

// MARK: - UIImagePickerControllerDelegate
extension LocationPicAndNameViewController: UIImagePickerControllerDelegate {
    
    @objc func profilePicImageTapped() {
        // brings up the camera to snap a profile pic
        presentImagePicker()
    }
    
    func presentImagePicker() {
        
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Image",
                                                       message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        
        present(imagePickerActionSheet, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let scaledImage = selectedPhoto.scaleImage(640) {
            
            dismiss(animated: true, completion: {
                self.locationPicImageViewOutlet.image = scaledImage
                self.locationPic = scaledImage
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension LocationPicAndNameViewController: UITextFieldDelegate {
    
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
        
        if textField == locationNameTextField {
            locationNameTextField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}

