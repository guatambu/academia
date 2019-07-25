//
//  OwnerFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol OwnerFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct OwnerFirestore {
    
    var ownerUUID: String
    var isOwner: Bool
    var isInstructor: Bool
    var dateCreated: Date
    var dateEdited: Date
    var birthdate: Date
    var mostRecentPromotion: Date?
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
            "ownerUUID" : ownerUUID,
            "isOwner" : isOwner,
            "isInstructor" : isInstructor,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "birthdate" : birthdate,
            "mostRecentPromotion" : mostRecentPromotion ?? Date(),
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
    init(ownerUUID: String = "\(UUID())",
                     isOwner: Bool = true,
                     isInstructor: Bool = true,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     birthdate: Date,
                     mostRecentPromotion: Date?,
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
        
        self.ownerUUID = ownerUUID
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
        
        
        guard let ownerUUID = dictionary["ownerUUID"] as? String else {
            
            print("ERROR: nil value found for ownerUUID in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 103.")
            return nil
        }
        
        guard let isOwner = dictionary["isOwner"] as? Bool else {
            
            print("ERROR: nil value found for isOwner in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 109.")
            return nil
        }
        
        guard let isInstructor = dictionary["isInstructor"] as? Bool else {
            
            print("ERROR: nil value found for isInstructor in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 115.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 121.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 127.")
            return nil
        }
        
        guard let birthdate = dictionary["birthdate"] as? Date else {

            print("ERROR: nil value found for birthdate in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 133.")
            return nil
        }
        
        guard let mostRecentPromotion = dictionary["mostRecentPromotion"] as? Date else {
            
            print("ERROR: nil value found for mostRecentPromotion in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 139.")
            return nil
        }
        
//        guard let studentStatus = dictionary["studentStatus"] as? StudentStatus else {
//
//            print("ERROR: nil value found for studentStatus in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 147.")
//            return nil
//        }
        
        guard let profilePic = dictionary["profilePic"] as? String else {
            
            print("ERROR: nil value found forprofilePic in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 151.")
            return nil
        }
        
        guard let username = dictionary["username"] as? String else {
            
            print("ERROR: nil value found for username in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 157.")
            return nil
        }
        
        guard let password = dictionary["password"] as? String else {
            
            print("ERROR: nil value found for password in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 163.")
            return nil
        }
        
        guard let firstName = dictionary["firstName"] as? String else {
            
            print("ERROR: nil value found for firstName in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 169.")
            return nil
        }
        
        guard let lastName = dictionary["lastName"] as? String else {
            
            print("ERROR: nil value found for lastName in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 175.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 181.")
            return nil
        }
        
        guard let mobile = dictionary["mobile"] as? String else {
            
            print("ERROR: nil value found for mobile in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 187.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in OwnerFirestore.swift -> init(dictionary:) - line 193.")
            return nil
        }
        
        self.init(ownerUUID: ownerUUID, isOwner: isOwner, isInstructor: isInstructor, dateCreated: dateCreated, dateEdited: dateEdited, birthdate: birthdate, mostRecentPromotion: mostRecentPromotion, profilePic: profilePic, username: username, password: password, firstName: firstName, lastName: lastName, phone: phone, mobile: mobile, email: email)
    }
}



