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
    
    // username outlets
    @IBOutlet weak var usernameLabelOutlet: UILabel!
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
        
    }
    
 
}


extension OwnerProfileDetailsViewController {
    
    func populateCompletedProfileInfo() {
    
        guard let owner = OwnerModelController.shared.owners.first else { return }
        // populate UI elements in VC
        self.title = "\(owner.firstName) \(owner.lastName)"
        usernameLabelOutlet.text = owner.username
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
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: owner.belt.beltLevel, numberOfStripes: owner.belt.numberOfStripes)
    }
}

