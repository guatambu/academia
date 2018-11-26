//
//  OwnerProfileDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class OwnerProfileDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()
    
    // username outlet
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    // birthdate outlet
    @IBOutlet weak var birthdateLabelOutlets: UILabel!
    // profile pic imageView
    @IBOutlet weak var profilePicImageView: UIImageView!
    // contact info outlets
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var mobileLabelOutlet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    // belt holder UIView
    @IBOutlet weak var beltHolderViewOutlet: UIView!
    // address outlets
    @IBOutlet weak var addressLine1LabelOutlet: UILabel!
    @IBOutlet weak var addressLine2LabelOutlet: UILabel!
    @IBOutlet weak var cityLabelOutlet: UILabel!
    @IBOutlet weak var stateLabelOutlet: UILabel!
    @IBOutlet weak var zipCodeLabelOutlet: UILabel!
    // emergency contact info outlets
    @IBOutlet weak var emergencyContactNameLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactRelationshipLabelOutlet: UILabel!
    @IBOutlet weak var emergencyContactPhoneLabelOutlet: UILabel!

    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        populateCompletedProfileInfo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addressLine2LabelOutlet.isHidden = false
        mobileLabelOutlet.isHidden = false
        
        populateCompletedProfileInfo()
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
            
            // programmatically performing the segue
            
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


extension OwnerProfileDetailsViewController {
    
    func populateCompletedProfileInfo() {
    
        guard let owner = OwnerModelController.shared.owners.first else { return }
        // populate UI elements in VC
        self.title = "\(owner.firstName) \(owner.lastName)"
        usernameLabelOutlet.text = owner.username
        // populate birthdate outlet
        formatBirthdate(birthdate: owner.birthdate)
        // contact info outlets
        phoneLabelOutlet.text = owner.phone
        // mobile is not a required field
        if owner.mobile != "" {
            mobileLabelOutlet.text = owner.mobile
        } else {
            mobileLabelOutlet.isHidden = true
        }
        emailLabelOutlet.text = owner.email
        // address outlets
        addressLine1LabelOutlet.text = owner.addressLine1
        // addressLine2 is not a required field
        if owner.addressLine2 != "" {
            addressLine2LabelOutlet.text = owner.addressLine2
        } else {
            addressLine2LabelOutlet.isHidden = true
        }
        cityLabelOutlet.text = owner.city
        stateLabelOutlet.text = owner.state
        zipCodeLabelOutlet.text = owner.zipCode
        // emergency contact info outlets
        emergencyContactNameLabelOutlet.text = owner.emergencyContactName
        emergencyContactRelationshipLabelOutlet.text = owner.emergencyContactRelationship
        emergencyContactPhoneLabelOutlet.text = owner.emergencyContactPhone
        
        // profile pic imageView
        profilePicImageView.image = owner.profilePic
        
        // belt holder UIView
        print("OwnersProfileVC -> beltLevel: \(owner.belt.beltLevel)")
        print("OwnersProfileVC -> numberOfStripes: \(owner.belt.numberOfStripes)")
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: owner.belt.beltLevel, numberOfStripes: owner.belt.numberOfStripes)
    }
    
    func formatBirthdate(birthdate: Date) {
        
        // set up date format
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let birthdateString = dateFormatter.string(from: birthdate)
        
        print(birthdateString)
        
        self.birthdateLabelOutlets.text = "birthdate: " + birthdateString
    }
}

