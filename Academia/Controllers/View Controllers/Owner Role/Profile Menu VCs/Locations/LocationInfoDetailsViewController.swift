//
//  LocationInfoDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationInfoDetailsViewController: UIViewController {

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
        
        createAccountButtonOutlet.isHidden = true
        createAccountButtonOutlet.isEnabled = false
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
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // OPTIONS FOR DIFFERENT TYPES OF SEGUES + TYPES OF DESTINATION VIEWCONTROLLERS
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toTakeProfilePic") as! TakeProfilePicViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // set properties on destinationVC
        destViewController.inEditingMode = true
        destViewController.isOwner = true
        destViewController.isKid = false
        destViewController.userToEdit = OwnerModelController.shared.owners[0]
        // TODO: set destinationVC properties to display user to be edited
        // in destintaionVC unrwrap userToEdit? as either Owner, AdultStudent, or KidStudent and us this to display info, and be passed around for updating in each update function
        // also need to build in programmatic segues for saveTapped to exit editing mode and return to OwnerProfileDetailsVC
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "are you sure you want to delete your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete account", style: UIAlertAction.Style.destructive) { (alert) in
            
            OwnerModelController.shared.delete(owner: OwnerModelController.shared.owners[0])
            
            // programmatically performing the segue if "resetting" the app to beginning with no saved user
            
            // instantiate the relevant storyboard
            let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = mainView.instantiateViewController(withIdentifier: "toLandingPage") as! LandingPageViewController
            // add to Navigation stack
            let destVCNavigation = UINavigationController(rootViewController: destViewController)
            // perform the segure - present viewController of choice
            self.navigationController?.present(destVCNavigation, animated: true, completion: nil)
            
            // perform segue to specified viewController removing all others from Navigation Stack
            //            self.navigationController?.popToViewController(destVCNavigation, animated: true)
            // why can't i 'pop' to this VC?  if not the way to go, then, is navigation stack clean?
            
            self.navigationController?.navigationBar.tintColor = self.beltBuilder.redBeltRed
            
            print("how many owners we got now: \(OwnerModelController.shared.owners.count)")
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
}


extension LocationInfoDetailsViewController {
    
    func populateCompletedProfileInfo() {
        
        guard let location = LocationModelController.shared.locations.first else { return }
        // populate UI elements in VC
        self.title = "\(location.locationName)"
        // phone outlet
        phoneLabelOutlet.text = location.phone
        // mobile is not a required field
        websiteLabelOutlet.text = location.website
        emailLabelOutlet.text = location.email
        // address outlets
        addressLine1LabelOutlet.text = location.addressLine1
        // addressLine2 is not a required field
        if location.addressLine2 != "" {
            addressLine2LabelOutlet.text = location.addressLine2
        } else {
            addressLine2LabelOutlet.isHidden = true
        }
        cityLabelOutlet.text = location.city
        stateLabelOutlet.text = location.state
        zipCodeLabelOutlet.text = location.zipCode
        // emergency contact info outlets
        socialLink1LabelOutlet.text = location.social1
        socialLink2LabelOutlet.text = location.social2
        socialLink3LabelOutlet.text = location.social3
        // profile pic imageView
        locationPicImageView.image = location.locationPic
    }
}


extension LocationInfoDetailsViewController {
    
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


// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and location profileVC
extension UIViewController {
    
    func returnToLocationInfo() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is LocationInfoDetailsViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}
