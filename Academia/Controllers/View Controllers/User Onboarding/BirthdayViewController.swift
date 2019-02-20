//
//  BirthdayViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/21/18.
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
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var whenIsYourBirthdayLabelOutlet: UILabel!
    // birthday date pickerView
    @IBOutlet weak var birthdayDatePickerView: UIDatePicker!

    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    @IBOutlet weak var firstProgressDotOutlet: DesignableView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set birthdayPickerView maxDate to today current date
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar(identifier: .gregorian)
        dateComponents.year = -3 // students have to be at least 3 years old
        birthdayDatePickerView.maximumDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        birthdayDatePickerView.addTarget(self, action: #selector(birthdayPicked(_:)), for: UIControl.Event.valueChanged)

    }
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        guard birthdate != nil else {
            // warning to user where welcome instructions text changes to red
            whenIsYourBirthdayLabelOutlet.textColor = UIColor.red

            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            return
        }
        
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
    
    @IBAction func birthdayPicked(_ sender: UIDatePicker) {
        
        birthdate = birthdayDatePickerView.date

        print("\(String(describing: birthdate))")
    }

    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        guard birthdate != nil else {
            // warning to user where welcome instructions text changes to red
            whenIsYourBirthdayLabelOutlet.textColor = UIColor.red

            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            return
        }
        
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
        
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        
        destViewController.inEditingMode = inEditingMode
        destViewController.userToEdit = userToEdit
        
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
    }
}




// MARK: - Editing Mode for Individual User case specific setup
extension BirthdayViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        guard let owner = userToEdit as? Owner else { return }
        // Owner update profile info
        if birthdate != nil {
            OwnerModelController.shared.updateProfileInfo(owner: owner, isInstructor: nil, birthdate: birthdate, groups: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
        }
        print("update owner name: \(OwnerModelController.shared.owners[0].firstName) \(OwnerModelController.shared.owners[0].lastName)")
    }
    
    func updateKidStudentInfo() {
        guard let kidStudent = userToEdit as? KidStudent else { return }
        // kidStudent update profile info
        if birthdate != nil {
            KidStudentModelController.shared.updateProfileInfo(kidStudent: kidStudent,birthdate: birthdate, groups: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, parentGuardian: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
        }
    }
    
    func updateAdultStudentInfo() {
        guard let adultStudent = userToEdit as? AdultStudent else { return }
        // adultStudent update profile info
        if birthdate != nil {
            AdultStudentModelController.shared.updateProfileInfo(adultStudent: adultStudent, birthdate: birthdate, groups: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
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
        
        print("BirthdayVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerToEdit = userToEdit as? Owner else { return }
        
        whenIsYourBirthdayLabelOutlet.text = "Welcome \(ownerToEdit.firstName)"
        
        print("BirthdayVC birthdate choice: \(ownerToEdit.birthdate)")
        birthdayDatePickerView.date = ownerToEdit.birthdate
        
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? KidStudent else { return }
        
        whenIsYourBirthdayLabelOutlet.text = "Welcome \(kidToEdit.firstName)"

        print("BirthdayVC birthdate choice: \(kidToEdit.birthdate)")
        birthdayDatePickerView.date = kidToEdit.birthdate
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? AdultStudent else { return }
        
        whenIsYourBirthdayLabelOutlet.text = "Welcome \(adultToEdit.firstName)"
    
        print("BirthdayVC birthdate choice: \(adultToEdit.birthdate)")
        birthdayDatePickerView.date = adultToEdit.birthdate
    }
}
