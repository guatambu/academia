//
//  OwnersStudentDetailViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 12/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class OwnersStudentDetailViewController: UIViewController {

    // MARK: - Properties
    
    var isKid: Bool?
    var isInstructor = false
    
    var kid: KidStudent?
    var adult: AdultStudent?
    
    let beltBuilder = BeltBuilder()
    
    // name / username outlets
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    // isInstructor outlets
    @IBOutlet weak var isInstructorStackView: UIStackView!
    @IBOutlet weak var instructorLabelOutlet: UILabel!
    @IBOutlet weak var isInstructorSwitch: UISwitch!
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
    
    // CoreData properties
    var studentKidCD: StudentKidCD?
    var studentAdultCD: StudentAdultCD?
    var ownerCD: OwnerCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        // Do any additional setup after loading the view.
        
        // check to see if user isKid or not.  only StudentAdultCD may be instructors. only owner may toggle the switch
        if let isKid = isKid {
            
            if isKid {
                isInstructorStackView.isHidden = true
                instructorLabelOutlet.isHidden = true
                isInstructorSwitch.isHidden = true
                isInstructorSwitch.isEnabled = false
            } else {
                isInstructorStackView.isHidden = false
                instructorLabelOutlet.isHidden = false
                isInstructorSwitch.isHidden = false
                isInstructorSwitch.isEnabled = true
            }
        }
        
        populateCompletedProfileInfo(adult: adult, kid: kid, adultCD: studentAdultCD, kidCD: studentKidCD, ownerCD: ownerCD)
    }
    
    
    // MARK: - Actions
    @IBAction func toggleIsInstructorSwitch(_ sender: UISwitch) {
        
        isInstructor = !isInstructor
        print("isInstructorSwitch toggled, currently isInstructor = \(isInstructor)")
        
        guard let StudentAdultCD = studentAdultCD else {
            print("ERROR: nil value found for activeOwner property of type OwnerCD in OwnerInfoDetailsViewController.swift -> toggleIsInstructorSwitch(sender:) - line 87.")
            return
        }
        
        // update the activeOwner's isInstructor value
        StudentAdultCDModelController.shared.update(studentAdult: StudentAdultCD, isInstructor: isInstructor, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: nil, password: nil, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    
}

// MARK: - date formatter setup for birthdate display
extension OwnersStudentDetailViewController {
    
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
extension OwnersStudentDetailViewController {
    
    func populateCompletedProfileInfo(adult: AdultStudent?,
                                      kid: KidStudent?, adultCD: StudentAdultCD?, kidCD: StudentKidCD?, ownerCD: OwnerCD?) {
        
        if /** let kid = kid, **/ let kidCD = kidCD, let address = kidCD.address, let emergencyContact = kidCD.emergencyContact, let birthdate = kidCD.birthdate, let belt = kidCD.belt {
            
            // populate UI elements in VC
            nameLabelOutlet.text = "\(kidCD.firstName ?? "ERROR: no firstName property for kidCD, so likely everything broken in kidCD object in OwnersStudentDetailViewController -> populateCompletedProfileInfo(adult:kid:adultCD:kidCD:) - line 104.") \(kidCD.lastName ?? "")"
            usernameLabelOutlet.text = "user: \(kidCD.username ?? "")"
            // contact info outlets
            phoneLabelOutlet.text = "p: \(kidCD.phone ?? "")"
            // mobile is not a required field
            mobileLabelOutlet.text = "m: \(kidCD.mobile ?? "")"
            emailLabelOutlet.text = kidCD.email
            // address outlets
            parentGuardianLabelOutlet.text = "guardian: \(kidCD.parentGuardian ?? "")"
            addressLine1LabelOutlet.text = address.addressLine1 ?? ""
            // addressLine2 is not a required field
            addressLine2LabelOutlet.text = address.addressLine2 ?? ""
            cityLabelOutlet.text = address.city ?? ""
            stateLabelOutlet.text = address.state ?? ""
            zipCodeLabelOutlet.text = address.zipCode ?? ""
            // emergency contact info outlets
            emergencyContactNameLabelOutlet.text = emergencyContact.name ?? ""
            emergencyContactRelationshipLabelOutlet.text = emergencyContact.relationship ?? ""
            emergencyContactPhoneLabelOutlet.text = emergencyContact.phone ?? ""
            
            // profile pic imageView
            if let profilePicData = kidCD.profilePic {
                
                profilePicImageView.image = UIImage(data: profilePicData)
            }
            
            // display birthdate
            formatBirthdate(birthdate: birthdate)
            
            // belt holder UIView
            
            if let beltContstructor = InternationalStandardBJJBelts(rawValue: belt.beltLevel!), let numberOfStripes = Int(exactly: belt.numberOfStripes) {
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltContstructor, numberOfStripes: numberOfStripes)
            }
            
            
        } else if /** let adult = adult, **/ let adultCD = adultCD, let address = adultCD.address, let emergencyContact = adultCD.emergencyContact, let birthdate = adultCD.birthdate, let belt = adultCD.belt {
            
            // populate UI elements in VC
            nameLabelOutlet.text = "\(adultCD.firstName ?? "ERROR: no firstName property for adultCD, so likely everything broken in kidCD object in OwnersStudentDetailViewController -> populateCompletedProfileInfo(adult:kid:adultCD:kidCD:) - line 144.") \(adultCD.lastName ?? "")"
            usernameLabelOutlet.text = "user: \(adultCD.username ?? "")"
            // contact info outlets
            phoneLabelOutlet.text = "p: \(adultCD.phone ?? "")"
            // mobile is not a required field
            mobileLabelOutlet.text = "m: \(adultCD.mobile ?? "")"
            emailLabelOutlet.text = adultCD.email
            // address outlets
            addressLine1LabelOutlet.text = address.addressLine1 ?? ""
            // addressLine2 is not a required field
            addressLine2LabelOutlet.text = address.addressLine2 ?? ""
            cityLabelOutlet.text = address.city ?? ""
            stateLabelOutlet.text = address.state ?? ""
            zipCodeLabelOutlet.text = address.zipCode ?? ""
            // emergency contact info outlets
            emergencyContactNameLabelOutlet.text = emergencyContact.name ?? ""
            emergencyContactRelationshipLabelOutlet.text = emergencyContact.relationship ?? ""
            emergencyContactPhoneLabelOutlet.text = emergencyContact.phone ?? ""
            
            // profile pic imageView
            if let profilePicData = adultCD.profilePic {
                
                profilePicImageView.image = UIImage(data: profilePicData)
            }
            
            // display birthdate
            formatBirthdate(birthdate: birthdate)
            
            // belt holder UIView
            
            if let beltContstructor = InternationalStandardBJJBelts(rawValue: belt.beltLevel!), let numberOfStripes = Int(exactly: belt.numberOfStripes) {
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltContstructor, numberOfStripes: numberOfStripes)
            }
        } else if let ownerCD = ownerCD, let address = ownerCD.address, let emergencyContact = ownerCD.emergencyContact, let birthdate = ownerCD.birthdate, let belt = ownerCD.belt {
            
            // populate UI elements in VC
            nameLabelOutlet.text = "\(ownerCD.firstName ?? "ERROR: no firstName property for adultCD, so likely everything broken in kidCD object in OwnersStudentDetailViewController -> populateCompletedProfileInfo(adult:kid:adultCD:kidCD:) - line 144.") \(ownerCD.lastName ?? "")"
            usernameLabelOutlet.text = "user: \(ownerCD.username ?? "")"
            // contact info outlets
            phoneLabelOutlet.text = "p: \(ownerCD.phone ?? "")"
            // mobile is not a required field
            mobileLabelOutlet.text = "m: \(ownerCD.mobile ?? "")"
            emailLabelOutlet.text = ownerCD.email
            // address outlets
            addressLine1LabelOutlet.text = address.addressLine1 ?? ""
            // addressLine2 is not a required field
            addressLine2LabelOutlet.text = address.addressLine2 ?? ""
            cityLabelOutlet.text = address.city ?? ""
            stateLabelOutlet.text = address.state ?? ""
            zipCodeLabelOutlet.text = address.zipCode ?? ""
            // emergency contact info outlets
            emergencyContactNameLabelOutlet.text = emergencyContact.name ?? ""
            emergencyContactRelationshipLabelOutlet.text = emergencyContact.relationship ?? ""
            emergencyContactPhoneLabelOutlet.text = emergencyContact.phone ?? ""
            
            // profile pic imageView
            if let profilePicData = ownerCD.profilePic {
                
                profilePicImageView.image = UIImage(data: profilePicData)
            }
            
            // display birthdate
            formatBirthdate(birthdate: birthdate)
            
            // belt holder UIView
            
            if let beltContstructor = InternationalStandardBJJBelts(rawValue: belt.beltLevel!), let numberOfStripes = Int(exactly: belt.numberOfStripes) {
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltContstructor, numberOfStripes: numberOfStripes)
            }
        }
    }
}

// MARK: - Create Data Models Functions
extension OwnersStudentDetailViewController {}
    


