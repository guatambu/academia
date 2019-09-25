//
//  LocationFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol LocationFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct LocationFirestore {
    
    var isActive: Bool
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var profilePicStorageURL: String
    var locationName: String
    var ownerName: String
    var phone: String?
    var website: String?
    var email: String
    var addressLine1: String
    var addressLine2: String?
    var city: String
    var state: String
    var zipCode: String
    var country: String?
    var facebookLink: String?
    var instagramLink: String?
    var twitterLink: String?
    var aulas: [String : Any]?  // aula names and/or uid's
    
    
    var dictionary: [String : Any] {
        return [
            "isActive" : isActive,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "profilePicStorageURL" : profilePicStorageURL,
            "locationName" : locationName,
            "ownerName" : ownerName,
            "phone" : phone ?? "",
            "website" : website ?? "",
            "email" : email,
            "addressLine1" : addressLine1,
            "addressLine2" : addressLine1,
            "city" : city,
            "state" : state,
            "zipCode" : zipCode,
            "country" : country ?? "",
            "facebookLink" : facebookLink ?? "",
            "instagramLink" : instagramLink ?? "",
            "twitterLink" : twitterLink ?? "",
            "aulas" : aulas ?? [ : ]
        ]
    }
    
    
    // initializer to allow creation of a LocationFirestore object
    init(isActive: Bool,
         dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         profilePicStorageURL: String,
         locationName: String,
         ownerName: String,
         phone: String?,
         website: String?,
         email: String,
         addressLine1: String,
         addressLine2: String,
         city: String,
         state: String,
         zipCode: String,
         country: String,
         facebookLink: String,
         twitterLink: String,
         instagramLink: String,
         aulas: [String : Any]? // aula names and/or uid's
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.profilePicStorageURL = profilePicStorageURL
        self.isActive = isActive
        self.locationName = locationName
        self.ownerName = ownerName
        self.phone = phone
        self.website = website
        self.email = email
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.country = country
        self.facebookLink = facebookLink
        self.instagramLink = instagramLink
        self.twitterLink = twitterLink
        self.aulas = aulas
    }
}


extension LocationFirestore: LocationFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 116.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 122.")
            return nil
        }
        
        guard let profilePicStorageURL = dictionary["profilePicStorageURL"] as? String else {
            
            print("ERROR: nil value found for profilePicStorageURL in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 128.")
            return nil
        }
        
        guard let isActive = dictionary["isActive"] as? Bool else {
            
            print("ERROR: nil value found for isActive in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 134.")
            return nil
        }

        guard let locationName = dictionary["locationName"] as? String else {

            print("ERROR: nil value found for locationName in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 140.")
            return nil
        }
        
        guard let ownerName = dictionary["ownerName"] as? String else {
            
            print("ERROR: nil value found for ownerName in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 146.")
            return nil
        }
        
        guard let addressLine1 = dictionary["addressLine1"] as? String else {
            
            print("ERROR: nil value found for addressLine1 in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 152.")
            return nil
        }
        
        guard let addressLine2 = dictionary["addressLine2"] as? String else {
            
            print("ERROR: nil value found for addressLine2 in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 158.")
            return nil
        }
        
        guard let city = dictionary["city"] as? String else {
            
            print("ERROR: nil value found for city in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 164.")
            return nil
        }
        
        guard let state = dictionary["state"] as? String else {
            
            print("ERROR: nil value found for state in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 170.")
            return nil
        }
        
        guard let zipCode = dictionary["zipCode"] as? String else {
            
            print("ERROR: nil value found for zipCode in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 176.")
            return nil
        }
        
        guard let country = dictionary["country"] as? String else {
            
            print("ERROR: nil value found for country in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 182.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 188.")
            return nil
        }
        
        guard let website = dictionary["website"] as? String else {
            
            print("ERROR: nil value found for website in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 194.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 200.")
            return nil
        }
        
        guard let facebookLink = dictionary["facebookLink"] as? String else {
            
            print("ERROR: nil value found for facebookLink in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 206.")
            return nil
        }
    
        guard let instagramLink = dictionary["instagramLink"] as? String else {
            
            print("ERROR: nil value found for instagramLink in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 212.")
            return nil
        }
        
        guard let twitterLink = dictionary["twitterLink"] as? String else {
            
            print("ERROR: nil value found for twitterLink in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 218.")
            return nil
        }
        
        guard let aulas = dictionary["aulas"] as? [String : Any] else {
            
            print("ERROR: nil value found for aulas in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 224.")
            return nil
        }
        
        self.init(isActive: isActive, dateCreated: dateCreated, dateEdited: dateEdited, profilePicStorageURL: profilePicStorageURL, locationName: locationName, ownerName: ownerName, phone: phone, website: website, email: email,  addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, country: country, facebookLink: facebookLink, twitterLink: twitterLink, instagramLink: instagramLink, aulas: aulas)
    }
}
