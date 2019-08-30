//
//  OwnerFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

protocol OwnerFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct OwnerFirestore {
    
    var isOwner: Bool
    var isInstructor: Bool
    var dateCreated: Timestamp
    var dateEdited: Timestamp
    var birthdate: Timestamp
    var mostRecentPromotion: Timestamp?
    //var studentStatus: StudentStatusCD?
    var firstName: String
    var lastName: String
    var addressLine1: String
    var addressLine2: String?
    var city: String
    var state: String
    var zipCode: String
    var phone: String?
    var mobile: String?
    var email: String
    var emergencyContactName: String?
    var emergencyContactPhone: String?
    var emergencyContactRelationship: String?
    // Belt
    var beltLevel: String
    var numberOfStripes: Int
    var numberOfClassesAttendedSinceLastPromotion: Int
    var elligibleForPromotion: Bool
    var elligibleForNextBelt: Bool
    
    
    var dictionary: [String : Any] {
        return [
            "isOwner" : isOwner,
            "isInstructor" : isInstructor,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "birthdate" : birthdate,
            "mostRecentPromotion" : mostRecentPromotion ?? Timestamp(),
            // "studentStatus" : studentStatus,
//            "profilePic" : profilePic ?? "",
//            "username" : username,
            "firstName" : firstName,
            "lastName" : lastName,
            "addressLine1" : addressLine1,
            "addressLine2" : addressLine2 ?? "",
            "city" : city,
            "state" : state,
            "zipCode" : zipCode,
            "phone" : phone ?? "",
            "mobile" : mobile ?? "",
            "email" : email,
            "emergencyContactName" : emergencyContactName ?? "",
            "emergencyContactPhone" : emergencyContactPhone ?? "",
            "emergencyContactRelationship" : emergencyContactRelationship ?? "",
            "beltLevel" : beltLevel,
            "numberOfStripes" : numberOfStripes,
            "numberOfClassesAttendedSinceLastPromotion" : numberOfClassesAttendedSinceLastPromotion,
            "elligibleForPromotion" : elligibleForPromotion,
            "elligibleForNextBelt" : elligibleForNextBelt
        ]
    }
    
    
    // initializer to allow creation of an OwnerFirestore object 
    init(
         isOwner: Bool = true,
         isInstructor: Bool = true,
         dateCreated: Timestamp = Timestamp(),
         dateEdited: Timestamp = Timestamp(),
         birthdate: Timestamp,
         mostRecentPromotion: Timestamp?,
         //studentStatus: StudentStatusCD?,
         firstName: String,
         lastName: String,
         addressLine1: String,
         addressLine2: String?,
         city: String,
         state: String,
         zipCode: String,
         phone: String?,
         mobile: String?,
         email: String,
         emergencyContactName: String?,
         emergencyContactPhone: String?,
         emergencyContactRelationship: String?,
         beltLevel: String,
         numberOfStripes: Int,
         numberOfClassesAttendedSinceLastPromotion: Int,
         elligibleForPromotion: Bool = false,
         elligibleForNextBelt: Bool = false
        ) {
        
        self.isOwner = isOwner
        self.isInstructor = isInstructor
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.mostRecentPromotion = mostRecentPromotion
        //self.studentStatus = studentStatus
        self.firstName = firstName
        self.lastName = lastName
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContactName = emergencyContactName
        self.emergencyContactPhone = emergencyContactPhone
        self.emergencyContactRelationship = emergencyContactRelationship
        self.beltLevel = beltLevel
        self.numberOfStripes = numberOfStripes
        self.numberOfClassesAttendedSinceLastPromotion = numberOfClassesAttendedSinceLastPromotion
        self.elligibleForPromotion = elligibleForPromotion
        self.elligibleForNextBelt = elligibleForNextBelt
    }
}


extension OwnerFirestore: OwnerFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let isOwner = dictionary["isOwner"] as? Bool else {
            
            print("ERROR: nil value found for isOwner in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 144.")
            return nil
        }
        
        guard let isInstructor = dictionary["isInstructor"] as? Bool else {
            
            print("ERROR: nil value found for isInstructor in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 150.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 156.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 162.")
            return nil
        }
        
        guard let birthdate = dictionary["birthdate"] as? Timestamp else {

            print("ERROR: nil value found for birthdate in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 168.")
            return nil
        }
        
        guard let mostRecentPromotion = dictionary["mostRecentPromotion"] as? Timestamp else {
            
            print("ERROR: nil value found for mostRecentPromotion in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 174.")
            return nil
        }
        
//        guard let studentStatus = dictionary["studentStatus"] as? StudentStatus else {
//
//            print("ERROR: nil value found for studentStatus in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 180.")
//            return nil
//        }
        
        guard let firstName = dictionary["firstName"] as? String else {
            
            print("ERROR: nil value found for firstName in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 186.")
            return nil
        }
        
        guard let lastName = dictionary["lastName"] as? String else {
            
            print("ERROR: nil value found for lastName in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 192.")
            return nil
        }
        
        guard let addressLine1 = dictionary["addressLine1"] as? String else {
            
            print("ERROR: nil value found for addressLine1 in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 198.")
            return nil
        }
        
        guard let addressLine2 = dictionary["addressLine2"] as? String else {
            
            print("ERROR: nil value found addressLine2 in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 204.")
            return nil
        }
        
        guard let city = dictionary["city"] as? String else {
            
            print("ERROR: nil value found for city in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 210.")
            return nil
        }
        
        guard let state = dictionary["state"] as? String else {
            
            print("ERROR: nil value found for state in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 216.")
            return nil
        }
        
        guard let zipCode = dictionary["zipCode"] as? String else {
            
            print("ERROR: nil value found for zipCode in firestore dictionary in AddressFirestore.swift -> init(dictionary:) - line 222.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 228.")
            return nil
        }
        
        guard let mobile = dictionary["mobile"] as? String else {
            
            print("ERROR: nil value found for mobile in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 234.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 240.")
            return nil
        }
        
        guard let emergencyContactName = dictionary["emergencyContactName"] as? String else {
            
            print("ERROR: nil value found for emergencyContactName in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 246.")
            return nil
        }
        
        guard let emergencyContactPhone = dictionary["emergencyContactPhone"] as? String else {
            
            print("ERROR: nil value found emergencyContactPhone in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 252.")
            return nil
        }
        
        guard let emergencyContactRelationship = dictionary["emergencyContactRelationship"] as? String else {
            
            print("ERROR: nil value found for emergencyContactRelationship in firestore dictionary in EmergencyContactFirestore.swift -> init(dictionary:) - line 258.")
            return nil
        }
        
        guard let beltLevel = dictionary["beltLevel"] as? String else {
            
            print("ERROR: nil value found for beltLevel in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 264.")
            return nil
        }
        
        guard let numberOfStripes = dictionary["numberOfStripes"] as? Int else {
            
            print("ERROR: nil value found for numberOfStripes in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 270.")
            return nil
        }
        
        guard let numberOfClassesAttendedSinceLastPromotion = dictionary["numberOfClassesAttendedSinceLastPromotion"] as? Int else {
            
            print("ERROR: nil value found for numberOfClassesAttendedSinceLastPromotion in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 276.")
            return nil
        }
        
        guard let elligibleForPromotion = dictionary["elligibleForPromotion"] as? Bool else {
            
            print("ERROR: nil value found elligibleForPromotion in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 282.")
            return nil
        }
        
        guard let elligibleForNextBelt = dictionary["elligibleForNextBelt"] as? Bool else {
            
            print("ERROR: nil value found elligibleForNextBelt in firestore dictionary in BeltFirestore.swift -> init(dictionary:) - line 288.")
            return nil
        }
        
        
        self.init(isOwner: isOwner, isInstructor: isInstructor, dateCreated: dateCreated, dateEdited: dateEdited, birthdate: birthdate, mostRecentPromotion: mostRecentPromotion, firstName: firstName, lastName: lastName, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, mobile: mobile, email: email, emergencyContactName: emergencyContactName, emergencyContactPhone: emergencyContactPhone, emergencyContactRelationship: emergencyContactRelationship, beltLevel: beltLevel, numberOfStripes: numberOfStripes, numberOfClassesAttendedSinceLastPromotion: numberOfClassesAttendedSinceLastPromotion, elligibleForPromotion: elligibleForPromotion, elligibleForNextBelt: elligibleForNextBelt)
    }
}



