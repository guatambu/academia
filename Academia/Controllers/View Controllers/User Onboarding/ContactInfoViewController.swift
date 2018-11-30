//
//  ContactInfoViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {

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
    
    var inEditingMode: Bool?
    var userToEdit: Any?
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mobileLabelOutlet: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailOutlet: UILabel!
    @IBOutlet weak var emailTextField: UITextField!

    
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
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
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
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toEmergencyContactInfo") as! EmergencyContactViewController
        
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
        let mobile = mobileTextField.text
        
        guard let email = emailTextField.text, emailTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
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
        
        destViewController.inEditingMode = inEditingMode
        destViewController.userToEdit = userToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in onbaording after lunch
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
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension ContactInfoViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            guard let owner = userToEdit as? Owner else { return }
            
            OwnerModelController.shared.updateProfileInfo(owner: owner, isInstructor: nil, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
        }
    }
    
    func updateKidStudentInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            guard let kidStudent = userToEdit as? KidStudent else { return }
            
            KidStudentModelController.shared.updateProfileInfo(kidStudent: kidStudent, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, parentGuardian: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
        }
    }
    
    func updateAdultStudentInfo() {
        if phoneTextField.text != "" && emailTextField.text != "" {
            
            guard let adultStudent = userToEdit as? AdultStudent else { return }
            
            AdultStudentModelController.shared.updateProfileInfo(adultStudent: adultStudent, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
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
        }
        
        print(inEditingMode)
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerToEdit = userToEdit as? Owner else {
            return
        }
        
        welcomeLabeOutlet.text = "Welcome \(ownerToEdit.firstName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
        
        phoneTextField.text = ownerToEdit.phone
        mobileTextField.text = ownerToEdit.mobile
        emailTextField.text = ownerToEdit.email
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? KidStudent else {
            return
        }
        
        welcomeLabeOutlet.text = "Welcome \(kidToEdit.firstName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
        
        phoneTextField.text = kidToEdit.phone
        mobileTextField.text = kidToEdit.mobile
        emailTextField.text = kidToEdit.email
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? AdultStudent else {
            return
        }
        
        welcomeLabeOutlet.text = "Welcome \(adultToEdit.firstName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
        
        phoneTextField.text = adultToEdit.phone
        mobileTextField.text = adultToEdit.mobile
        emailTextField.text = adultToEdit.email
    }
}

