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
    var active: Bool?
    
    var inEditingMode: Bool?
    var locationToEdit: Location?
    
    let imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var locationPicImageViewOutlet: UIImageView!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var locationNameLabelOutlet: UILabel!
    @IBOutlet weak var locationNameTextField: UITextField!

    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // instantiate tapGestureRecognizer for the profilePicImageViewOutet
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TakeProfilePicViewController.profilePicImageTapped))
        locationPicImageViewOutlet.addGestureRecognizer(tapGestureRecognizer)
        locationPicImageViewOutlet.isUserInteractionEnabled = true
        
        imagePickerController.delegate = self
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
    
        // Location update profile info
        if locationNameTextField.text != "" && locationPicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
            
            updateLocationInfo()
            
            self.returnToLocationInfo()
            
            print("update location name: \(LocationModelController.shared.locations[0].locationName)")
        }
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        print("to address segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toLocationPicAndName") as! LocationPicAndNameViewController
        
        // run check to see is there is firstName, lastName, and profilePic
        guard let locationName = locationNameTextField.text, locationNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let locationPic = locationPicImageViewOutlet.image else { return }
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.locationName = locationName
        destViewController.locationPic = locationPic
        
        destViewController.inEditingMode = inEditingMode
        destViewController.locationToEdit = locationToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in onbaording after lunch
        updateLocationInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension LocationPicAndNameViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateLocationInfo() {
        guard let location = locationToEdit else { return }
        // Owner update profile info
        if locationNameTextField.text != "" && locationPicImageViewOutlet.image != UIImage(contentsOfFile: "user_placeholder") {
            LocationModelController.shared.update(location: location, active: active, locationPic: locationPic, locationName: locationName, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, website: nil, email: nil, social1: nil, social2: nil, social3: nil)
            print("update owner name: \(OwnerModelController.shared.owners[0].firstName) \(OwnerModelController.shared.owners[0].lastName)")
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            locationEditingSetup()
        }
        
        print("TakeProfilePicVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func locationEditingSetup() {
        
        guard let locationToEdit = locationToEdit else {
            return
        }
        
        welcomeLabeOutlet.text = "Welcome \(locationToEdit.locationName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
        
        locationPicImageViewOutlet.image = locationToEdit.locationPic
        locationNameTextField.text = locationToEdit.locationName
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

