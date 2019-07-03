//
//  CompletedProfileViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class CompletedProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var profilePic: UIImage?
    var birthdate: Date?
    var beltLevel: InternationalStandardBJJBelts?
    var numberOfStripes: Int?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var phone: String?
    var mobile: String?
    var email: String?
    var emergencyContactName: String?
    var emergencyContactPhone: String?
    var emergencyContactRelationship: String?
    var parentGuardian: String?
    
    var belt: Belt?
    
    var beltCD: BeltCD?
    var addressCD: AddressCD?
    var emergencyContactCD: EmergencyContactCD?
    var groupCD: GroupCD?
    var newStudentKidCD: StudentKidCD?
    var newStudentAdultCD: StudentAdultCD?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()
    
    // name outlet
    @IBOutlet weak var nameLabelOutlet: UILabel!
    // username outlet
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    // birthdate outlet
    @IBOutlet weak var birthdateLabelOutlet: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        populateCompletedProfileInfo(username: username, firstName: firstName, lastName: lastName, profilePic: profilePic, birthdate: birthdate, beltLevel: beltLevel, numberOfStripes: numberOfStripes, parentGuardian: parentGuardian, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email, emergencyContactName: emergencyContactName, emergencyContactPhone: emergencyContactPhone, emergencyContactRelationship: emergencyContactRelationship)
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        // check to see how many owner profiles exist (if any).  if there is one or more ownersCD objects saved, fire the warning to the user to make sure they want to add an owner account.
        if let isOwner = isOwner {
            if isOwner {
                
                if OwnerCDModelController.shared.owners.count >= 1 {
                    checkIfMoreThanOneOwnerAccountAllowedByOwner()
                    print("owners count: \(OwnerCDModelController.shared.owners.count)")
                }
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func createAccountButtonTapped(_ sender: DesignableButton) {
        
        // create and save new user account to CoreData
        createAndSaveNewUser()

        // place network call to firebase firestore for account creation
        
        // programmatically performing the segue
        guard let isOwner = isOwner else { return }
        
        if isOwner {
            
            // instantiate the relevant storyboard for the Owner
            let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
            // create the UITabBarController segue programmatically - MODAL
            if let tabBarDestViewController = (mainView.instantiateViewController(withIdentifier: "toOwnerBaseCamp") as? UITabBarController) {
                
                self.present(tabBarDestViewController, animated: true, completion: nil)
                
                navigationController?.navigationBar.shadowImage = UIImage()
                
                // exit funciton
                return
            }
            
        } else if isOwner == false {
            // unwrap isOwnerAddingStudent? 
            guard let isOwnerAddingStudent = isOwnerAddingStudent else {
                
                print("ERROR: a nil value was found when trying to unwrap isOwnerAddingStudent in CompletedProfileViewController.swift -> createAccountButtonTapped(sender:) - line 100.")
                
                // instantiate the relevant storyboard for the Student (Kid or Adult... both are directed to the same TabBarController)
                let mainView: UIStoryboard = UIStoryboard(name: "StudentBaseCampFlow", bundle: nil)
                // create the UITabBarController segue programmatically - MODAL
                if let tabBarDestViewController = (mainView.instantiateViewController(withIdentifier: "toStudentDashboard") as? UITabBarController) {
                    
                    self.present(tabBarDestViewController, animated: true, completion: nil)
                    
                    navigationController?.navigationBar.shadowImage = UIImage()
                }
                
                // exit function
                return
            }
            
            if isOwnerAddingStudent {
                // need to append the created user to the appropriate group

                guard let isKid = isKid else {
                    print("ERROR: a nil value was found when trying to unwrap isKid property in CompletedProfileViewController.swift -> createAccountButtonTapped(sender:) - line 153.")
                    return
                }
                guard let groupCD = groupCD else {
                    print("ERROR: a nil value was found when trying to unwrap groupCD property in CompletedProfileViewController.swift -> createAccountButtonTapped(sender:) - line 157.")
                    return
                }
        
                if isKid {
                    
                    // CoreData - update the group to include this student
                    guard let newStudentKidCD = newStudentKidCD else {
                        print("ERROR: a nil value was found when trying to unwrap newStudentKidCD property in CompletedProfileViewController.swift -> createAccountButtonTapped(sender:) - line 171.")
                        return
                    }
                    groupCD.addToKidMembers(newStudentKidCD)
                    OwnerCDModelController.shared.saveToPersistentStorage()
                } else {
                    
                    // CoreData - update the group to include this student
                    guard let newStudentAdultCD = newStudentAdultCD else {
                        print("ERROR: a nil value was found when trying to unwrap newStudentAdultCD property in CompletedProfileViewController.swift -> createAccountButtonTapped(sender:) - line 171.")
                        return
                    }
                    groupCD.addToAdultMembers(newStudentAdultCD)
                    OwnerCDModelController.shared.saveToPersistentStorage()
                }
                
                returnToGroupInfo()
                
            } else if isOwnerAddingStudent == false {
                print("ERROR:  we have a non nil value of isOwnerAddingStudent = false... isOwnerAdding student should only be nil or true.  CompletedProfileViewController.swift -> createAccountButtonTapped(_ sender:) - line 141.")
            }
        }
    }
}

// MARK: - date formatter setup for birthdate display
extension CompletedProfileViewController {
    
    func formatBirthdate(birthdate: Date) {
        
        // set up date format
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let birthdateString = dateFormatter.string(from: birthdate)
        
        print(birthdateString)
        
        self.birthdateLabelOutlet.text = "birthdate: " + birthdateString
    }
}


//MARK: - populate CompletedProfileVC with user info for display at viewDidLoad()
extension CompletedProfileViewController {
    
    func populateCompletedProfileInfo(username: String?,
                                      firstName: String?,
                                      lastName: String?,
                                      profilePic: UIImage?,
                                      birthdate: Date?,
                                      beltLevel: InternationalStandardBJJBelts?,
                                      numberOfStripes: Int?,
                                      parentGuardian: String?,
                                      addressLine1: String?,
                                      addressLine2: String?,
                                      city: String?,
                                      state: String?,
                                      zipCode: String?,
                                      phone: String?,
                                      mobile: String?,
                                      email: String?,
                                      emergencyContactName: String?,
                                      emergencyContactPhone: String?,
                                      emergencyContactRelationship: String?) {
        
        guard let profilePic = profilePic else { print("fail profilePic"); return }
        guard let username = username else { print("fail username"); return }
        guard let password = password else { print("fail password"); return }
        guard let firstName = firstName else { print("fail firtsName"); return }
        guard let lastName = lastName else { print("fail lastName"); return }
        guard let beltLevel = beltLevel else { print("fail beltLevel"); return }
        guard let numberOfStripes = numberOfStripes else { print("fail stripes"); return }
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        
        // print to console for developer verification
        print("username: \(username) \npassword: \(password) \nfirstName: \(firstName) \nlastName: \(lastName) \nbirthdate: \(String(describing: birthdate)) \nbeltLevel: \(beltLevel) \nnumberOfStripes: \(numberOfStripes) \naddressLine1: \(String(describing: addressLine1)) \naddressLine2: \(String(describing: addressLine2)) \ncity: \(String(describing: city)) \nstate: \(String(describing: state)) \nzipCode: \(String(describing: zipCode)) \nphone: \(phone) \nmobile: \(String(describing: mobile)) \nemail: \(email) \nemergencyContactName: \(String(describing: emergencyContactName)) \nemergencyContactRelationship: \(String(describing: emergencyContactRelationship)) \nemergencyContactPhone: \(String(describing: emergencyContactPhone)) \nparentGuardian: \(String(describing: parentGuardian))")
        
        // populate UI elements in VC
        title = "Please Review Your Info"
        nameLabelOutlet.text = "\(firstName) \(lastName)"
        usernameLabelOutlet.text = "user: " + username
        // contact info outlets
        phoneLabelOutlet.text = "p: " + phone
        // mobile is not a required field
        mobileLabelOutlet.text = "m: \(mobile ?? "")"
        emailLabelOutlet.text = email
        // address outlets
        parentGuardianLabelOutlet.text = "guardian: \(parentGuardian ?? "")"
        addressLine1LabelOutlet.text = addressLine1 ?? ""
        // addressLine2 is not a required field
        addressLine2LabelOutlet.text = addressLine2 ?? ""
        cityLabelOutlet.text = city ?? ""
        stateLabelOutlet.text = state ?? ""
        zipCodeLabelOutlet.text = zipCode ?? ""
        // emergency contact info outlets
        emergencyContactNameLabelOutlet.text = emergencyContactName ?? ""
        emergencyContactRelationshipLabelOutlet.text = emergencyContactRelationship ?? ""
        emergencyContactPhoneLabelOutlet.text = emergencyContactPhone ?? ""
        
        // profile pic imageView
        profilePicImageView.image = profilePic
        
        // display birthdate
        if let birthdate = birthdate {
            formatBirthdate(birthdate: birthdate)
        }
        
        // belt holder UIView
        // this is set up below to directly accept a value from InternationalStandarBJJBelts
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
    }
}


// MARK: - AlertController to check if more than one owner account allowed by actual owner
extension CompletedProfileViewController {
    
    func checkIfMoreThanOneOwnerAccountAllowedByOwner() {
        
        let alertController = UIAlertController(title: "Attention", message: "are you sure you want to add more than one owner to this account?", preferredStyle: UIAlertController.Style.alert)
        
        let deleteAccount = UIAlertAction(title: "Thanks for the heads up!", style: UIAlertAction.Style.default, handler: nil)
        
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
    }
}


// MARK: - function to initiate user account model creation process and save the user in CoreData
extension CompletedProfileViewController {
    
    func createAndSaveNewUser() {
        
        // create belt model in CoreData
        createBeltCoreDataModel()
        // create address model in CoreData
        createAddressCoreDataModel()
        // create emergency contact model in CoreData
        createEmergencyContactCoreDataModel()
        // create new user account in CoreData
        createUserAccountAndLoginCoreDataModel()
    }
}

// MARK: - function to create user account model in CoreData
extension CompletedProfileViewController {
    
    // create User model
    func createUserAccountAndLoginCoreDataModel() {
        
        guard let isOwner = isOwner else { print("fail isOwner"); return }
        guard let isKid = isKid else { print("fail isKid"); return }
        
        guard let username = username else { print("fail username"); return }
        guard let password = password else { print("fail password"); return }
        
        guard let firstName = firstName else { print("fail firtsName"); return }
        guard let lastName = lastName else { print("fail lastName"); return }
        guard let parentGuardian = parentGuardian else { print("fail parentGuardian"); return }
        guard let profilePic = profilePic else { print("fail profilePic"); return }
        
//        guard let birthdate = birthdate else { print("fail birthdate"); return }
        
        guard let beltCD = beltCD else { print("fail beltCD"); return }
        
        guard let addressCD = addressCD else { print("fail addressCD"); return }
        
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        guard let emergencyContactCD = emergencyContactCD else { print("fail emergencyContactCD"); return }
        
        let mobileCD = mobile ?? ""
        
        // convert profilePic to Data
        guard let profilePicData = profilePic.jpegData(compressionQuality: 1) else { print("fail profilePicData"); return }
        
        if isOwner{
            
            let newOwner = OwnerCD(mostRecentPromotion: nil, studentStatus: nil, belt: beltCD, profilePic: profilePicData, username: username, password: password, firstName: firstName, lastName: lastName, address: addressCD, phone: phone, mobile: mobileCD, email: email, emergencyContact: emergencyContactCD)
            
            OwnerCDModelController.shared.add(owner: newOwner)
            
            if let id = newOwner.ownerUUID {
                ActiveUserModelController.shared.activeUser.append(id)
            }
            
            // check and if present, add birthdate value
            addBirthdate(owner: newOwner, kid: nil, adult: nil)
            // toggle the owner isLoggedOn to true as they have successfully logged on for the first time
            newOwner.isLoggedOn = true
            // set the isKid value in ActiveUserModelController to false
            ActiveUserModelController.shared.isKid = false
            
        } else if isKid {
            
            let newStudentKid = StudentKidCD(studentStatus: nil, belt: beltCD, profilePic: profilePicData, username: username, password: password, firstName: firstName, lastName: lastName, parentGuardian: parentGuardian, address: addressCD, phone: phone, mobile: mobileCD, email: email, emergencyContact: emergencyContactCD)
            
            StudentKidCDModelController.shared.add(studentKid: newStudentKid)
            
            if let id = newStudentKid.kidStudentUUID {
                ActiveUserModelController.shared.activeUser.append(id)
            }
            
            // check and if present, add birthdate value
            addBirthdate(owner: nil, kid: newStudentKid, adult: nil)
            // toggle the owner isLoggedOn to true as they have successfully logged on for the first time
            newStudentKid.isLoggedOn = true
            // set the isKid value in ActiveUserModelController to true
            ActiveUserModelController.shared.isKid = true
            // if isOwnerAddingStudent == true, then we update the local newStudentKidCD property to the newly created newStudentKid
            if let isOwnerAddingStudent = isOwnerAddingStudent {
                
                if isOwnerAddingStudent {
                    // pass to CoreData local property
                    newStudentKidCD = newStudentKid
                }
            }
            
        } else if !isKid {
            
            let newStudentAdult = StudentAdultCD(isInstructor: false, studentStatus: nil, belt: beltCD, profilePic: profilePicData, username: username, password: password, firstName: firstName, lastName: lastName, address: addressCD, phone: phone, mobile: mobileCD, email: email, emergencyContact: emergencyContactCD)

            StudentAdultCDModelController.shared.add(studentAdult: newStudentAdult)
            
            if let id = newStudentAdult.adultStudentUUID {
                ActiveUserModelController.shared.activeUser.append(id)
            }
            
            // check and if present, add birthdate value
            addBirthdate(owner: nil, kid: nil, adult: newStudentAdult)
            // toggle the owner isLoggedOn to true as they have successfully logged on for the first time
            newStudentAdult.isLoggedOn = true
            // set the isKid value in ActiveUserModelController to false
            ActiveUserModelController.shared.isKid = false
            
            // if isOwnerAddingStudent == true, then we update the local newStudentAdultCD property to the newly created newStudentAdult
            if let isOwnerAddingStudent = isOwnerAddingStudent {
                
                if isOwnerAddingStudent {
                    // pass to CoreData local property
                    newStudentAdultCD = newStudentAdult
                }
            }
        }
        // CoreData save
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}


// MARK: - function to create belt data model in CoreData
extension CompletedProfileViewController {
    
    func createBeltCoreDataModel() {
        
        // pass CoreData belt properties
        guard let numberOfStripes = numberOfStripes else { return }
        guard let beltLevel = beltLevel?.rawValue else { return }
        // convert numberOfStripes to Int16
        guard let stripesInt16 = Int16(exactly: numberOfStripes) else { return }
        
        beltCD = BeltCD(beltLevel: beltLevel, beltPromotionAttendanceCriteria: nil, beltStripeAgeDetails: nil, classesToNextPromotion: nil, numberOfStripes: stripesInt16)
    }
}


// MARK: - function to add birthdate in CoreData
extension CompletedProfileViewController {
    
    func addBirthdate(owner: OwnerCD?, kid: StudentKidCD?, adult: StudentAdultCD?) {
        // for user privacy criteria, this is optional upon account creation, and the user can update it easily at a later date if so desired
        
        // check the birthdate optional value
        guard let birthdate = birthdate else {
            print("user has not added a birthdate in CompletedProfileViewController.swift -> addBirtdate() - line 442")
            return
        }
        // check for the appropriate user to add birthdate when present
        if let owner = owner {
            owner.birthdate = birthdate
        }
        if let kid = kid {
            kid.birthdate = birthdate
        }
        if let adult = adult {
            adult.birthdate = birthdate
        }
    }
}


// MARK: - function to create address data model in CoreData
extension CompletedProfileViewController {
    
    // for user privacy criteria, this is optional upon account creation, so we simply create an object with no information so the user can update it easily at a later date if so desired
    func createAddressCoreDataModel() {
        
        let addressLine1CD = addressLine1 ?? ""
        
        let addressLine2CD = addressLine2 ?? ""
        
        let cityCD = city ?? ""
        
        let stateCD = state ?? ""
        
        let zipCodeCD = zipCode ?? ""
        
        addressCD = AddressCD(addressLine1: addressLine1CD, addressLine2: addressLine2CD, city: cityCD, state: stateCD, zipCode: zipCodeCD)
    }
}


// MARK: - function to create emergency contact data model in CoreData
extension CompletedProfileViewController {
    
    // for user privacy criteria, this is optional upon account creation, so we simply create an object with no information so the user can update it easily at a later date if so desired
    func createEmergencyContactCoreDataModel() {
        
        let name = emergencyContactName ?? ""
        
        let phone = emergencyContactPhone ?? ""
        
        let relationship = emergencyContactRelationship ?? ""
        
        emergencyContactCD = EmergencyContactCD(name: name, phone: phone, relationship: relationship)
    }
}


// MARK: - Firesbase Firestore Users Model creation
extension CompletedProfileViewController {
    
}
