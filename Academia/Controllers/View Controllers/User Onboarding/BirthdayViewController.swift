//
//  BirthdayViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/21/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

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
    var userCDToEdit: Any?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var whenIsYourBirthdayLabelOutlet: UILabel!
    // birthday date pickerView
    @IBOutlet weak var birthdayDatePickerView: UIDatePicker!

    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    @IBOutlet weak var firstProgressDotOutlet: DesignableView!
    
    @IBOutlet weak var thisIsOptionalLabelOutlet: UILabel!
    
    @IBOutlet weak var addAnyTimeLabelOutlet: UILabel!
    
    // CoreData Properties
    var owner: OwnerCD?
    var studentAdult: StudentAdultCD?
    var studentKid: StudentKidCD?
    var groupCD: GroupCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
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
        
        // reset instructions text changes to black
        whenIsYourBirthdayLabelOutlet.textColor = beltBuilder.blackBeltBlack
    }
    
    @IBAction func birthdayPicked(_ sender: UIDatePicker) {
        
        birthdate = birthdayDatePickerView.date

        print("\(String(describing: birthdate))")
    }

    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        // reset instructions text changes to black
        whenIsYourBirthdayLabelOutlet.textColor = beltBuilder.blackBeltBlack
        
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
        destViewController.birthdate = birthdate
        
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
    }
}




// MARK: - Editing Mode for Individual User case specific setup
extension BirthdayViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        
        // CoreData Owner update profile info
        guard let ownerCD = userCDToEdit as? OwnerCD else { return }
        
        if birthdate != nil {
            OwnerCDModelController.shared.update(owner: ownerCD, isInstructor: nil, birthdate: birthdate, mostRecentPromotion: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
        } else {
            print("EROR: birthdate value is nil.  BirthdayViewController.swift -> updateAdultStudentInfo() - line 223.")
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateKidStudentInfo() {
        
        // CoreData Owner update profile info
        guard let studentKidCD = userCDToEdit as? StudentKidCD else { return }
        
        if birthdate != nil {
            StudentKidCDModelController.shared.update(studentKid: studentKidCD, birthdate: birthdate, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, parentGuardian: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
        } else {
            print("EROR: birthdate value is nil.  BirthdayViewController.swift -> updateAdultStudentInfo() - line 240.")
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateAdultStudentInfo() {
        
        // CoreData Owner update profile info
        guard let studentAdultCD = userCDToEdit as? StudentAdultCD else { return }
        
        if birthdate != nil {
            StudentAdultCDModelController.shared.update(studentAdult: studentAdultCD, isInstructor: nil, birthdate: birthdate, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
        } else {
            print("EROR: birthdate value is nil.  BirthdayViewController.swift -> updateAdultStudentInfo() - line 257.")
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
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
        
        print("BirthdayVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerCDToEdit = userToEdit as? OwnerCD else { return }
        
        if ownerCDToEdit.birthdate != nil {
            
            whenIsYourBirthdayLabelOutlet.text = "Welcome \(ownerCDToEdit.firstName ?? "")"
            thisIsOptionalLabelOutlet.isHidden = true
            addAnyTimeLabelOutlet.isHidden = true
        }
        
        print("BirthdayVC birthdate choice: \(ownerCDToEdit.birthdate ?? Date())")
        birthdate = ownerCDToEdit.birthdate ?? Date()
        birthdayDatePickerView.date = ownerCDToEdit.birthdate ?? Date()
        
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidCDToEdit = userToEdit as? StudentKidCD else { return }
        
        if kidCDToEdit.birthdate != nil {
            
            whenIsYourBirthdayLabelOutlet.text = "Welcome \(kidCDToEdit.firstName ?? "")"
            thisIsOptionalLabelOutlet.isHidden = true
            addAnyTimeLabelOutlet.isHidden = true
        }

        print("BirthdayVC birthdate choice: \(kidCDToEdit.birthdate ?? Date())")
        birthdate = kidCDToEdit.birthdate ?? Date()
        birthdayDatePickerView.date = kidCDToEdit.birthdate ?? Date()
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultCDToEdit = userToEdit as? StudentAdultCD else { return }
        
        if adultCDToEdit.birthdate != nil {
            
            whenIsYourBirthdayLabelOutlet.text = "Welcome \(adultCDToEdit.firstName ?? "")"
            thisIsOptionalLabelOutlet.isHidden = true
            addAnyTimeLabelOutlet.isHidden = true
        }
    
        print("BirthdayVC birthdate choice: \(adultCDToEdit.birthdate ?? Date())")
        birthdate = adultCDToEdit.birthdate ?? Date()
        birthdayDatePickerView.date = adultCDToEdit.birthdate ?? Date()
    }
}
