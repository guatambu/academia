//
//  OwnerInfoDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class OwnerInfoDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var isInstructor = true
    
    // create a fetchedRequestController with predicate to grab the current logged in user by using the ActiveUserModelController.shared.activeUser array contents and isLogged on properties... use this property as the source for the populateCompletedProfileInfo() method
    var fetchedResultsController: NSFetchedResultsController<OwnerCD>!

    let beltBuilder = BeltBuilder()
    
    var activeOwner: OwnerCD?
    
    // username outlet
    @IBOutlet weak var ownerNameLabelOutlet: UILabel!
    // isInstructor switch outlet
    @IBOutlet weak var isInstuctorSwitch: UISwitch!
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
        
        // create fetch request and initialize results
        initializeFetchedResultsController()
        // search fetch results to find activeOwner
        findActiveUser()
        // populate activeOwner details to UI
        populateCompletedProfileInfo()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addressLine2LabelOutlet.isHidden = false
        mobileLabelOutlet.isHidden = false
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
    }
    

    // MARK: - Actions
    
    @IBAction func toggleIsInstructorSwitch(_ sender: UISwitch) {
        
        isInstructor = !isInstructor
        print("isInstructorSwitch toggled, currently isInstructor = \(isInstructor)")
        
        guard let ownerCD = activeOwner else {
            print("ERROR: nil value found for activeOwner property of type OwnerCD in OwnerInfoDetailsViewController.swift -> toggleIsInstructorSwitch(sender:) - line 87.")
            return
        }
        
        // update the activeOwner's isInstructor value
        OwnerCDModelController.shared.update(owner: ownerCD, isInstructor: isInstructor, birthdate: nil, mostRecentPromotion: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
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
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // set properties on destinationVC
        destViewController.inEditingMode = true
        destViewController.isOwner = true
        destViewController.isKid = false
        destViewController.userCDToEdit = activeOwner
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "are you sure you want to delete your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete account", style: UIAlertAction.Style.destructive) { (alert) in
            
            guard let owner = self.activeOwner else {
                print("ERROR: nil value found for activeOwner in OwnerInfoDetailsViewController.swift -> deleteAccountButtonTapped(sender:) - line 117.")
                return
            }
            OwnerCDModelController.shared.remove(owner: owner)
            
            // programmatically performing the segue if "resetting" the app to beginning with no saved user
            
            // instantiate the relevant storyboard
            let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = mainView.instantiateViewController(withIdentifier: "toLandingPage") as! LandingPageViewController
            // add to Navigation stack
            let destVCNavigation = UINavigationController(rootViewController: destViewController)
            // perform the segure - present viewController of choice
            self.navigationController?.present(destVCNavigation, animated: true, completion: nil)
            
            // set nav bar controller appearance
            self.navigationController?.navigationBar.tintColor = self.beltBuilder.redBeltRed
            self.navigationController?.navigationBar.backgroundColor = self.beltBuilder.kidsWhiteCenterRibbonColor
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            print("how many owners we got now: \(OwnerCDModelController.shared.owners.count)")
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
}


extension OwnerInfoDetailsViewController {
    
    func populateCompletedProfileInfo() {
    
        
//        guard let owner = OwnerModelController.shared.owners.first else { return }
        guard let owner = activeOwner else {
            print("ERROR: nil value found for activeOwner in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 157.")
            return
        }
        guard let address = owner.address else {
            print("ERROR: nil value found for owner.address in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 161.")
            return
        }
        guard let belt = owner.belt else {
            print("ERROR: nil value found for owner.belt in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 165.")
            return
        }
        guard let emergencyContact = owner.emergencyContact else {
            print("ERROR: nil value found for owner.emergencyContact in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 169.")
            return
        }
        
        guard let firstName = owner.firstName else { print("fail firstName"); return }
        guard let lastName = owner.lastName else { print("fail lastName"); return }
        guard let username = owner.username else { print("fails username"); return }
        // populate UI elements in VC
        ownerNameLabelOutlet.text = "\(firstName) \(lastName)"
        usernameLabelOutlet.text = "user: \(username)"
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
        // emergency contact info outlets
        emergencyContactNameLabelOutlet.text = emergencyContact.name
        emergencyContactRelationshipLabelOutlet.text = emergencyContact.relationship
        emergencyContactPhoneLabelOutlet.text = emergencyContact.phone
        
        // convert owner.profilePic to UIImage from Data
        
        guard let profilePicData = owner.profilePic else {
            print("ERROR: nil value found for owner.profilePic as Data in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 205.")
            return
        }
        // profile pic imageView
        profilePicImageView.image = UIImage(data: profilePicData)
        
        // construct InternationalStandardBJJBelts object from owner.belt.beltLevel.rawValue
        guard let beltLevel = InternationalStandardBJJBelts(rawValue: belt.beltLevel!) else {
            print("ERROR: no value found for beltLevel in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 215.")
            return
        }
        // convert numberOfStripes Int16 to Int value
        guard let numberOfStripes = Int(exactly: belt.numberOfStripes) else {
            print("ERROR: no value found for numberOfStripes in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 220.")
            return
        }
        print("OwnersProfileVC -> beltLevel: \(beltLevel.rawValue)")
        print("OwnersProfileVC -> numberOfStripes: \(numberOfStripes)")
        // build the belt for the belt holder UIView
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
    }
    
    func formatBirthdate(birthdate: Date?) {
        
        guard let birthdate = birthdate else {
            print("ERROR: no birthdate returned in OwnerInfoDetailsViewController.swift -> formatBirthdate(birthdate:) - line 202.")
            return
        }
        
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


// MARK: - NSFetchedREsultsController initializer method
extension OwnerInfoDetailsViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OwnerCD")
        let uuidSort = NSSortDescriptor(key: "lastName", ascending: true)
        request.sortDescriptors = [uuidSort]
        
        let moc = CoreDataStack.context
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<OwnerCD>
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func findActiveUser() {
        
        // get active user uuid
        guard let uuid = ActiveUserModelController.shared.activeUser.first else {
            print("ERROR: no uuid returned by ActiveUserModelController.shared.activeUser.first in OwnerInfoDetailsViewController.swift -> findActiveUser() - line 232.")
            return
        }
        
        // get array of fetched objects from fetchedResultsController content(s)
        guard let activeOwners = fetchedResultsController.fetchedObjects else {
            print("ERROR: no owners returned by fetchedResultsController in OwnerInfoDetailsViewController.swift -> findActiveUser() - line 235.")
            return
        }
        // match owner with activeUser UUID
        for owner in activeOwners {
            if owner.ownerUUID == uuid {
                activeOwner = owner
                print("SUCCESS: activeOwner uuid matches an owner")
                return
            }
        }
    }
}


// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and user profileVC
extension UIViewController {
    
    func returnToOwnerInfo() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is OwnerInfoDetailsViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    func returnToStudentInfo() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is StudentInfoDetailsViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
}

