//
//  LocationInfoDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

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
    
    var locationCD: LocationCD?
    
    let beltBuilder = BeltBuilder()
    
    // profile pic imageView
    @IBOutlet weak var locationNameLabelOutlet: UILabel!
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
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedProfileInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLine2LabelOutlet.isHidden = false

        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
    }

    // MARK: - Actions
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerLocationWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toLocationPicAndName") as! LocationPicAndNameViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // set properties on destinationVC
//        destViewController.locationToEdit = location
        destViewController.inEditingMode = true
        destViewController.locationCDToEdit = locationCD
        
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "are you sure you want to delete your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete account", style: UIAlertAction.Style.destructive) { (alert) in
            
            guard let location = self.locationCD else {
                print("ERROR: nil value found for location in LocationInfoDetailsViewController.swift -> deleteAccountButtonTapped(sender:) - line 110.")
                return
            }
            LocationCDModelController.shared.remove(location: location)
            
            // programmatically performing the segue
            
            // instantiate the relevant storyboard
            let mainView: UIStoryboard = UIStoryboard(name: "OwnerLocationWorkFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = mainView.instantiateViewController(withIdentifier: "toOwnerLocationsList") as! MyLocationsTableViewController
            // add to Navigation stack
            let destVCNavigation = UINavigationController(rootViewController: destViewController)
            // perform the segure - present viewController of choice
            self.navigationController?.present(destVCNavigation, animated: true, completion: nil)
            
            // perform segue to specified viewController removing all others from Navigation Stack
            //            self.navigationController?.popToViewController(destVCNavigation, animated: true)
            // why can't i 'pop' to this VC?  if not the way to go, then, is navigation stack clean?
            
            // set nav bar controller appearance
            self.navigationController?.navigationBar.tintColor = self.beltBuilder.redBeltRed
            self.navigationController?.navigationBar.backgroundColor = self.beltBuilder.kidsWhiteCenterRibbonColor
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            print("how many location we got now: \(LocationCDModelController.shared.locations.count)")
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
}


extension LocationInfoDetailsViewController {
    
    func populateCompletedProfileInfo() {

        guard let location = locationCD else {
            print("ERROR: nil value found for locationCD in LocationInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 155.")
            return
        }
        guard let address = location.address else {
            print("ERROR: nil value found for location.address in LocationInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 159.")
            return
        }
        guard let socialLinks = location.socialLinks else {
            print("ERROR: nil value found for location.socalLinks in LocationInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 163.")
            return
        }
        guard let locationPicData = location.locationPic else {
            print("ERROR: nil value found for location.locationPic in LocationInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 167.")
            return
        }
        
        // populate UI elements in VC
        locationNameLabelOutlet.text = location.locationName
        // phone outlet
        phoneLabelOutlet.text = location.phone
        // mobile is not a required field
        websiteLabelOutlet.text = location.website
        emailLabelOutlet.text = location.email
        // address outlets
        addressLine1LabelOutlet.text = address.addressLine1
        // addressLine2 is not a required field
        if address.addressLine2 != "" {
            addressLine2LabelOutlet.text = address.addressLine2
        } else {
            addressLine2LabelOutlet.isHidden = true
        }
        cityLabelOutlet.text = address.city
        stateLabelOutlet.text = address.state
        zipCodeLabelOutlet.text = address.zipCode
        // social media links outlets
        socialLink1LabelOutlet.text = "Instagram: \(socialLinks.socialLink1 ?? "")"
        socialLink2LabelOutlet.text = "facebook: \(socialLinks.socialLink2 ?? "")"
        socialLink3LabelOutlet.text = "Twitter: \(socialLinks.socialLink3 ?? "")"
        // profile pic imageView
        locationPicImageView.image = UIImage(data: locationPicData)
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


