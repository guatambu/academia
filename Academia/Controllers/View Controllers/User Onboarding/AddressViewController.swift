//
//  AddressViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    
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
    
    var inEditingMode: Bool?
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var addressLine1LabelOutlet: UILabel!
    @IBOutlet weak var addressLine1TextField: UITextField!
    @IBOutlet weak var addressLine2LabelOutlet: UILabel!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var cityLabelOutlet: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateLabelOutlet: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeLabelOutlet: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
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
                // isOwner update profile info
            }
        } else if let isKid = isKid {
            if isKid{
                // kidStudent update profile info
            } else {
                // adultStudent update profile info
            }
        }
        
        inEditingMode = false
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toContactInfo") as! ContactInfoViewController
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // run check to see is there is addressline1, city, state, and zipCode
        guard let addressLine1 = addressLine1TextField.text, addressLine1TextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let city = cityTextField.text, cityTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let state = stateTextField.text, stateTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let zipCode = zipCodeTextField.text, zipCodeTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        let addressLine2 = addressLine2TextField.text
        
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
    }
}
