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
    var aula: AulaFirestore?
    
    
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
            "aula" : aula
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
         aula: AulaFirestore?
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
        self.aula = aula
    }
}


extension LocationFirestore: LocationFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let locationUUID = dictionary["locationUUID"] as? String else {
            
            print("ERROR: nil value found for locationUUID in firestore dictionary in TestModel.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in TestModel.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in TestModel.swift -> init(dictionary:) - line 136.")
            return nil
        }
        
        guard let active = dictionary["active"] as? Bool else {
            
            print("ERROR: nil value found for active in firestore dictionary in TestModel.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        guard let locationPic = dictionary["locationPic"] as? StudentStatus else {

            print("ERROR: nil value found for locationPic in firestore dictionary in TestModel.swift -> init(dictionary:) - line 148.")
            return nil
        }

        guard let locationName = dictionary["locationName"] as? Belt else {

            print("ERROR: nil value found for locationName in firestore dictionary in TestModel.swift -> init(dictionary:) - line 154.")
            return nil
        }
        
        guard let address = dictionary["address"] as? AddressFirestore else {

            print("ERROR: nil value found for address in firestore dictionary in TestModel.swift -> init(dictionary:) - line 178.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in TestModel.swift -> init(dictionary:) - line 184.")
            return nil
        }
        
        guard let website = dictionary["website"] as? String else {
            
            print("ERROR: nil value found for website in firestore dictionary in TestModel.swift -> init(dictionary:) - line 190.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in TestModel.swift -> init(dictionary:) - line 196.")
            return nil
        }
        
        guard let socialLinks = dictionary["socialLinks"] as? EmergencyContactFirestore else {

            print("ERROR: nil value found for socialLinks in firestore dictionary in TestModel.swift -> init(dictionary:) - line 202.")
            return nil
        }
        
        guard let aula = dictionary["saula"] as? EmergencyContactFirestore else {
            
            print("ERROR: nil value found for aula in firestore dictionary in TestModel.swift -> init(dictionary:) - line 202.")
            return nil
        }
        
        self.init(locationUUID: locationUUID, active: active, dateCreated: dateCreated, dateEdited: dateEdited, locationPic: locationPic, locationName: locationName, phone: phone, website: website, email: email, address: address, socialLinks: socialLinks, aula: aula)
    }
}
