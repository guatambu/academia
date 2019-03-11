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
        
        if OwnerCDModelController.shared.owners.count > 1 {
            checkIfMoreThanOneOwnerAccountAllowedByOwner()
            print("owners count: \(OwnerCDModelController.shared.owners.count)")
        } 
    
    }
    
    
    // MARK: - Actions
    
    @IBAction func createAccountButtonTapped(_ sender: DesignableButton) {
        
        // create and save new user account to CoreData
        createAndSaveNewUser()
        
        // create data models
        createBelt()
        
        createUser(isOwner: isOwner, isKid: isKid, birthdate: birthdate, username: username, password: password, firstName: firstName, lastName: lastName, profilePic: profilePic, belt: belt, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email, emergencyContactName: emergencyContactName, emergencyContactPhone: emergencyContactPhone, emergencyContactRelationship: emergencyContactRelationship, parentGuardian: parentGuardian)
        
        // place network call to firebase firestore for account creation
        
        // programmatically performing the segue
        guard let isOwner = isOwner else { return }
        if isOwner {
            
            // instantiate the relevant storyboard for the Owner
            let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
            // create the UITabBarController segue programmatically - MODAL
            if let tabBarDestViewController = (mainView.instantiateViewController(withIdentifier: "toOwnerBaseCamp") as? UITabBarController) {
                
                self.present(tabBarDestViewController, animated: true, completion: nil)
                
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
                if let tabBarDestViewController = (mainView.instantiateViewController(withIdentifier: "toStudentDashbooard") as? UITabBarController) {
                    
                    self.present(tabBarDestViewController, animated: true, completion: nil)
                    
                }
                
                // exit function
                return
            }
            
            if isOwnerAddingStudent {
                // need to append the created user to the appropriate group
                guard let group = group else {
                    print("ERROR: a nil value was found when trying to unwrap group property in CompletedProfileViewController.swift -> createAccountButtonTapped(sender:) - line 112.")
                    return
                }
                guard let isKid = isKid else {
                    print("ERROR: a nil value was found when trying to unwrap isKid property in CompletedProfileViewController.swift -> createAccountButtonTapped(sender:) - line 118.")
                    return
                }
                if isKid {
                    // get the kidStudent and update the group to include this student
                    let kidStudent = KidStudentModelController.shared.kids.last
                    // update the group to include this student
                    GroupModelController.shared.update(group: group, active: nil, name: nil, description: nil, kidMembers: nil, adultMembers: nil, kidStudent: kidStudent, adultStudent: nil)
                } else {
                    // get the adultStudent and update the group to include this student
                    let adultStudent = AdultStudentModelController.shared.adults.last
                    // update the group to include this student
                    GroupModelController.shared.update(group: group, active: nil, name: nil, description: nil, kidMembers: nil, adultMembers: nil, kidStudent: nil, adultStudent: adultStudent)
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
        guard let birthdate = birthdate else { print("fail birthdate"); return }
        guard let beltLevel = beltLevel else { print("fail beltLevel"); return }
        guard let numberOfStripes = numberOfStripes else { print("fail stripes"); return }
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        guard let city = city else { print("fail city"); return }
        guard let state = state else { print("fail state"); return }
        guard let zipCode = zipCode else { print("fail zip"); return }
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        guard let emergencyContactName = emergencyContactName else { print("fail emergencyContactName"); return }
        guard let emergencyContactRelationship = emergencyContactRelationship else { print("fail emergencyContactRelationship"); return }
        guard let emergencyContactPhone = emergencyContactPhone else { print("fail emergencyContactPhone"); return }
        
        
        // print to console for developer verification
        print("username: \(username) \npassword: \(password) \nfirstName: \(firstName) \nlastName: \(lastName) \nbirthdate: \(birthdate) \nbeltLevel: \(beltLevel) \nnumberOfStripes: \(numberOfStripes) \naddressLine1: \(addressLine1) \naddressLine2: \(String(describing: addressLine2)) \ncity: \(city) \nstate: \(state) \nzipCode: \(zipCode) \nphone: \(phone) \nmobile: \(String(describing: mobile)) \nemail: \(email) \nemergencyContactName: \(emergencyContactName) \nemergencyContactRelationship: \(emergencyContactRelationship) \nemergencyContactPhone: \(emergencyContactPhone) \nparentGuardian: \(String(describing: parentGuardian))")
        
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
        addressLine1LabelOutlet.text = addressLine1
        // addressLine2 is not a required field
        addressLine2LabelOutlet.text = addressLine2 ?? ""
        cityLabelOutlet.text = city
        stateLabelOutlet.text = state
        zipCodeLabelOutlet.text = zipCode
        // emergency contact info outlets
        emergencyContactNameLabelOutlet.text = emergencyContactName
        emergencyContactRelationshipLabelOutlet.text = emergencyContactRelationship
        emergencyContactPhoneLabelOutlet.text = emergencyContactPhone
        
        // profile pic imageView
        profilePicImageView.image = profilePic
        
        // display birthdate
        formatBirthdate(birthdate: birthdate)
        
        // belt holder UIView
        // this is set up below to directly accept a value from InternationalStandarBJJBelts
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
    }
}

// MARK: - Create Data Models Functions
extension CompletedProfileViewController {
    
    // create a Belt model for a User
    func createBelt() {
        
        guard let beltLevel = beltLevel else { print("fail beltLevel"); return }
        guard let numberOfStripes = numberOfStripes else { print("fail stripes"); return }
        
        print("CompletedProfileVC -> createBelt() - beltLevel: \(beltLevel.rawValue) numberOfStripes: \(numberOfStripes)")
        
        belt = Belt(classesToNextPromotion: 32, beltLevel: beltLevel, numberOfStripes: numberOfStripes)

    }
    
    // create User model
    func createUser(isOwner: Bool?,
                     isKid: Bool?,
                     birthdate: Date?,
                     username: String?,
                     password: String?,
                     firstName: String?,
                     lastName: String?,
                     profilePic: UIImage?,
                     belt: Belt?,
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
                     emergencyContactRelationship: String?,
                     parentGuardian: String?) {
        
        guard let isOwner = isOwner else { print("fail isOwner"); return }
        guard let isKid = isKid else { print("fail isKid"); return }
        guard let profilePic = profilePic else { print("fail profilePic"); return }
        guard let username = username else { print("fail username"); return }
        guard let password = password else { print("fail password"); return }
        guard let firstName = firstName else { print("fail firtsName"); return }
        guard let lastName = lastName else { print("fail lastName"); return }
        guard let belt = belt else { print("fail belt"); return }
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        guard let city = city else { print("fail city"); return }
        guard let state = state else { print("fail state"); return }
        guard let zipCode = zipCode else { print("fail zip"); return }
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        guard let emergencyContactName = emergencyContactName else { print("fail emergencyContactName"); return }
        guard let emergencyContactRelationship = emergencyContactRelationship else { print("fail emergencyContactRelationship"); return }
        guard let emergencyContactPhone = emergencyContactPhone else { print("fail emergencyContactPhone"); return }
        
        guard let parentGuardian = parentGuardian else { print("fail parentGuardian"); return }
        guard let birthdate = birthdate else { print("fail birthdate"); return }
        
        let addressLine2 = addressLine2 ?? ""
        let mobile = mobile ?? ""
        
        if isOwner{
            
            OwnerModelController.shared.addNew(birthdate: birthdate,
                                               belt: belt,
                                               profilePic: profilePic,
                                               username: username,
                                               password: password,
                                               firstName: firstName,
                                               lastName: lastName,
                                               addressLine1: addressLine1,
                                               addressLine2: addressLine2,
                                               city: city,
                                               state: state,
                                               zipCode: zipCode,
                                               phone: phone,
                                               mobile: mobile,
                                               email: email,
                                               emergencyContactName: emergencyContactName,
                                               emergencyContactPhone: emergencyContactPhone,
                                               emergencyContactRelationship: emergencyContactRelationship)
        } else if isKid {
            
            KidStudentModelController.shared.addNew(birthdate: birthdate,
                                                    belt: belt,
                                                    profilePic: profilePic,
                                                    username: username,
                                                    password: password,
                                                    firstName: firstName,
                                                    lastName: lastName,
                                                    parentGuardian: parentGuardian,
                                                    addressLine1: addressLine1,
                                                    addressLine2: addressLine2,
                                                    city: city,
                                                    state: state,
                                                    zipCode: zipCode,
                                                    phone: phone,
                                                    mobile: mobile,
                                                    email: email,
                                                    emergencyContactName: emergencyContactName,
                                                    emergencyContactPhone: emergencyContactPhone,
                                                    emergencyContactRelationship: emergencyContactRelationship)
            
            print("kid just created in CompletedProfileVC birthdate: \(String(describing: KidStudentModelController.shared.kids.last?.birthdate))")
            
        } else if !isKid {
            
            AdultStudentModelController.shared.addNew(birthdate: birthdate,
                                                      belt: belt,
                                                      profilePic: profilePic,
                                                      username: username,
                                                      password: password,
                                                      firstName: firstName,
                                                      lastName: lastName,
                                                      addressLine1: addressLine1,
                                                      addressLine2: addressLine2,
                                                      city: city,
                                                      state: state,
                                                      zipCode: zipCode,
                                                      phone: phone,
                                                      mobile: mobile,
                                                      email: email,
                                                      emergencyContactName: emergencyContactName,
                                                      emergencyContactPhone: emergencyContactPhone,
                                                      emergencyContactRelationship: emergencyContactRelationship)
        }
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
        // CoreData save
        OwnerCDModelController.shared.saveToPersistentStorage()
        
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
        
        guard let birthdate = birthdate else { print("fail birthdate"); return }
        
        guard let beltCD = beltCD else { print("fail beltCD"); return }
        
        guard let addressCD = addressCD else { print("fail addressCD"); return }
        
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        guard let emergencyContactCD = emergencyContactCD else { print("fail emergencyContactCD"); return }
        
        let mobileCD = mobile ?? ""
        
        // convert profilePic to Data
        guard let profilePicData = profilePic.jpegData(compressionQuality: 1) else { print("fail profilePicData"); return }
        
        
        
        if isOwner{
            
            let newOwner = OwnerCD(birthdate: birthdate, mostRecentPromotion: nil, studentStatus: nil, belt: beltCD, profilePic: profilePicData, username: username, password: password, firstName: firstName, lastName: lastName, address: addressCD, phone: phone, mobile: mobileCD, email: email, emergencyContact: emergencyContactCD)
            
            OwnerCDModelController.shared.add(owner: newOwner)
            
            if let id = newOwner.ownerUUID {
                ActiveUserModelController.shared.activeUser.append(id)
            }
        
            newOwner.isLoggedOn = true
            
        } else if isKid {
            
            let newStudentKid = StudentKidCD(dateCreated: Date(), dateEdited: Date(), birthdate: birthdate, studentStatus: nil, belt: beltCD, profilePic: profilePicData, username: username, password: password, firstName: firstName, lastName: lastName, parentGuardian: parentGuardian, address: addressCD, phone: phone, mobile: mobileCD, email: email, emergencyContact: emergencyContactCD)
            
            StudentKidCDModelController.shared.add(studentKid: newStudentKid)
            
            if let id = newStudentKid.kidStudentUUID {
                ActiveUserModelController.shared.activeUser.append(id)
            }
            
            newStudentKid.isLoggedOn = true
            
        } else if !isKid {
            
            let newStudentAdult = StudentAdultCD(isInstructor: false, dateCreated: Date(), dateEdited: Date(), birthdate: birthdate, studentStatus: nil, belt: beltCD, profilePic: profilePicData, username: username, password: password, firstName: firstName, lastName: lastName, address: addressCD, phone: phone, mobile: mobileCD, email: email, emergencyContact: emergencyContactCD)

            StudentAdultCDModelController.shared.add(studentAdult: newStudentAdult)
            
            if let id = newStudentAdult.adultStudentUUID {
                ActiveUserModelController.shared.activeUser.append(id)
            }
            
            newStudentAdult.isLoggedOn = true
        }
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
        
        beltCD = BeltCD(beltUUID: UUID(), active: true, dateCreated: Date(), dateEdited: Date(), beltLevel: beltLevel, beltPromotionAttendanceCriteria: nil, beltStripeAgeDetails: nil, classesToNextPromotion: nil, numberOfStripes: stripesInt16)
    }
}


// MARK: - function to create address data model in CoreData
extension CompletedProfileViewController {
    
    func createAddressCoreDataModel() {
        
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        
        let addressLine2CD = addressLine2 ?? ""
        
        guard let city = city else { print("fail city"); return }
        
        guard let state = state else { print("fail state"); return }
        
        guard let zipCode = zipCode else { print("fail zip"); return }
        
        addressCD = AddressCD(addressLine1: addressLine1, addressLine2: addressLine2CD, city: city, state: state, zipCode: zipCode)
        
    }
}


// MARK: - function to create emergency contact data model in CoreData
extension CompletedProfileViewController {
    
    func createEmergencyContactCoreDataModel() {
        
        guard let name = emergencyContactName else { print("fail emergencyContactName"); return }
        
        guard let phone = emergencyContactPhone else { print("fail emergencyContactPhone"); return }
        
        guard let relationship = emergencyContactRelationship else { print("fail emergencyContactRelationship"); return }
        
        emergencyContactCD = EmergencyContactCD(name: name, phone: phone, relationship: relationship)
    }
}
