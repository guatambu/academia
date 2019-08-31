//
//  StudentInfoDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class StudentInfoDetailsViewController: UIViewController {

    // MARK: - Properties
    
    var isInstructor = false
    // create a fetchedRequestController with predicate to grab the current logged in user by using the ActiveUserModelController.shared.activeUser array contents and isLogged on properties... use this property as the source for the populateCompletedProfileInfo() method
    var fetchedResultsControllerStudentAdults: NSFetchedResultsController<StudentAdultCD>!
    var fetchedResultsControllerStudentKids: NSFetchedResultsController<StudentKidCD>!
    var activeStudentAdult: StudentAdultCD?
    var activeStudentKid: StudentKidCD?
    
    var inEditingMode: Bool?
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var studentNameLabelOutlet: UILabel!
    // isInstructor switch
    @IBOutlet weak var isInstructorStackView: UIStackView!
    @IBOutlet weak var instructorLabelOutlet: UILabel!
    @IBOutlet weak var isInstructorSwitch: UISwitch!
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
    
    // Firebase Firestore properties
    var activeKidStudentFirestore: KidStudentFirestore?
    var activeAdultStudentFirestore: AdultStudentFirestore?
    var activeStudentStorageRef: StorageReference?
    
    var db: Firestore!
    // The handler for the FIREBASE Auth state listener, to allow cancelling later.
    var handle: AuthStateDidChangeListenerHandle?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
//        // create fetch request and initialize results
//        initializeFetchedResultsControllers()
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
                    self.activeStudentStorageRef = Storage.storage().reference().child("profilePics/students/\(uid)")
                    
                    // get the active firestre owner info
                    self.db.collection("students").document(uid).getDocument { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            guard let studentData = querySnapshot?.data() else {
                                
                                print("ERROR: nil value found for studentData in OwnerInfoDetailsViewController.swift -> viewWillAppear - line 101.")
                                return
                            }
                            
                            print("\(String(describing: querySnapshot?.documentID)) => \(String(describing: querySnapshot?.data()))")
                            
                            // check student type
                            let isKid: Bool = (studentData["isKid"] != nil)
                            if isKid == true {
                                
                                self.activeKidStudentFirestore =
                                    
                                    KidStudentFirestore(dictionary: studentData)
                                
                            } else {
                                
                                self.activeAdultStudentFirestore = AdultStudentFirestore(dictionary: studentData)

                            }
                            
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
        
        // check to see if user isKid or not.  only StudentAdultCD may be instructors.
        let isKid = ActiveUserModelController.shared.isKid
        if isKid {
            isInstructorStackView.isHidden = true
            instructorLabelOutlet.isHidden = true
            isInstructorSwitch.isHidden = true
            isInstructorSwitch.isEnabled = false
        } else {
            isInstructorStackView.isHidden = false
            instructorLabelOutlet.isHidden = false
            isInstructorSwitch.isHidden = false
            isInstructorSwitch.isEnabled = false
        }
        
        print("isKid: \(String(describing: isKid))")
        
        // Set up Firestore db reference
        db = Firestore.firestore()
    }
    
    
    // MARK: - Actions
    
    @IBAction func toggleIsInstructorSwitch(_ sender: UISwitch) {
        
        isInstructor = !isInstructor
        print("isInstructorSwitch toggled, currently isInstructor = \(isInstructor)")
        
//        guard let StudentAdultCD = activeStudentAdult else {
//            print("ERROR: nil value found for activeOwner property of type OwnerCD in OwnerInfoDetailsViewController.swift -> toggleIsInstructorSwitch(sender:) - line 87.")
//            return
//        }
//
//        // update the activeOwner's isInstructor value
//        StudentAdultCDModelController.shared.update(studentAdult: StudentAdultCD, isInstructor: isInstructor, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
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
        destViewController.isOwner = false
        
        let isKid = ActiveUserModelController.shared.isKid
        
        if isKid {
            // **** IF KID STUDENT ****
            destViewController.isKid = true
            
            
            if let fetchedKids = fetchedResultsControllerStudentKids.fetchedObjects {
                
                for kid in fetchedKids {
                    if let uuid = kid.kidStudentUUID {
                        if uuid == ActiveUserModelController.shared.activeUser[0] {
                            destViewController.userCDToEdit = kid
                        }
                    }
                }
            }
        } else {
            // **** IF ADULT STUDENT ****
            destViewController.isKid = false
            
            if let fetchedAdults = fetchedResultsControllerStudentAdults.fetchedObjects {
                
                for adult in fetchedAdults {
                    if let uuid = adult.adultStudentUUID {
                        if uuid == ActiveUserModelController.shared.activeUser[0] {
                            destViewController.userCDToEdit = adult
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        
        logoutStudentUserAndReturnToLandingPage()
        
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "are you sure you want to delete your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete account", style: UIAlertAction.Style.destructive) { (alert) in
            
            // check the isKid property
            let isKid = ActiveUserModelController.shared.isKid
            // determine user deletion type
            if isKid {
                let kid = KidStudentModelController.shared.kids[0]
                KidStudentModelController.shared.delete(kidStudent: kid)
            } else {
                let adult = AdultStudentModelController.shared.adults[0]
                AdultStudentModelController.shared.delete(adultStudent: adult)
            }
            
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
            
            // set nav bar controller appearance
            self.navigationController?.navigationBar.tintColor = self.beltBuilder.redBeltRed
            self.navigationController?.navigationBar.backgroundColor = self.beltBuilder.kidsWhiteCenterRibbonColor
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            print("how many owners we got now: \(OwnerModelController.shared.owners.count)")
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
}


// MARK: - setup the view
extension StudentInfoDetailsViewController {
    
    func populateCompletedProfileInfo(user: User?) {
        
//        findActiveUser()
        
//        let isKid = ActiveUserModelController.shared.isKid
        
        if let activeKid = activeKidStudentFirestore {
            
            // KID STUDENT OPTION
            
            // populate UI elements in VC
            studentNameLabelOutlet.text = "\(activeKid.firstName) \(activeKid.lastName)"
            usernameLabelOutlet.text = "username: \(user?.displayName ?? "")"
            // populate birthdate outlet
            formatBirthdate(birthdate: activeKid.birthdate.dateValue())
            // contact info outlets
            phoneLabelOutlet.text = activeKid.phone
            // mobile is not a required field
            if let mobile = activeKid.mobile {
                if mobile  != "" {
                    mobileLabelOutlet.text = mobile
                } else {
                    mobileLabelOutlet.isHidden = true
                }
            }
            emailLabelOutlet.text = activeKid.email
            // parent / guardian name
            parentGuardianLabelOutlet.text = "parent/guardian: \(activeKid.parentGuardian)"
            // address outlets
            addressLine1LabelOutlet.text = activeKid.addressLine1
            // addressLine2 is not a required field
            if activeKid.addressLine2 != "" {
                addressLine2LabelOutlet.text = activeKid.addressLine2
            } else {
                addressLine2LabelOutlet.isHidden = true
            }
            cityLabelOutlet.text = activeKid.city
            stateLabelOutlet.text = activeKid.state
            zipCodeLabelOutlet.text = activeKid.zipCode
            // emergency contact info outlets
            emergencyContactNameLabelOutlet.text = activeKid.emergencyContactName
            emergencyContactRelationshipLabelOutlet.text = activeKid.emergencyContactRelationship
            emergencyContactPhoneLabelOutlet.text = activeKid.emergencyContactPhone
            
            // unwrap activeOwnerStorageRef to get profilePic
            guard let profilePicReference = activeStudentStorageRef else {
                print("ERROR: nil value found for profilePicReference in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 205.")
                return
            }
            // Placeholder image
            let placeholderImage = UIImage(named: "profile_pic_placeholder_image.png")
            // profile pic imageView Load the image using SDWebImage
            profilePicImageView.sd_setImage(with: profilePicReference, placeholderImage: placeholderImage)
            
            // belt holder UIView
            print("Kid Student Info in StudentInfodetailsVC -> beltLevel: \(String(describing: activeKid.beltLevel))")
            print("Kid Student Info in StudentInfodetailsVC -> numberOfStripes:  \(String(describing: activeKid.numberOfStripes))")
            // convert numberOfStripes to Int from Int16 in CoreData
            let stripesInt = Int(activeKid.numberOfStripes)
            // get enum value from CoreData beltLevel String
            let beltLevelEnum = InternationalStandardBJJBelts(rawValue: activeKid.beltLevel)
            // build the belt
            beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevelEnum ?? .adultWhiteBelt, numberOfStripes: stripesInt)
            
        }
        
        if let activeAdult = activeAdultStudentFirestore {
            
            // KID STUDENT OPTION
            
            // populate UI elements in VC
            studentNameLabelOutlet.text = "\(activeAdult.firstName) \(activeAdult.lastName)"
            usernameLabelOutlet.text = "username: \(user?.displayName ?? "")"
            // populate birthdate outlet
            formatBirthdate(birthdate: activeAdult.birthdate.dateValue())
            // contact info outlets
            phoneLabelOutlet.text = activeAdult.phone
            // mobile is not a required field
            if let mobile = activeAdult.mobile {
                if mobile  != "" {
                    mobileLabelOutlet.text = mobile
                } else {
                    mobileLabelOutlet.isHidden = true
                }
            }
            emailLabelOutlet.text = activeAdult.email
            // parent / guardian name
            parentGuardianLabelOutlet.text = ""
            // address outlets
            addressLine1LabelOutlet.text = activeAdult.addressLine1
            // addressLine2 is not a required field
            if activeAdult.addressLine2 != "" {
                addressLine2LabelOutlet.text = activeAdult.addressLine2
            } else {
                addressLine2LabelOutlet.isHidden = true
            }
            cityLabelOutlet.text = activeAdult.city
            stateLabelOutlet.text = activeAdult.state
            zipCodeLabelOutlet.text = activeAdult.zipCode
            // emergency contact info outlets
            emergencyContactNameLabelOutlet.text = activeAdult.emergencyContactName
            emergencyContactRelationshipLabelOutlet.text = activeAdult.emergencyContactRelationship
            emergencyContactPhoneLabelOutlet.text = activeAdult.emergencyContactPhone
            
            // unwrap activeOwnerStorageRef to get profilePic
            guard let profilePicReference = activeStudentStorageRef else {
                print("ERROR: nil value found for profilePicReference in OwnerInfoDetailsViewController.swift -> populateCompletedProfileInfo() - line 205.")
                return
            }
            // Placeholder image
            let placeholderImage = UIImage(named: "profile_pic_placeholder_image.png")
            // profile pic imageView Load the image using SDWebImage
            profilePicImageView.sd_setImage(with: profilePicReference, placeholderImage: placeholderImage)
            
            // belt holder UIView
            print("Kid Student Info in StudentInfodetailsVC -> beltLevel: \(String(describing: activeAdult.beltLevel))")
            print("Kid Student Info in StudentInfodetailsVC -> numberOfStripes:  \(String(describing: activeAdult.numberOfStripes))")
            // convert numberOfStripes to Int from Int16 in CoreData
            let stripesInt = Int(activeAdult.numberOfStripes)
            // get enum value from CoreData beltLevel String
            let beltLevelEnum = InternationalStandardBJJBelts(rawValue: activeAdult.beltLevel)
            // build the belt
            beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevelEnum ?? .adultWhiteBelt, numberOfStripes: stripesInt)
            
        }
        
        
//        if isKid {
//
//            // KID STUDENT OPTION
//            guard let activeStudentKid = activeStudentKid else { return }
//            guard let belt = activeStudentKid.belt else { return }
//
//            // populate UI elements in VC
//            studentNameLabelOutlet.text = "\(activeStudentKid.firstName ?? "") \(activeStudentKid.lastName ?? "")"
//            usernameLabelOutlet.text = "username: \(activeStudentKid.username ?? "")"
//            // populate birthdate outlet
//            if let birthdate = activeStudentKid.birthdate {
//
//                formatBirthdate(birthdate: birthdate)
//            }
//            // contact info outlets
//            phoneLabelOutlet.text = activeStudentKid.phone
//            // mobile is not a required field
//            if activeStudentKid.mobile != "" {
//                mobileLabelOutlet.text = activeStudentKid.mobile
//            } else {
//                mobileLabelOutlet.isHidden = true
//            }
//            emailLabelOutlet.text = activeStudentKid.email
//            // parent / guardian name
//            parentGuardianLabelOutlet.text = "parent/guardian: \(activeStudentKid.parentGuardian ?? "")"
//            // address outlets
//            addressLine1LabelOutlet.text = activeStudentKid.address?.addressLine1
//            // addressLine2 is not a required field
//            if activeStudentKid.address?.addressLine2 != "" {
//                addressLine2LabelOutlet.text = activeStudentKid.address?.addressLine2
//            } else {
//                addressLine2LabelOutlet.isHidden = true
//            }
//            cityLabelOutlet.text = activeStudentKid.address?.city
//            stateLabelOutlet.text = activeStudentKid.address?.state
//            zipCodeLabelOutlet.text = activeStudentKid.address?.zipCode
//            // emergency contact info outlets
//            emergencyContactNameLabelOutlet.text = activeStudentKid.emergencyContact?.name
//            emergencyContactRelationshipLabelOutlet.text = activeStudentKid.emergencyContact?.relationship
//            emergencyContactPhoneLabelOutlet.text = activeStudentKid.emergencyContact?.phone
//
//            // profile pic imageView
//            if let profilePicData = activeStudentKid.profilePic {
//
//                profilePicImageView.image = UIImage(data: profilePicData)
//            }
//
//            // belt holder UIView
//            print("Kid Student Info in StudentInfodetailsVC -> beltLevel: \(String(describing: activeStudentKid.belt?.beltLevel))")
//            print("Kid Student Info in StudentInfodetailsVC -> \(String(describing: activeStudentKid.belt?.numberOfStripes))")
//
//            // convert numberOfStripes to Int from Int16 in CoreData
//            let stripesInt = Int(belt.numberOfStripes)
//            // get enum value from CoreData beltLevel String
//            if let beltLevel = belt.beltLevel {
//                let beltLevelEnum = InternationalStandardBJJBelts(rawValue: beltLevel)
//                // build the belt
//                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevelEnum ?? .adultWhiteBelt, numberOfStripes: stripesInt)
//            }
//
//        } else {
//
//            // ADULT STUDENT OPTION
//            guard let activeStudentAdult = activeStudentAdult else { return }
//            guard let belt = activeStudentAdult.belt else { return }
//
//            // populate UI elements in VC
//            studentNameLabelOutlet.text = "\(activeStudentAdult.firstName ?? "") \(activeStudentAdult.lastName ?? "")"
//            usernameLabelOutlet.text = "username: \(activeStudentAdult.username ?? "")"
//            // populate birthdate outlet
//            formatBirthdate(birthdate: activeStudentAdult.birthdate ?? Date())
//            // contact info outlets
//            phoneLabelOutlet.text = activeStudentAdult.phone
//            // mobile is not a required field
//            if activeStudentAdult.mobile != "" {
//                mobileLabelOutlet.text = activeStudentAdult.mobile
//            } else {
//                mobileLabelOutlet.isHidden = true
//            }
//            emailLabelOutlet.text = activeStudentAdult.email
//            // address outlets
//            addressLine1LabelOutlet.text = activeStudentAdult.address?.addressLine1
//            // addressLine2 is not a required field
//            if activeStudentAdult.address?.addressLine2 != "" {
//                addressLine2LabelOutlet.text = activeStudentAdult.address?.addressLine2
//            } else {
//                addressLine2LabelOutlet.isHidden = true
//            }
//            cityLabelOutlet.text = activeStudentAdult.address?.city
//            stateLabelOutlet.text = activeStudentAdult.address?.state
//            zipCodeLabelOutlet.text = activeStudentAdult.address?.zipCode
//            // emergency contact info outlets
//            emergencyContactNameLabelOutlet.text = activeStudentAdult.emergencyContact?.name
//            emergencyContactRelationshipLabelOutlet.text = activeStudentAdult.emergencyContact?.relationship
//            emergencyContactPhoneLabelOutlet.text = activeStudentAdult.emergencyContact?.phone
//
//            // profile pic imageView
//            if let profilePicData = activeStudentAdult.profilePic {
//
//                profilePicImageView.image = UIImage(data: profilePicData)
//            }
//
//            // belt holder UIView
//            print("Adult Student Info in StudentInfodetailsVC -> beltLevel: \(String(describing: belt.beltLevel))")
//            print("Adult Student Info in StudentInfodetailsVC -> \(belt.numberOfStripes)")
//            // convert numberOfStripes to Int from Int16 in CoreData
//            let stripesInt = Int(belt.numberOfStripes)
//            // get enum value from CoreData beltLevel String
//            if let beltLevel = belt.beltLevel {
//                let beltLevelEnum = InternationalStandardBJJBelts(rawValue: beltLevel)
//                // build the belt
//                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevelEnum ?? .adultWhiteBelt, numberOfStripes: stripesInt)
//            }
//        }
    }
}
        

// MARK: - formatBirthdate()
extension StudentInfoDetailsViewController {
    func formatBirthdate(birthdate: Date) {
        
        // set up date format
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let birthdateString = dateFormatter.string(from: birthdate)
        
        print("StudentInfoDetailsVC -> formatBirthdate(birthdate:) - current student birthdate: \(birthdateString)")
        
        self.birthdateLabelOutlets.text = "birthdate: " + birthdateString
    }
}


// MARK: - fetched ResultsController and findActiveUser()
extension StudentInfoDetailsViewController: NSFetchedResultsControllerDelegate {
        
        func initializeFetchedResultsControllers() {

            initializeFetchResultsControllerStudentKidCD()
            
            initializeFetchResultsControllerStudentAdultCD()
            
        }
    
    func initializeFetchResultsControllerStudentKidCD() {
        
        let requestStudentKid = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentKidCD")
        
        let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
        requestStudentKid.sortDescriptors = [lastNameSort]
        
        let moc = CoreDataStack.context
        
        fetchedResultsControllerStudentKids = NSFetchedResultsController(fetchRequest: requestStudentKid, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<StudentKidCD>
        
        fetchedResultsControllerStudentKids.delegate = self
        
        do {
            try fetchedResultsControllerStudentKids.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    
    }
    
    func initializeFetchResultsControllerStudentAdultCD() {
        
        let requestStudentAdult = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentAdultCD")
        
        let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
        requestStudentAdult.sortDescriptors = [lastNameSort]
        
        let moc = CoreDataStack.context
        
        fetchedResultsControllerStudentAdults = NSFetchedResultsController(fetchRequest: requestStudentAdult, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<StudentAdultCD>
        
        fetchedResultsControllerStudentAdults.delegate = self
        
        do {
            try fetchedResultsControllerStudentAdults.performFetch()
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
        
        let isKid = ActiveUserModelController.shared.isKid
        
        if isKid {
            // match kid with activeUser UUID
            guard let activeKids = fetchedResultsControllerStudentKids.fetchedObjects else { return }
            
            for kid in activeKids {
            
                if kid.kidStudentUUID == uuid {
                    activeStudentKid = kid
                    print("SUCCESS: activeKidStudent uuid matches a kid named: \(String(describing: activeStudentKid?.firstName)) \(String(describing: activeStudentKid?.lastName))")
                    return
                }
            }
        } else {
            // match adult with activeUser UUID
            guard let activeAdults = fetchedResultsControllerStudentAdults.fetchedObjects else { return }
            print("activeAdults in findActiveUSer: \(activeAdults)")
            for adult in activeAdults {
                
                if adult.adultStudentUUID == uuid {
                    activeStudentAdult = adult
                    print("SUCCESS: activeKidStudent uuid matches an adult named: \(String(describing: activeStudentAdult?.firstName)) \(String(describing: activeStudentAdult?.lastName))")
                    return
                }
            }
        }
    }
}


// MARK: - Programmatic Segues to return to LandingPage and logout current Student User
extension StudentInfoDetailsViewController {
    
    func logoutStudentUserAndReturnToLandingPage() {
        
        // give user the chance to cancel logout in case of accidental logout button tap
        let alertController = UIAlertController(title: "Logout", message: "are you sure you want to logout of your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let logout = UIAlertAction(title: "logout", style: UIAlertAction.Style.destructive) { (alert) in
        
            // remove current Student User from ActiveUserModelController active user array
            // this array should be totally empty whenever no user of any type is logged in
            ActiveUserModelController.shared.activeUser.removeAll()
            
            // set isLoggedOn property of Student User to false
            if let activeStudentAdult = self.activeStudentAdult {
                activeStudentAdult.isLoggedOn = false
            }
            if let activeStudentKid = self.activeStudentKid {
                activeStudentKid.isLoggedOn = false
            }
            // return to the LandingPageVC scene
            self.returnToLandingPage()
        }
            
        alertController.addAction(cancel)
        alertController.addAction(logout)
        
        self.present(alertController, animated: true)
        
    }
}



