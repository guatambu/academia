//
//  StudentInfoDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentInfoDetailsViewController: UIViewController {

    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()
    
    var isKid: Bool?
    
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
    @IBOutlet weak var parentGuardianLabelOutlet: UILabel!
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
        destViewController.isOwner = false
        
        // **** IF KID STUDENT ****
        destViewController.isKid = true
        destViewController.userToEdit = KidStudentModelController.shared.kids[0]
        print("saved kid belt level from kid model controller source of truth: " + KidStudentModelController.shared.kids[0].belt.beltLevel.rawValue)
//        // **** IF ADULT STUDENT ****
//        destViewController.isKid = false
//        destViewController.userToEdit = AdultStudentModelController.shared.adults[0]
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


extension StudentInfoDetailsViewController {
    
    func populateCompletedProfileInfo() {
        
        // KID STUDENT OPTION
        guard let kidStudent = KidStudentModelController.shared.kids.first else { return }

        // populate UI elements in VC
        self.title = "\(kidStudent.firstName) \(kidStudent.lastName)"
        usernameLabelOutlet.text = "username: \(kidStudent.username)"
        // populate birthdate outlet
        formatBirthdate(birthdate: kidStudent.birthdate)
        // contact info outlets
        phoneLabelOutlet.text = kidStudent.phone
        // mobile is not a required field
        if kidStudent.mobile != "" {
            mobileLabelOutlet.text = kidStudent.mobile
        } else {
            mobileLabelOutlet.isHidden = true
        }
        emailLabelOutlet.text = kidStudent.email
        // parent / guardian name
        parentGuardianLabelOutlet.text = "parent/guardian: \(kidStudent.parentGuardian)"
        // address outlets
        addressLine1LabelOutlet.text = kidStudent.addressLine1
        // addressLine2 is not a required field
        if kidStudent.addressLine2 != "" {
            addressLine2LabelOutlet.text = kidStudent.addressLine2
        } else {
            addressLine2LabelOutlet.isHidden = true
        }
        cityLabelOutlet.text = kidStudent.city
        stateLabelOutlet.text = kidStudent.state
        zipCodeLabelOutlet.text = kidStudent.zipCode
        // emergency contact info outlets
        emergencyContactNameLabelOutlet.text = kidStudent.emergencyContactName
        emergencyContactRelationshipLabelOutlet.text = kidStudent.emergencyContactRelationship
        emergencyContactPhoneLabelOutlet.text = kidStudent.emergencyContactPhone

        // profile pic imageView
        profilePicImageView.image = kidStudent.profilePic

        // belt holder UIView
        print("Kid Student Info in StudentInfodetailsVC -> beltLevel: \(kidStudent.belt.beltLevel)")
        print("Kid Student Info in StudentInfodetailsVC -> \(kidStudent.belt.numberOfStripes)")
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: kidStudent.belt.beltLevel, numberOfStripes: kidStudent.belt.numberOfStripes)
        
//        // ADULT STUDENT OPTION
//        guard let adultStudent = AdultStudentModelController.shared.adults.first else {
//            return
//        }
//
//        // populate UI elements in VC
//        self.title = "\(adultStudent.firstName) \(adultStudent.lastName)"
//        usernameLabelOutlet.text = adultStudent.username
//        // populate birthdate outlet
//        formatBirthdate(birthdate: adultStudent.birthdate)
//        // contact info outlets
//        phoneLabelOutlet.text = adultStudent.phone
//        // mobile is not a required field
//        if adultStudent.mobile != "" {
//            mobileLabelOutlet.text = adultStudent.mobile
//        } else {
//            mobileLabelOutlet.isHidden = true
//        }
//        emailLabelOutlet.text = adultStudent.email
//        // address outlets
//        addressLine1LabelOutlet.text = adultStudent.addressLine1
//        // addressLine2 is not a required field
//        if adultStudent.addressLine2 != "" {
//            addressLine2LabelOutlet.text = adultStudent.addressLine2
//        } else {
//            addressLine2LabelOutlet.isHidden = true
//        }
//        cityLabelOutlet.text = adultStudent.city
//        stateLabelOutlet.text = adultStudent.state
//        zipCodeLabelOutlet.text = adultStudent.zipCode
//        // emergency contact info outlets
//        emergencyContactNameLabelOutlet.text = adultStudent.emergencyContactName
//        emergencyContactRelationshipLabelOutlet.text = adultStudent.emergencyContactRelationship
//        emergencyContactPhoneLabelOutlet.text = adultStudent.emergencyContactPhone
//
//        // profile pic imageView
//        profilePicImageView.image = adultStudent.profilePic
//
//        // belt holder UIView
//        print("Adult Student Info in StudentInfodetailsVC -> beltLevel: \(adultStudent.belt.beltLevel)")
//        print("Adult Student Info in StudentInfodetailsVC -> \(adultStudent.belt.numberOfStripes)")
//        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: adultStudent.belt.beltLevel, numberOfStripes: adultStudent.belt.numberOfStripes)
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

