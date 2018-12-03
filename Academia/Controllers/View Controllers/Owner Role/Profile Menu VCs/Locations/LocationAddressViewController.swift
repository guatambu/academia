//
//  LocationAddressViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationAddressViewController: UIViewController {
    
    // MARK: - Properties
    
    var locationName: String?
    var locationPic: UIImage?
    var active: Bool?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    
    var inEditingMode: Bool?
    var locationToEdit: Location?
    
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
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        updateLocationInfo()
        
        self.returnToLocationInfo()
        
        print("update location address: \(LocationModelController.shared.locations[0].addressLine1) \n\(LocationModelController.shared.locations[0].addressLine2) \n\(LocationModelController.shared.locations[0].city) \(LocationModelController.shared.locations[0].state) \(LocationModelController.shared.locations[0].zipCode)")
        
        inEditingMode = false
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toLocationContactInfo") as! LocationContactInfoViewController
        
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
        destViewController.locationName = locationName
        destViewController.locationPic = locationPic
        destViewController.active = active
        destViewController.addressLine1 = addressLine1
        destViewController.addressLine2 = addressLine2
        destViewController.city = city
        destViewController.state = state
        destViewController.zipCode = zipCode
        
        destViewController.inEditingMode = inEditingMode
        destViewController.locationToEdit = locationToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in loaction onboarding
        updateLocationInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension LocationAddressViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateLocationInfo() {
        if addressLine1TextField.text != "" && cityTextField.text != "" && stateTextField.text != "" && zipCodeTextField.text != "" {
            
            guard let location = locationToEdit else { return }
            
            LocationModelController.shared.update(location: location, active: nil, locationPic: nil, locationName: nil, addressLine1: addressLine1TextField.text, addressLine2: addressLine2TextField.text, city: cityTextField.text, state: stateTextField.text, zipCode: zipCodeTextField.text, phone: nil, website: nil, email: nil, social1: nil, social2: nil, social3: nil)
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            // set editing mode for each user case
            locationEditingSetup(locationToEdit: locationToEdit)
        }
        
        print("LocationAddressVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func locationEditingSetup(locationToEdit: Location?) {
        
        guard let locationToEdit = locationToEdit else {
            return
        }
        
        welcomeLabeOutlet.text = "Location: \(locationToEdit.locationName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
        
        addressLine1TextField.text = locationToEdit.addressLine1
        addressLine2TextField.text = locationToEdit.addressLine2
        cityTextField.text = locationToEdit.city
        stateTextField.text = locationToEdit.state
        zipCodeTextField.text = locationToEdit.zipCode
        
        
    }
}
