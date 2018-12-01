//
//  LocationInfoDetailsViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 11/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationInfoDetailsViewController: UIViewController {

    // MARK: - Properties
    
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
    
    
    // MARK: - Actions
    
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
        socialLink1LabelOutlet.text = location.social
        socialLink2LabelOutlet.text = location.social
        socialLink3LabelOutlet.text = location.social
        // profile pic imageView
        locationPicImageView.image = location.profilePic
    }
}


// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and user profileVC
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
