//
//  KidStudentFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/4/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol KidStudentFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct KidStudentFirestore {
    
    var kidStudentUUID: String
    var isKid: Bool
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
    var parentGuardian: String
    var phone: String?
    var mobile: String?
    var email: String
    
    
    var dictionary: [String : Any] {
        return [
            "kidStudentUUID" : kidStudentUUID,
            "isKid" : isKid,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "birthdate" : birthdate,
            "mostRecentPromotion" : mostRecentPromotion ?? Date(),
            // "studentStatus" : studentStatus,
            "profilePic" : profilePic ?? "",
            "username" : username,
            "firstName" : firstName,
            "lastName" : lastName,
            "parentGuardian" : parentGuardian,
            "phone" : phone ?? "",
            "mobile" : mobile ?? "",
            "email" : email,
        ]
    }
    
    
    // initializer to allow creation of an KidStudentFirestore object
    init(kidStudentUUID: String = "\(UUID())",
        isKid: Bool = true,
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
        parentGuardian: String,
        phone: String?,
        mobile: String?,
        email: String
        ) {
        
        self.kidStudentUUID = kidStudentUUID
        self.isKid = isKid
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
        self.parentGuardian = parentGuardian
        self.phone = phone
        self.mobile = mobile
        self.email = email
    }
}


extension KidStudentFirestore: KidStudentFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let kidStudentUUID = dictionary["kidStudentUUID"] as? String else {
            
            print("ERROR: nil value found for kidStudentUUID in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 111.")
            return nil
        }
        
        guard let isKid = dictionary["isKid"] as? Bool else {
            
            print("ERROR: nil value found for isKid in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 109.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 115.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 121.")
            return nil
        }
        
        guard let birthdate = dictionary["birthdate"] as? Date else {
            print("ERROR: nil value found for birthdate in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 126.")
            return nil
        }
        
        guard let mostRecentPromotion = dictionary["mostRecentPromotion"] as? Date else {
            
            print("ERROR: nil value found for mostRecentPromotion in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 132.")
            return nil
        }
        
        //        guard let studentStatus = dictionary["studentStatus"] as? StudentStatus else {
        //
        //            print("ERROR: nil value found for studentStatus in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 140.")
        //            return nil
        //        }
        
        guard let profilePic = dictionary["profilePic"] as? String else {
            
            print("ERROR: nil value found forprofilePic in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 144.")
            return nil
        }
        
        guard let username = dictionary["username"] as? String else {
            
            print("ERROR: nil value found for username in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 150.")
            return nil
        }
        
        guard let password = dictionary["password"] as? String else {
            
            print("ERROR: nil value found for password in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 156.")
            return nil
        }
        
        guard let firstName = dictionary["firstName"] as? String else {
            
            print("ERROR: nil value found for firstName in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 162.")
            return nil
        }
        
        guard let lastName = dictionary["lastName"] as? String else {
            
            print("ERROR: nil value found for lastName in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 168.")
            return nil
        }
        
        guard let parentGuardian = dictionary["parentGuardian"] as? String else {
            
            print("ERROR: nil value found for parentGuardian in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 174.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 180.")
            return nil
        }
        
        guard let mobile = dictionary["mobile"] as? String else {
            
            print("ERROR: nil value found for mobile in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 186.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 192")
            return nil
        }
        
        self.init(kidStudentUUID: kidStudentUUID, isKid: isKid, dateCreated: dateCreated, dateEdited: dateEdited, birthdate: birthdate, mostRecentPromotion: mostRecentPromotion, profilePic: profilePic, username: username, password: password, firstName: firstName, lastName: lastName, parentGuardian: parentGuardian, phone: phone, mobile: mobile, email: email)
    }
}
