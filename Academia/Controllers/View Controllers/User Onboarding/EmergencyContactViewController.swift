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
    var profilePic: UIImage?
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
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactNameLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactNameTextField: UITextField!
    @IBOutlet weak var emergencyContactPhoneLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactPhoneTextField: UITextField!
    @IBOutlet weak var emergencyContactRelationshipOutlet: UILabel!
    @IBOutlet weak var emergencyContactRelationshipTextField: UITextField!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions
    
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
        destViewController.profilePic = profilePic
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
    }
}
