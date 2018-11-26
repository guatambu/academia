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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let isOwner = isOwner else { return }
        
        if isOwner{
            welcomeLabeOutlet.text = "Welcome Owner"
        } else {
            welcomeLabeOutlet.text = "Welcome New Student"
        }
        
        // if editing profile
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
        }
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        if let isOwner = isOwner {
            if isOwner {
                // Owner update profile info
                if phoneTextField.text != "" && emailTextField.text != "" {
                    
                    let owner = OwnerModelController.shared.owners[0]
                    
                    OwnerModelController.shared.updateProfileInfo(owner: owner, isInstructor: nil, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                    
                    self.returnToOwnerInfo()
                }
            }
        } else if let isKid = isKid {
            if isKid{
                // kidStudent update profile info
                if phoneTextField.text != "" && emailTextField.text != "" {
                   
                    let kid = KidStudentModelController.shared.kids[0]
                    KidStudentModelController.shared.updateProfileInfo(kidStudent: kid, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, parentGuardian: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
            } else {
                // adultStudent update profile info
                if phoneTextField.text != "" && emailTextField.text != "" {
                
                   let adult = AdultStudentModelController.shared.adults[0]
                    AdultStudentModelController.shared.updateProfileInfo(adultStudent: adult, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: phoneTextField.text, mobile: mobileTextField.text, email: emailTextField.text, emergencyContactName: nil, emergencyContactPhone: nil, emergencyContactRelationship: nil)
                }
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
    }
}
