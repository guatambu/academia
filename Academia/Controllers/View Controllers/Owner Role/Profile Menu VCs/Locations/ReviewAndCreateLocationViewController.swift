//
//  ReviewAndCreateLocationViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/3/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

class ReviewAndCreateLocationViewController: UIViewController {

    // MARK: - Properties
    
    var locationName: String?
    var ownerName: String? // TODO: create Firestore model
    var locationPic: UIImage?
    var active: Bool?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var country: String?
    var phone: String?
    var website: String?
    var email: String?
    var social1: String?
    var social2: String?
    var social3: String?
    
    let beltBuilder = BeltBuilder()
    
    var addressCD: AddressCD?
    var socialLinksCD: LocationSocialLinksCD?
    
    // profile pic imageView
    @IBOutlet weak var locationNameLabelOutlet: UILabel!
    @IBOutlet weak var locationPicImageView: UIImageView!
    // contact info outlets
    @IBOutlet weak var ownerNameLabelOutlet: UILabel!
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var websiteLabelOutlet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    // address outlets
    @IBOutlet weak var addressLine1LabelOutlet: UILabel!
    @IBOutlet weak var addressLine2LabelOutlet: UILabel!
    @IBOutlet weak var cityLabelOutlet: UILabel!
    @IBOutlet weak var stateLabelOutlet: UILabel!
    @IBOutlet weak var zipCodeLabelOutlet: UILabel!
    // social link outlets
    @IBOutlet weak var socialLink1LabelOutlet: UILabel!
    @IBOutlet weak var socialLink2LabelOutlet: UILabel!
    @IBOutlet weak var socialLink3LabelOutlet: UILabel!
    
    @IBOutlet weak var createAccountButtonOutlet: DesignableButton!
    
    // Firebase Firestore properties
    var locationsCollectionRef: CollectionReference!
    var activeLocationFirestore: LocationFirestore?
    var activeOwnerStorageRef: StorageReference?
    
    var db: Firestore!
    // The handler for the FIREBASE Auth state listener, to allow cancelling later.
    var handle: AuthStateDidChangeListenerHandle?
    // Firebase Storage Reference
    let firebaseStorageRef = Storage.storage().reference()
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedProfileInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLine2LabelOutlet.isHidden = false
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        // Firestore Test properties setup
        db = Firestore.firestore()
    }
    
    // MARK: - Actions
    
    @IBAction func createAccountButtonTapped(_ sender: DesignableButton) {
        
        // create the AddressCD data model object
        createAddressCoreDataModel()
        
        // create SocialLinksCD data model object
        createSocialLinksCoreDataModel()
        
        // create and save LocationCD data model object
        createLocationCoreDataModel()
        
        // create the new location in the LocationModelController source of truth
        createLocation()
        
        // programmatic segue back to the MyLocations TVC to view the current locations
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is MyLocationsTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}


extension ReviewAndCreateLocationViewController {
    
    func populateCompletedProfileInfo() {
        
        // populate UI elements in VC
        guard let locationName = locationName else {
            print("in ReviewAndCreateLocationVC -> populateCompletedProfile() there is no locationName!!! - line 112")
            return
        }
        locationNameLabelOutlet.text = locationName
        ownerNameLabelOutlet.text = ownerName
        // phone outlet
        phoneLabelOutlet.text = phone
        // mobile is not a required field
        websiteLabelOutlet.text = website
        emailLabelOutlet.text = email
        // address outlets
        addressLine1LabelOutlet.text = addressLine1
        // addressLine2 is not a required field
        if addressLine2 != "" {
            addressLine2LabelOutlet.text = addressLine2
        } else {
            addressLine2LabelOutlet.isHidden = true
        }
        cityLabelOutlet.text = city
        stateLabelOutlet.text = state
        zipCodeLabelOutlet.text = zipCode
        // social media links outlets
        socialLink1LabelOutlet.text = "Instagram: \(social1 ?? "")"
        socialLink2LabelOutlet.text = "facebook: \(social2 ?? "")"
        socialLink3LabelOutlet.text = "Twitter: \(social3 ?? "")"
        // profile pic imageView
        locationPicImageView.image = locationPic
    }
}


extension ReviewAndCreateLocationViewController {
    
    func createLocation() {
        
        guard let locationPic = locationPic else { print("fail locationPic"); return }
        guard let locationName = locationName else { print("fail locationName"); return }
        guard let ownerName = ownerName else { print("fail ownernName"); return }
        guard let active = active else { print("fail active"); return }
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        guard let city = city else { print("fail city"); return }
        guard let state = state else { print("fail state"); return }
        guard let zipCode = zipCode else { print("fail zip"); return }
        guard let country = country else { print("fail country"); return }
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        let website = self.website ?? ""
        let addressLine2 = self.addressLine2 ?? ""
        let facebookLink = self.social1 ?? ""
        let twitterLink = self.social2 ?? ""
        let instagramLink = self.social3 ?? ""
        
//        LocationModelController.shared.addNew(locationPic: locationPic, active: active, locationName: locationName, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, website: website, email: email, social1: social1, social2: social2, social3: social3)
        
        // convert profilePic to Data
        guard let locationPicData = locationPic.jpegData(compressionQuality: 1) else { print("fail profilePicData"); return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // FIREBASE STORAGE REFERENCE
        let profilePicsRef = self.firebaseStorageRef.child("profilePics")
        
        // create FIREBASE FIRESTORE location data object and save to cloud Firestore
        if Auth.auth().currentUser != nil {
            
            let user = Auth.auth().currentUser
            
            if let user = user {
                
                let userUID = user.uid
                
                // FIREBASE STORAGE LOCATION PROFILE PICS REFERENCE
                let locationsProfilePicsRef = profilePicsRef.child("locations").child(userUID)
                
                _ = locationsProfilePicsRef.putData(locationPicData, metadata: metadata) { (metadata, error) in
                    
                    guard let metadata = metadata else {
                        
                        if let error = error {
                            print("ERROR: \(error.localizedDescription) - error while uploading location profile pic and its metadata in ReviewAndCreateLocationVC -> createLocation() - line 203.")
                        }
                        return
                    }
                    
                    locationsProfilePicsRef.downloadURL{ (url, error) in
                        
                        print(metadata.size)
                        
                        locationsProfilePicsRef.downloadURL { (url, error) in
                            
                            guard let downloadURL = url  else {
                                
                                print("ERROR: error after uploading location profile pic and its metadata and then getting the URL in ReviewAndCreateLocationVC -> createLocation() - line 216.")
                                return
                            }
                            
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.photoURL = downloadURL
                            changeRequest?.commitChanges { (error) in
                                
                                if let error = error {
                                    
                                    print("ERROR: \(error.localizedDescription) failure to execute change request with location photoURL in new/current loation a in ReviewAndCreateLocationVC -> createLocation() - line 226.")
                                }
                            }
                        }
                    }
                }
                
                // FIREBASE FIRESTORE CREATE AND SAVE NEW OWNER MODEL
                let location = LocationFirestore(isActive: active, locationName: locationName, ownerName: ownerName, phone: phone, website: website, email: email, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, country: country, facebookLink: facebookLink, twitterLink: twitterLink, instagramLink: instagramLink, aulas: nil)
                
                // set the Firebase Firestore Location collection reference
                locationsCollectionRef = Firestore.firestore().collection("owners").document(userUID).collection("locations")
                
                locationsCollectionRef.document(userUID).setData(location.dictionary) { (error) in
                    if let error = error {
                        print("ERROR: \(error.localizedDescription) error occurred while trying to save location to Firebase Firestore in ReviewAndCreateLocationVC -> createLocation() - line 237.")
                    } else {
                        print("new location data successfully saved to Firebase Firestore in owner's location collection")
                    }
                }
            }
        } else {
            print("ERROR: no currentUser found in Firebase Auth object in ReviewAndCreateLocationVC -> createLocation() - line 237.")
        }
    }
}


// MARK: - create location model in CoreData
extension ReviewAndCreateLocationViewController {
    
    func createLocationCoreDataModel() {
        
        guard let locationPic = locationPic else { print("fail locationPic"); return }
        guard let locationPicData = locationPic.jpegData(compressionQuality: 1) else { print("fail locationPicData"); return }
        
        guard let locationName = locationName else { print("fail locationName"); return }
        guard let active = active else { print("fail active");  return }
        
        guard let addressCD = addressCD else { print("fail address");  return }
        
        guard let phone = phone else { print("fail phone"); return }
        guard let email = email else { print("fail email"); return }
        
        guard let socialLinksCD = socialLinksCD else { print("fail socialLinksCD"); return }
        
        let website = self.website ?? ""
        
        
        
        let newLocation = LocationCD(active: active, locationPic: locationPicData, locationName: locationName, phone: phone, website: website, email: email, address: addressCD, socialLinks: socialLinksCD, aula: nil)
        
        LocationCDModelController.shared.add(location: newLocation)
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}


// MARK: - create address model in CoreData
extension ReviewAndCreateLocationViewController {
    
    func createAddressCoreDataModel() {
        
        guard let addressLine1 = addressLine1 else { print("fail addressLine1"); return }
        guard let city = city else { print("fail city"); return }
        guard let state = state else { print("fail state"); return }
        guard let zipCode = zipCode else { print("fail zip"); return }
        
        let addressLine2 = self.addressLine2 ?? ""
        
        addressCD = AddressCD(addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode)
    }
    
}


// MARK: - create social links model in CoreData
extension ReviewAndCreateLocationViewController {
    
    func createSocialLinksCoreDataModel() {
        
        let social1 = self.social1 ?? ""
        let social2 = self.social2 ?? ""
        let social3 = self.social3 ?? ""
        
        socialLinksCD = LocationSocialLinksCD(socialLink1: social1, socialLink2: social2, socialLink3: social3)
    }
}






    



































