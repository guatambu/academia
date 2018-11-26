//
//  EmergencyContactViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class EmergencyContactViewController: UIViewController {

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
    var emergencyContactName: String?
    var emergencyContactPhone: String?
    var emergencyContactRelationship: String?
    
    var inEditingMode: Bool?
    var userToEdit: Any?
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactNameLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactNameTextField: UITextField!
    @IBOutlet weak var emergencyContactPhoneLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactPhoneTextField: UITextField!
    @IBOutlet weak var emergencyContactRelationshipOutlet: UILabel!
    @IBOutlet weak var emergencyContactRelationshipTextField: UITextField!
    
    @IBOutlet weak var firstProgressDotOutlet: DesignableView!
    
    
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
                if emergencyContactNameTextField.text != "" && emergencyContactPhoneTextField.text != "" && emergencyContactRelationshipTextField.text != "" {
                    
                    let owner = OwnerModelController.shared.owners[0]
                    
                    OwnerModelController.shared.updateProfileInfo(owner: owner, isInstructor: nil, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: emergencyContactNameTextField.text, emergencyContactPhone: emergencyContactPhoneTextField.text, emergencyContactRelationship: emergencyContactRelationshipTextField.text)
                    
                    self.returnToOwnerProfile()
                }
            }
        } else if let isKid = isKid {
            if isKid{
                // kidStudent update profile info
                if emergencyContactNameTextField.text != "" && emergencyContactPhoneTextField.text != "" && emergencyContactRelationshipTextField.text != "" {
                    
                    let kid = KidStudentModelController.shared.kids[0]
                    KidStudentModelController.shared.updateProfileInfo(kidStudent: kid, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, parentGuardian: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: emergencyContactNameTextField.text, emergencyContactPhone: emergencyContactPhoneTextField.text, emergencyContactRelationship: emergencyContactRelationshipTextField.text)
                }
            } else {
                // adultStudent update profile info
                if emergencyContactNameTextField.text != "" && emergencyContactPhoneTextField.text != "" && emergencyContactRelationshipTextField.text != "" {
                    
                    let adult = AdultStudentModelController.shared.adults[0]
                    AdultStudentModelController.shared.updateProfileInfo(adultStudent: adult, birthdate: nil, groups: nil, permission: nil, belt: nil, profilePic: nil, username: nil, firstName: nil, lastName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, mobile: nil, email: nil, emergencyContactName: emergencyContactNameTextField.text, emergencyContactPhone: emergencyContactPhoneTextField.text, emergencyContactRelationship: emergencyContactRelationshipTextField.text)
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
        let destViewController = mainView.instantiateViewController(withIdentifier: "toProfileComplete") as! CompletedProfileViewController
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // run check to see is there is emergency contact name, relationship, phone
        guard let emergencyContactName = emergencyContactNameTextField.text, emergencyContactNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let emergencyContactRelationship = emergencyContactRelationshipTextField.text, emergencyContactRelationshipTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let emergencyContactPhone = emergencyContactPhoneTextField.text, emergencyContactPhoneTextField.text != "" else {
            
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
        destViewController.emergencyContactName = emergencyContactName
        destViewController.emergencyContactRelationship = emergencyContactRelationship
        destViewController.emergencyContactPhone = emergencyContactPhone
        
        
        guard let isOwner = isOwner else { print("fail isOwner"); return }
        guard let isKid = isKid else { print("fail isKid"); return }
        guard profilePic != nil else { print("fail profilePic"); return }
        guard let username = username else { print("fail username"); return }
        guard let password = password else { print("fail password"); return }
        guard let firstName = firstName else { print("fail firtsName"); return }
        guard let lastName = lastName else { print("fail lastName"); return }
        guard let birthdate = birthdate else { print("fail birthdate"); return }
        guard let beltLevel = beltLevel else { print("fail beltLevel"); return }
        guard let numberOfStripes = numberOfStripes else { print("fail stripes"); return }
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        guard let city = city else { print("fail city"); return }
        guard let state = state else { print("fail state"); return }
        guard let zipCode = zipCode else { print("fail zip"); return }
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        // print to console for developer verification
        print("isOwner: \(isOwner) \nisKid: \(isKid) \nusername: \(username) \npassword: \(password) \nfirstName: \(firstName) \nlastName: \(lastName) \nbirthdate: \(birthdate) \nbeltLevel: \(beltLevel.rawValue) \nnumberOfStripes: \(numberOfStripes) \naddressLine1: \(addressLine1) \naddressLine2: \(String(describing: addressLine2)) \ncity: \(city) \nstate: \(state) \nzipCode: \(zipCode) \nphone: \(phone) \nmobile: \(String(describing: mobile)) \nemail: \(email) \nemergencyContactName: \(emergencyContactName) \nemergencyContactRelationship: \(emergencyContactRelationship) \nemergencyContactPhone: \(emergencyContactPhone) \nparentGuardian: \(String(describing: parentGuardian))")
    }
}
