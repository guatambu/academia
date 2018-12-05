//
//  ReviewAndCreateLocationViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/3/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ReviewAndCreateLocationViewController: UIViewController {

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
    
    let beltBuilder = BeltBuilder()
    
    // profile pic imageView
    @IBOutlet weak var locationPicImageView: UIImageView!
    // contact info outlets
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var websiteLabelOutlet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    // address outlets
    @IBOutlet weak var addressLine1LabelOutlet: UILabel!
    @IBOutlet weak var addressLine2LabelOutlet: UILabel!
    @IBOutlet weak var cityLabelOutlet: UILabel!
    @IBOutlet weak var stateLabelOutlet: UILabel!
    @IBOutlet weak var zipCodeLabelOutlet: UILabel!
    // social link outlets
    @IBOutlet weak var socialLink1LabelOutlet: UILabel!
    @IBOutlet weak var socialLink2LabelOutlet: UILabel!
    @IBOutlet weak var socialLink3LabelOutlet: UILabel!
    
    @IBOutlet weak var createAccountButtonOutlet: DesignableButton!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        populateCompletedProfileInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLine2LabelOutlet.isHidden = false
        
        //populateCompletedProfileInfo()
    }
    
    // TODO: decide whether to create a new review your location details VC or tweak current one to work when creating location button not needed
    
    // MARK: - Actions
    
    @IBAction func createAccountButtonTapped(_ sender: DesignableButton) {
        
        // create the new location in the LocationModelController source of truth
        createLocation()
        
        // programmatic segue back to the MyLocations TVC to view the current locations
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is MyLocationsTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}


extension ReviewAndCreateLocationViewController {
    
    func populateCompletedProfileInfo() {
        
        // populate UI elements in VC
        guard let locationName = locationName else {
            print("in ReviewAndCreateLocationVC -> populateCompletedProfile() there is no locationName!!! - line 101")
            return
        }
        self.title = "\(locationName)"
        // phone outlet
        phoneLabelOutlet.text = phone
        // mobile is not a required field
        websiteLabelOutlet.text = website
        emailLabelOutlet.text = email
        // address outlets
        addressLine1LabelOutlet.text = addressLine1
        // addressLine2 is not a required field
        if addressLine2 != "" {
            addressLine2LabelOutlet.text = addressLine2
        } else {
            addressLine2LabelOutlet.isHidden = true
        }
        cityLabelOutlet.text = city
        stateLabelOutlet.text = state
        zipCodeLabelOutlet.text = zipCode
        // emergency contact info outlets
        socialLink1LabelOutlet.text = social1
        socialLink2LabelOutlet.text = social2
        socialLink3LabelOutlet.text = social3
        // profile pic imageView
        locationPicImageView.image = locationPic
    }
}


extension ReviewAndCreateLocationViewController {
    
    func createLocation() {
        
        guard let locationPic = locationPic else { print("fail locationPic"); return }
        guard let locationName = locationName else { print("fail locationName"); return }
        guard let active = active else { print("fail active"); return }
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        guard let city = city else { print("fail city"); return }
        guard let state = state else { print("fail state"); return }
        guard let zipCode = zipCode else { print("fail zip"); return }
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        let website = self.website ?? ""
        let addressLine2 = self.addressLine2 ?? ""
        let social1 = self.social1 ?? ""
        let social2 = self.social2 ?? ""
        let social3 = self.social3 ?? ""
        
        LocationModelController.shared.addNew(locationPic: locationPic, active: active, locationName: locationName, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, website: website, email: email, social1: social1, social2: social2, social3: social3)
    }
}







































