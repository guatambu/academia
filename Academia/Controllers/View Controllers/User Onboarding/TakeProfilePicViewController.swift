//
//  TakeProfilePicViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class TakeProfilePicViewController: UIViewController {

    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var parentGuardian: String?
    var profilePic: UIImage?
    
    var inEditingMode: Bool?
    var userCDToEdit: Any?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()
    let imagePickerController = UIImagePickerController()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var nameAndProfilePicLabeltOutlet: UILabel!
    @IBOutlet weak var profilePicImageViewOutlet: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var parentGuardianTextField: UITextField!
    
    // CoreData Properties
    var ownerCD: OwnerCD?
    var studentAdultCD: StudentAdultCD?
    var studentKidCD: StudentKidCD?
    var groupCD: GroupCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
        
        print("isKid in TakeProfilePicVC: \(String(describing: isKid))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.avenirFont
        
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.avenirFont)
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.avenirFont)
        parentGuardianTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.parentGuardian.rawValue, attributes: beltBuilder.avenirFont)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        parentGuardianTextField.delegate = self
        
        // instantiate tapGestureRecognizer for the profilePicImageViewOutet
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TakeProfilePicViewController.profilePicImageTapped))
        profilePicImageViewOutlet.addGestureRecognizer(tapGestureRecognizer)
        profilePicImageViewOutlet.isUserInteractionEnabled = true
        
        imagePickerController.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    // MARK: - Actions
    
    @IBAction func tapAnywhereToDismissKeyboardTapped(_ sender: UITapGestureRecognizer) {
            view.endEditing(true)
        // dismiss keyboard when leaving VC scene
        if firstNameTextField.isFirstResponder {
            firstNameTextField.resignFirstResponder()
        } else if lastNameTextField.isFirstResponder {
            lastNameTextField.resignFirstResponder()
        } else if parentGuardianTextField.isFirstResponder {
            parentGuardianTextField.resignFirstResponder()
        }
    }
    
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if firstNameTextField.isFirstResponder {
            firstNameTextField.resignFirstResponder()
        } else if lastNameTextField.isFirstResponder {
            lastNameTextField.resignFirstResponder()
        } else if parentGuardianTextField.isFirstResponder {
            parentGuardianTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if firstNameTextField.text == "" || lastNameTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if firstNameTextField.text == "" {
                
                firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if lastNameTextField.text == "" {
                
                lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            // save not allowed, so we exit function
            return
        }
        
        if let isOwner = isOwner {
            
            if isOwner {
                // Owner update profile info
                if firstNameTextField.text != "" && lastNameTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
                    
                    updateOwnerInfo()
                    
                    self.returnToOwnerInfo()
                
                } else {
                    // warning to user where welcome instructions text changes to red
                    self.firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.errorAvenirFont)
                    self.lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.errorAvenirFont)
                    // fire haptic feedback for error
                    hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                    hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                }
            }
        }
        if let isKid = isKid {
            
            if isKid{
                // kidStudent update profile info
                if firstNameTextField.text != "" && lastNameTextField.text != "" && parentGuardianTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
                    
                    updateKidStudentInfo()
                    
                    self.returnToStudentInfo()
                }
            } else {
                // adultStudent update profile info
                if firstNameTextField.text != "" && lastNameTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
                    
                    updateAdultStudentInfo()
                    
                    self.returnToStudentInfo()
                }
            }
        }

        inEditingMode = false
        
        // reset textfield placeholder text color to gray upon succesful save
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.avenirFont)
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.avenirFont)
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if firstNameTextField.isFirstResponder {
            firstNameTextField.resignFirstResponder()
        } else if lastNameTextField.isFirstResponder {
            lastNameTextField.resignFirstResponder()
        } else if parentGuardianTextField.isFirstResponder {
            parentGuardianTextField.resignFirstResponder()
        }
    
        // programmatically performing the segue
    
        print("to birthday segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserBirthday") as! BirthdayViewController
    
        // check for required information being left blank by user
        if firstNameTextField.text == "" || lastNameTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if firstNameTextField.text == "" {
                
                firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            if lastNameTextField.text == "" {
                
                lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            } else {
                
                lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.avenirFont)
                
            }
            
            // save not allowed, so we exit function
            return
        }
        
        guard let profilePic = profilePicImageViewOutlet.image else { return }
        
        // required fields
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        // not a required field
        let parentGuardian = parentGuardianTextField.text
    
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
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.parentGuardian = parentGuardian
        destViewController.profilePic = profilePic
        
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
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.firstName.rawValue, attributes: beltBuilder.avenirFont)
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.lastName.rawValue, attributes: beltBuilder.avenirFont)

    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension TakeProfilePicViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        
        // Owner update profile info
        if firstNameTextField.text != "" && lastNameTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
            
            // CoreData Owner update profile info
            guard let ownerCD = userCDToEdit as? OwnerCD else { return }
            
            // convert profilePic to Data
            let profilePic = profilePicImageViewOutlet.image
            if let profilePicData = profilePic?.jpegData(compressionQuality: 1) {
                
                OwnerCDModelController.shared.update(owner: ownerCD, isInstructor: nil, birthdate: nil, mostRecentPromotion: nil, belt: nil, profilePic: profilePicData, username: nil, password: nil, firstName: firstNameTextField.text, lastName: lastNameTextField.text, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
            }
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
    }
    
    func updateKidStudentInfo() {
        
        if firstNameTextField.text != "" && lastNameTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
        
            // CoreData Owner update profile info
            guard let studentKidCD = userCDToEdit as? StudentKidCD else { return }
            
            // convert profilePic to Data
            let profilePic = profilePicImageViewOutlet.image
            if let profilePicData = profilePic?.jpegData(compressionQuality: 1) {
                
                StudentKidCDModelController.shared.update(studentKid: studentKidCD, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: profilePicData, username: nil, password: nil, firstName: firstNameTextField.text, lastName: lastNameTextField.text, parentGuardian: parentGuardianTextField.text, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
            }
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
    }
    
    func updateAdultStudentInfo() {
        
        // adultStudent update profile info
        if firstNameTextField.text != "" && lastNameTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
        
            // CoreData Owner update profile info
            guard let studentAdultCD = userCDToEdit as? StudentAdultCD else { return }
            
            // convert profilePic to Data
            let profilePic = profilePicImageViewOutlet.image
            if let profilePicData = profilePic?.jpegData(compressionQuality: 1) {
                
                StudentAdultCDModelController.shared.update(studentAdult: studentAdultCD, isInstructor: nil, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: profilePicData, username: nil, password: nil, firstName: firstNameTextField.text, lastName: lastNameTextField.text, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
            }
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
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
        
        print("TakeProfilePicVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerCDToEdit = userToEdit as? OwnerCD else {
            return
        }
        
        nameAndProfilePicLabeltOutlet.text = "Welcome \(ownerCDToEdit.firstName ?? "")"
        
        // unwrap the profilePic? image data
        if let profilePicData = ownerCDToEdit.profilePic {
            // assign the generated image to the UI
            profilePicImageViewOutlet.image = UIImage(data: profilePicData)
        }
        firstNameTextField.text = ownerCDToEdit.firstName
        lastNameTextField.text = ownerCDToEdit.lastName
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? StudentKidCD else {
            return
        }
        
        nameAndProfilePicLabeltOutlet.text = "Welcome \(kidToEdit.firstName ?? "")"
        
        // unwrap the profilePic? image data
        if let profilePicData = kidToEdit.profilePic {
            // assign the generated image to the UI
            profilePicImageViewOutlet.image = UIImage(data: profilePicData)
        }
        firstNameTextField.text = kidToEdit.firstName
        lastNameTextField.text = kidToEdit.lastName
        parentGuardianTextField.text = kidToEdit.parentGuardian
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? StudentAdultCD else {
            return
        }
        
        nameAndProfilePicLabeltOutlet.text = "Welcome \(adultToEdit.firstName ?? "")"
        
        // unwrap the profilePic? image data
        if let profilePicData = adultToEdit.profilePic {
            // assign the generated image to the UI
            profilePicImageViewOutlet.image = UIImage(data: profilePicData)
        }
        firstNameTextField.text = adultToEdit.firstName
        lastNameTextField.text = adultToEdit.lastName
    }
}


// MARK: - UINavigationControllerDelegate
extension TakeProfilePicViewController: UINavigationControllerDelegate {
}

// MARK: - UIImagePickerControllerDelegate
extension TakeProfilePicViewController: UIImagePickerControllerDelegate {
    
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
            let scaledImage = selectedPhoto.scaleImage(800) {
            
            dismiss(animated: true, completion: {
                self.profilePicImageViewOutlet.image = scaledImage
                self.profilePic = scaledImage
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIImage extension
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension TakeProfilePicViewController: UITextFieldDelegate {
    
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
        
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == lastNameTextField {
            parentGuardianTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == parentGuardianTextField {
            textField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}

// MARK: Data to UIImageextension

// To convert back to Image from Data you just need to use UIImage(data:) initializer:
extension Data {
    var uiImage: UIImage? {
        return UIImage(data: self)
    }
}


