//
//  BirthdayViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 11/21/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {
    
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
    
    var inEditingMode: Bool?
    
    var userToEdit: Any?
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var whenIsYourBirthdayLabelOutlet: UILabel!
    
    // birthday date pickerView
    @IBOutlet weak var birthdayDatePickerView: UIDatePicker!

    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    @IBOutlet weak var firstProgressDotOutlet: DesignableView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    // TODO:  set up all the rest of the editing mode funcitonality for this and future VCs in owner profile eidting mode flow
    
    override func viewWillAppear(_ animated: Bool) {
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
        
        // set editing mode for each user case scenario
        if let isOwner = isOwner {
            if isOwner {
                ownerEditingSetup(userToEdit: userToEdit)
            }
        } else if let isKid = isKid {
            if isKid {
                kidStudentEditingSetup(userToEdit: userToEdit)
            } else {
                adultStudentEditingSetup(userToEdit: userToEdit)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let isOwner = isOwner else { return }
        
        if isOwner{
            welcomeLabeOutlet.text = "Welcome Owner"
        } else {
            welcomeLabeOutlet.text = "Welcome New Student"
        }
        
        birthdayDatePickerView.addTarget(self, action: #selector(birthdayPicked(_:)), for: UIControl.Event.valueChanged)

    }
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        if let isOwner = isOwner {
            if isOwner {
                // Owner update profile info
                if birthdate != nil {
                    
                    OwnerModelController.shared.updateProfileInfo(owner: OwnerModelController.shared.owners[0], isInstructor: nil, birthdate: birthdate, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
                self.returnToOwnerProfile()
                
            }
        } else if let isKid = isKid {
            if isKid{
                // kidStudent update profile info
                if birthdate != nil {
                    KidStudentModelController.shared.updateProfileInfo(kidStudent: KidStudentModelController.shared.kids[0],birthdate: birthdate, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, parentGuardian: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
            } else {
                // adultStudent update profile info
                if birthdate != nil {
                    AdultStudentModelController.shared.updateProfileInfo(adultStudent: AdultStudentModelController.shared.adults[0], birthdate: birthdate, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
            }
        }
        
        inEditingMode = false
    }
    
    @IBAction func birthdayPicked(_ sender: UIDatePicker) {
        
        
        birthdate = birthdayDatePickerView.date
        
        print("\(String(describing: birthdate))")
    }

    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserNameBelt") as! NameAndBeltViewController
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
        destViewController.birthdate = birthdate
        
        destViewController.inEditingMode = inEditingMode
        destViewController.userToEdit = userToEdit
        
    }
}




// MARK: - Editing Mode for Individual User case specific setup
extension BirthdayViewController {
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            if let isOwner = isOwner {
                if isOwner {
                    ownerEditingSetup(userToEdit: userToEdit)
                }
            } else if let isKid = isKid {
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
        
        print("\(ownerToEdit.birthdate)")
        birthdayDatePickerView.date = ownerToEdit.birthdate
        
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? KidStudent else {
            return
        }
        
        welcomeLabeOutlet.text = "Welcome \(kidToEdit.firstName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"

        
        birthdayDatePickerView.setDate(kidToEdit.birthdate, animated: true)
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? AdultStudent else {
            return
        }
        
        welcomeLabeOutlet.text = "Welcome \(adultToEdit.firstName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
    
        birthdayDatePickerView.setDate(adultToEdit.birthdate, animated: true)
    }
}
