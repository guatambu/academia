//
//  OwnerInfoDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseUI

class OwnerInfoDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    // TODO: rework users Firestore models to be based on one document call rather than multiple to populate the profile details page
    
    var isInstructor = true
    
    // create a fetchedRequestController with predicate to grab the current logged in user by using the ActiveUserModelController.shared.activeUser array contents and isLogged on properties... use this property as the source for the populateCompletedProfileInfo() method
    var fetchedResultsController: NSFetchedResultsController<OwnerCD>!

    let beltBuilder = BeltBuilder()
    
//    var activeOwner: OwnerCD?
    var inEditingMode: Bool?
    
    // Firebase Firestore properties
    var activeOwnerFirestore: OwnerFirestore?
    var activeOwnerStorageRef: StorageReference?
    
    var db: Firestore!
    // The handler for the FIREBASE Auth state listener, to allow cancelling later.
    var handle: AuthStateDidChangeListenerHandle?
    
    
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
        
//        // create fetch request and initialize results
//        initializeFetchedResultsController()
//        // search fetch results to find activeOwner
//        findActiveUser()
//        // populate activeOwner details to UI
//        populateCompletedProfileInfo()
        
        // FIREBASE Auth listener
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if Auth.auth().currentUser != nil {
                
                let user = Auth.auth().currentUser
                
                if let user = user {
                    
                    let uid = user.uid
                    
                    // set the activeOwnerStorageReference path
                    self.activeOwnerStorageRef = Storage.storage().reference().child("profilePics/owners/\(uid)")
                    
                    // get the active firestre owner info
                    self.db.collection("owners").document(uid).getDocument { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            guard let ownerData = querySnapshot?.data() else {
                                
                                print("ERROR: nil value found for ownerData in OwnerInfoDetailsViewController.swift -> viewWillAppear - line 92.")
                                return
                            }
                                
                            print("\(String(describing: querySnapshot?.documentID)) => \(String(describing: querySnapshot?.data()))")
                            
                            self.activeOwnerFirestore = OwnerFirestore(dictionary: ownerData)
                            
                            self.populateCompletedProfileInfo(user: user)
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // FIREBASE Auth listener
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addressLine2LabelOutlet.isHidden = false
        mobileLabelOutlet.isHidden = false
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        db = Firestore.firestore()
    }
    

    // MARK: - Actions
    
    @IBAction func toggleIsInstructorSwitch(_ sender: UISwitch) {
        
        isInstructor = !isInstructor
        print("isInstructorSwitch toggled, currently isInstructor = \(isInstructor)")
        
//        guard let ownerCD = activeOwner else {
//            print("ERROR: nil value found for activeOwner property of type OwnerCD in OwnerInfoDetailsViewController.swift -> toggleIsInstructorSwitch(sender:) - line 87.")
//            return
//        }
//
//        // update the activeOwner's isInstructor value
//        OwnerCDModelController.shared.update(owner: ownerCD, isInstructor: isInstructor, birthdate: nil, mostRecentPromotion: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
//        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toSignUpLoginViewController") as! SignUpLoginViewController
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
//        destViewController.userCDToEdit = activeOwner
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        logoutOwnerUserAndReturnToLandingPage()
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "are you sure you want to delete your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete account", style: UIAlertAction.Style.destructive) { (alert) in
            
//            guard let owner = self.activeOwner else {
//                print("ERROR: nil value found for activeOwner in OwnerInfoDetailsViewController.swift -> deleteAccountButtonTapped(sender:) - line 117.")
//                return
//            }
//            OwnerCDModelController.shared.remove(owner: owner)
            
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
    
    func populateCompletedProfileInfo(user: User?) {
    
        
//        guard let owner = OwnerModelController.shared.owners.first else { return }
        guard let owner = activeOwnerFirestore else {
            print("ERROR: nil value found for owner in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 287.")
            return
        }
        
        let firstName = owner.firstName
        let lastName = owner.lastName
        let username = user?.displayName ?? ""
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
        addressLine1LabelOutlet.text = owner.addressLine1
        // addressLine2 is not a required field
        if owner.addressLine2 != "" {
            addressLine2LabelOutlet.text = owner.addressLine2 ?? ""
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
        
        // unwrap activeOwnerStorageRef to get profilePic
        guard let profilePicReference = activeOwnerStorageRef else {
            print("ERROR: nil value found for profilePicReference in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 205.")
            return
        }
        // Placeholder image
        let placeholderImage = UIImage(named: "profile_pic_placeholder_image.png")
        
        // profile pic imageView Load the image using SDWebImage
        profilePicImageView.sd_setImage(with: profilePicReference, placeholderImage: placeholderImage)
        
        // construct InternationalStandardBJJBelts object from owner.belt.beltLevel.rawValue
        guard let beltLevel = InternationalStandardBJJBelts(rawValue: owner.beltLevel) else {
            print("ERROR: no value found for beltLevel in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 215.")
            return
        }
        // convert numberOfStripes Int16 to Int value
        guard let numberOfStripes = Int(exactly: owner.numberOfStripes) else {
            print("ERROR: no value found for numberOfStripes in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 220.")
            return
        }
        print("OwnersProfileVC -> beltLevel: \(beltLevel.rawValue)")
        print("OwnersProfileVC -> numberOfStripes: \(numberOfStripes)")
        // build the belt for the belt holder UIView
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
    }
    
    func formatBirthdate(birthdate: Timestamp?) {
        
        guard let owner = activeOwnerFirestore else {
            print("ERROR: no owner returned in OwnerInfoDetailsViewController.swift -> formatBirthdate(birthdate:) - line 202.")
            return
        }
        
        // set up date format
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let birthdateString = dateFormatter.string(from: owner.birthdate.dateValue())
        
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
        
//        // get active user uuid
//        guard let uuid = ActiveUserModelController.shared.activeUser.first else {
//            print("ERROR: no uuid returned by ActiveUserModelController.shared.activeUser.first in OwnerInfoDetailsViewController.swift -> findActiveUser() - line 232.")
//            return
//        }
//
//        // get array of fetched objects from fetchedResultsController content(s)
//        guard let activeOwners = fetchedResultsController.fetchedObjects else {
//            print("ERROR: no owners returned by fetchedResultsController in OwnerInfoDetailsViewController.swift -> findActiveUser() - line 235.")
//            return
//        }
//        // match owner with activeUser UUID
//        for owner in activeOwners {
//            if owner.ownerUUID == uuid {
//                activeOwner = owner
//                print("SUCCESS: activeOwner uuid matches an owner")
//                return
//            }
//        }
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
            } else if viewController is OwnersStudentDetailViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
}


// MARK: - Programmatic Segues to return to LandingPage and logout current Student User
extension OwnerInfoDetailsViewController {
    
    func logoutOwnerUserAndReturnToLandingPage() {
        
        // give user the chance to cancel logout in case of accidental logout button tap
        let alertController = UIAlertController(title: "Logout", message: "are you sure you want to logout of your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let logout = UIAlertAction(title: "logout", style: UIAlertAction.Style.destructive) { (alert) in
            
            // Firebase Auth logout
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("ERROR: \(signOutError.localizedDescription) while attempting to sign out in OwnerInfoDetailsViewController.swift -> logoutOwnerUserAndReturnToLandingPage() - line 414.")
            }
        
            // remove current Student User from ActiveUserModelController active user array
            // this array should be totally empty whenever no user of any type is logged in
            ActiveUserModelController.shared.activeUser.removeAll()
            
            // set isLoggedOn property of Student User to false
//            if let activeOwner = self.activeOwner {
//                activeOwner.isLoggedOn = false
//            }
            // return to the LandingPageVC scene
            self.returnToLandingPage()
        }
        
        alertController.addAction(cancel)
        alertController.addAction(logout)
        
        self.present(alertController, animated: true)
    }
}


// MARK: - returnToLandingPage()
extension UIViewController {
    
    func returnToLandingPage() {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        if let destViewController = (mainView.instantiateViewController(withIdentifier: "toLandingPage") as? LandingPageViewController) {
            
            // assign new navController since we are tearing down the old navController
            let navBarOnModal: UINavigationController = UINavigationController(rootViewController: destViewController)
            self.present(navBarOnModal, animated: true, completion: nil)
        }
    }
}
