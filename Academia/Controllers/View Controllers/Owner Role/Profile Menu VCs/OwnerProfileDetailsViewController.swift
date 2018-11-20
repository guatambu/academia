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
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var profilePic: UIImage?
    var beltLevel: InternationalStandardBJJBelts?
    var numberOfStripes: Int?
    var parentGuardian: String?
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
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


extension OwnerProfileDetailsViewController {
    
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
        print("isOwner: \(isOwner) \nisKid: \(isKid) \nusername: \(username) \npassword: \(password) \nfirstName: \(firstName) \nlastName: \(lastName) \nbeltLevel: \(beltLevel.rawValue) \nnumberOfStripes: \(numberOfStripes) \naddressLine1: \(addressLine1) \naddressLine2: \(String(describing: addressLine2)) \ncity: \(city) \nstate: \(state) \nzipCode: \(zipCode) \nphone: \(phone) \nmobile: \(String(describing: mobile)) \nemail: \(email) \nemergencyContactName: \(emergencyContactName) \nemergencyContactRelationship: \(emergencyContactRelationship) \nemergencyContactPhone: \(emergencyContactPhone)")
        
        // populate UI elements in VC
        self.title = "\(firstName) \(lastName)"
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

