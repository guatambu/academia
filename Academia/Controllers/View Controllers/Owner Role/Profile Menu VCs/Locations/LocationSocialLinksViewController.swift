//
//  LocationSocialLinksViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationSocialLinksViewController: UIViewController {
    
    // MARK: - Properties
    
    var locationName: String?
    var locationPic: UIImage?
    var active: Bool?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var phone: String?
    var website: String?
    var email: String?
    var social1: String?
    var social2: String?
    var social3: String?
    
    var inEditingMode: Bool?
    var locationToEdit: Location?

    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var socialLink1LabelOutlet: UILabel!
    @IBOutlet weak var socialLink1TextField: UITextField!
    @IBOutlet weak var socialLink2LabelOutlet: UILabel!
    @IBOutlet weak var socialLink2TextField: UITextField!
    @IBOutlet weak var socialLink3Outlet: UILabel!
    @IBOutlet weak var socialLink3TextField: UITextField!
    
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
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
        
        print("update location address: \(LocationModelController.shared.locations[0].phone) \n\(String(describing: LocationModelController.shared.locations[0].website)) \n\(String(describing: LocationModelController.shared.locations[0].email))")
        
        inEditingMode = false
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toLocationInfoDetails") as! LocationInfoDetailsViewController
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.locationName = locationName
        destViewController.active = active
        destViewController.locationPic = locationPic
        destViewController.addressLine1 = addressLine1
        destViewController.addressLine2 = addressLine2
        destViewController.city = city
        destViewController.state = state
        destViewController.zipCode = zipCode
        destViewController.phone = phone
        destViewController.website = website
        destViewController.email = email
        destViewController.social1 = socialLink1TextField.text
        destViewController.social2 = socialLink2TextField.text
        destViewController.social3 = socialLink3TextField.text
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in location onboarding
        updateLocationInfo()
    }
}


// MARK: - Editing Mode for Individual Location case specific setup
extension LocationSocialLinksViewController {
    
    // Update Function for case where want to update location info without a segue
    func updateLocationInfo() {
        
        guard let location = locationToEdit else { return }
        
        LocationModelController.shared.update(location: location, active: nil, locationPic: nil, locationName: nil, addressLine1: nil, addressLine2: nil, city: nil, state: nil, zipCode: nil, phone: nil, website: nil, email: nil, social1: socialLink1TextField.text, social2: socialLink2TextField.text, social3: socialLink3TextField.text)
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            locationEditingSetup(userToEdit: locationToEdit)
        }
        
        print("LocationSocialLinksVC -> inEditingMode = \(inEditingMode)")
        
        nextButtonOutlet.isHidden = true
        nextButtonOutlet.isEnabled = false
    }
    
    // location setup for editing mode
    func locationEditingSetup(userToEdit: Location?) {
        
        guard let locationToEdit = locationToEdit else {
            return
        }
        
        welcomeLabeOutlet.text = "Location: \(locationToEdit.locationName)"
        
        welcomeInstructionsLabelOutlet.text = "you are in profile editing mode"
        
        socialLink1TextField.text = locationToEdit.social1
        socialLink2TextField.text = locationToEdit.social2
        socialLink3TextField.text = locationToEdit.social3
    }
}
