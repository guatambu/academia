//
//  LocationFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol LocationFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct LocationFirestore {
    
    var locationUUID: String
    var active: Bool
    var dateCreated: Date
    var dateEdited: Date
    var locationPic: String?
    var locationName: String
    var phone: String?
    var website: String?
    var email: String
    var address: AddressFirestore
    var socialLinks: LocationSocialLinksFirestore
    var aulas: [AulaFirestore]?
    
    
    var dictionary: [String : Any] {
        return [
            "locationUUID" : locationUUID,
            "active" : active,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "locationPic" : locationPic ?? "",
            "locationName" : locationName,
            "phone" : phone ?? "",
            "website" : website ?? "",
            "email" : email,
            "address" : address,
            "socialLinks" : socialLinks,
            "aulas" : aulas as Any
        ]
    }
    
    
    // initializer to allow creation of a LocationFirestore object
    init(locationUUID: String = "\(UUID())",
         active: Bool,
         dateCreated: Date = Date(),
         dateEdited: Date = Date(),
         locationPic: String?,
         locationName: String,
         phone: String?,
         website: String?,
         email: String,
         address: AddressFirestore,
         socialLinks: LocationSocialLinksFirestore,
         aulas: [AulaFirestore]?
        ) {
        
        self.locationUUID = locationUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.active = active
        self.locationPic = locationPic
        self.locationName = locationName
        self.phone = phone
        self.website = website
        self.email = email
        self.address = address
        self.socialLinks = socialLinks
        self.aulas = aulas
    }
}


extension LocationFirestore: LocationFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let locationUUID = dictionary["locationUUID"] as? String else {
            
            print("ERROR: nil value found for locationUUID in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 88.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 94.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 100.")
            return nil
        }
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 106.")
            return nil
        }
        
        guard let locationPic = dictionary["locationPic"] as? String else {

            print("ERROR: nil value found for locationPic in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 112.")
            return nil
        }

        guard let locationName = dictionary["locationName"] as? String else {

            print("ERROR: nil value found for locationName in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let address = dictionary["address"] as? AddressFirestore else {

            print("ERROR: nil value found for address in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 124.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
        guard let website = dictionary["website"] as? String else {
            
            print("ERROR: nil value found for website in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 136.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        guard let socialLinks = dictionary["socialLinks"] as? LocationSocialLinksFirestore else {

            print("ERROR: nil value found for socialLinks in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 148.")
            return nil
        }
        
        guard let aulas = dictionary["aulas"] as? [AulaFirestore] else {
            
            print("ERROR: nil value found for aulas in firestore dictionary in LocationFirestore.swift -> init(dictionary:) - line 154.")
            return nil
        }
        
        self.init(locationUUID: locationUUID, active: active, dateCreated: dateCreated, dateEdited: dateEdited, locationPic: locationPic, locationName: locationName, phone: phone, website: website, email: email, address: address, socialLinks: socialLinks, aulas: aulas)
    }
}
