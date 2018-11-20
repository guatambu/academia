//
//  CompletedProfileViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class CompletedProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var profilePic: UIImage?
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
    var birthdate: Date?
    
    var belt: Belt?
    
    let beltBuilder = BeltBuilder()
    
    // name / username outlets
    @IBOutlet weak var nameLabelOutlet: UILabel!
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
    
    @IBOutlet weak var firstProgressDotOutlet: DesignableView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // hide first progress dot for owner users
        guard let isOwner = isOwner else { return }
        
        if isOwner {
            firstProgressDotOutlet.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        populateCompletedProfileInfo(isOwner: isOwner, isKid: isKid, username: username, password: password, firstName: firstName, lastName: lastName, profilePic: profilePic, beltLevel: beltLevel, numberOfStripes: numberOfStripes, parentGuardian: parentGuardian, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email, emergencyContactName: emergencyContactName, emergencyContactPhone: emergencyContactPhone, emergencyContactRelationship: emergencyContactRelationship)
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func createAccountButtonTapped(_ sender: DesignableButton) {
        
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
            }
        } else {
            
            // instantiate the relevant storyboard for the Student (Kid or Adult... both are directed to the same TabBarController)
            let mainView: UIStoryboard = UIStoryboard(name: "StudentBaseCampFlow", bundle: nil)
            // create the UITabBarController segue programmatically - MODAL
            if let tabBarDestViewController = (mainView.instantiateViewController(withIdentifier: "toStudentDashbooard") as? UITabBarController) {
                self.present(tabBarDestViewController, animated: true, completion: nil)
            }
        }
        // set the desired properties of the destinationVC's navigation Item
    }
    
    // MARK: - Helper Methods
    

}

//MARK: - populate CompletedProfileVC with user info for display at viewDidLoad()
extension CompletedProfileViewController {
    
    func populateCompletedProfileInfo(isOwner: Bool?,
                                      isKid: Bool?,
                                      username: String?,
                                      password: String?,
                                      firstName: String?,
                                      lastName: String?,
                                      profilePic: UIImage?,
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
        
        guard let isOwner = isOwner else { print("fail isOwner"); return }
        guard let isKid = isKid else { print("fail isKid"); return }
        guard let profilePic = profilePic else { print("fail profilePic"); return }
        guard let username = username else { print("fail username"); return }
        guard let password = password else { print("fail password"); return }
        guard let firstName = firstName else { print("fail firtsName"); return }
        guard let lastName = lastName else { print("fail lastName"); return }
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
        print("isOwner: \(isOwner) \nisKid: \(isKid) \nusername: \(username) \npassword: \(password) \nfirstName: \(firstName) \nlastName: \(lastName) \nbeltLevel: \(beltLevel.rawValue) \nnumberOfStripes: \(numberOfStripes) \naddressLine1: \(addressLine1) \naddressLine2: \(String(describing: addressLine2)) \ncity: \(city) \nstate: \(state) \nzipCode: \(zipCode) \nphone: \(phone) \nmobile: \(String(describing: mobile)) \nemail: \(email) \nemergencyContactName: \(emergencyContactName) \nemergencyContactRelationship: \(emergencyContactRelationship) \nemergencyContactPhone: \(emergencyContactPhone) \nparentGuardian: \(String(describing: parentGuardian))")
        
        // populate UI elements in VC
        nameLabelOutlet.text = "\(firstName) \(lastName)"
        usernameLabelOutlet.text = username
        // contact info outlets
        phoneLabelOutlet.text = phone
        // mobile is not a required field
        mobileLabelOutlet.text = mobile ?? ""
        emailLabelOutlet.text = email
        // address outlets
        parentGuardianLabelOutlet.text = parentGuardian ?? ""
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
        
        // belt holder UIView
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
    }
}

// MARK: - Create Data Models Functions
extension CompletedProfileViewController {
    
    // create a Belt model for a User
    func createBelt() {
        
        guard let beltLevel = beltLevel else { print("fail beltLevel"); return }
        guard let numberOfStripes = numberOfStripes else { print("fail stripes"); return }
        
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
            
            OwnerModelController.shared.addNew(birthdate: Date(),
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


