//
//  TakeProfilePicViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

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
    var userToEdit: Any?
    
    let imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var profilePicImageViewOutlet: UIImageView!
    @IBOutlet weak var firstNameLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabelOutlet: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var parentGuardianLabelOutlet: UILabel!
    @IBOutlet weak var parentGuardianTextField: UITextField!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let isOwner = isOwner else { return }
        
        if isOwner{
            welcomeLabeOutlet.text = "Welcome Owner"
        } else {
            welcomeLabeOutlet.text = "Welcome New Student"
        }
        
        // instantiate tapGestureRecognizer for the profilePicImageViewOutet
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TakeProfilePicViewController.profilePicImageTapped))
        profilePicImageViewOutlet.addGestureRecognizer(tapGestureRecognizer)
        profilePicImageViewOutlet.isUserInteractionEnabled = true
        
        imagePickerController.delegate = self
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        if let isOwner = isOwner {
            if isOwner {
                // Owner update profile info
                if firstNameTextField.text != "" && lastNameTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
                    
                    OwnerModelController.shared.updateProfileInfo(owner: OwnerModelController.shared.owners[0], isInstructor: nil, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: profilePicImageViewOutlet.image, username: nil, firstName: firstNameTextField.text, lastName: lastNameTextField.text, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
            }
        } else if let isKid = isKid {
            if isKid{
                // kidStudent update profile info
                if firstNameTextField.text != "" && lastNameTextField.text != "" && parentGuardianTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
                    KidStudentModelController.shared.updateProfileInfo(kidStudent: KidStudentModelController.shared.kids[0], birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: profilePicImageViewOutlet.image, username: nil, firstName: firstNameTextField.text, lastName: lastNameTextField.text, parentGuardian: parentGuardianTextField.text, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
            } else {
                // adultStudent update profile info
                if firstNameTextField.text != "" && lastNameTextField.text != "" && profilePicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
                    AdultStudentModelController.shared.updateProfileInfo(adultStudent: AdultStudentModelController.shared.adults[0], birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: profilePicImageViewOutlet.image, username: nil, firstName: firstNameTextField.text, lastName: lastNameTextField.text, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
            }
        }

        inEditingMode = false
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
    
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserBirthday") as! BirthdayViewController
    
        // run check to see is there is firstName, lastName, and profilePic
        guard let firstName = firstNameTextField.text, firstNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let lastName = lastNameTextField.text, lastNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let profilePic = profilePic else { return }
        
        let parentGuardian = parentGuardianTextField.text
            
        
    
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
    
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.parentGuardian = parentGuardian
        destViewController.profilePic = profilePic
    }

    
    // MARK: - Helper Functions
    
    @objc func profilePicImageTapped() {
        
        // brings up the camera to snap a profile pic
        presentImagePicker()

    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
        }
        
        print(inEditingMode)
    }
}


// MARK: - UINavigationControllerDelegate
extension TakeProfilePicViewController: UINavigationControllerDelegate {
}

// MARK: - UIImagePickerControllerDelegate
extension TakeProfilePicViewController: UIImagePickerControllerDelegate {
    
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
