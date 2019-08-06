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
    var profilePic: String?
    var username: String
    var password: String
    var firstName: String
    var lastName: String
    var phone: String?
    var mobile: String?
    var email: String
    
    
    var dictionary: [String : Any] {
        return [
            "isOwner" : isOwner,
            "isInstructor" : isInstructor,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "birthdate" : birthdate,
            "mostRecentPromotion" : mostRecentPromotion ?? Timestamp(),
            // "studentStatus" : studentStatus,
            "profilePic" : profilePic ?? "",
            "username" : username,
            "firstName" : firstName,
            "lastName" : lastName,
            "phone" : phone ?? "",
            "mobile" : mobile ?? "",
            "email" : email,
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
         profilePic: String?,
         username: String,
         password: String,
         firstName: String,
         lastName: String,
         phone: String?,
         mobile: String?,
         email: String
        ) {
        
        self.isOwner = isOwner
        self.isInstructor = isInstructor
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.mostRecentPromotion = mostRecentPromotion
        //self.studentStatus = studentStatus
        self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.mobile = mobile
        self.email = email
    }
}


extension OwnerFirestore: OwnerFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let isOwner = dictionary["isOwner"] as? Bool else {
            
            print("ERROR: nil value found for isOwner in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 100.")
            return nil
        }
        
        guard let isInstructor = dictionary["isInstructor"] as? Bool else {
            
            print("ERROR: nil value found for isInstructor in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 106.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Timestamp else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 112.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Timestamp else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let birthdate = dictionary["birthdate"] as? Timestamp else {

            print("ERROR: nil value found for birthdate in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 124.")
            return nil
        }
        
        guard let mostRecentPromotion = dictionary["mostRecentPromotion"] as? Timestamp else {
            
            print("ERROR: nil value found for mostRecentPromotion in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
//        guard let studentStatus = dictionary["studentStatus"] as? StudentStatus else {
//
//            print("ERROR: nil value found for studentStatus in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 147.")
//            return nil
//        }
        
        guard let profilePic = dictionary["profilePic"] as? String else {
            
            print("ERROR: nil value found forprofilePic in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        guard let username = dictionary["username"] as? String else {
            
            print("ERROR: nil value found for username in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 148.")
            return nil
        }
        
        guard let password = dictionary["password"] as? String else {
            
            print("ERROR: nil value found for password in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 154.")
            return nil
        }
        
        guard let firstName = dictionary["firstName"] as? String else {
            
            print("ERROR: nil value found for firstName in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 160.")
            return nil
        }
        
        guard let lastName = dictionary["lastName"] as? String else {
            
            print("ERROR: nil value found for lastName in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 166.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 172.")
            return nil
        }
        
        guard let mobile = dictionary["mobile"] as? String else {
            
            print("ERROR: nil value found for mobile in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 178.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 184.")
            return nil
        }
        
        self.init(isOwner: isOwner, isInstructor: isInstructor, dateCreated: dateCreated, dateEdited: dateEdited, birthdate: birthdate, mostRecentPromotion: mostRecentPromotion, profilePic: profilePic, username: username, password: password, firstName: firstName, lastName: lastName, phone: phone, mobile: mobile, email: email)
    }
}



