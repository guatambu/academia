//
//  AdultStudentFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/4/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol AdultStudentFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct AdultStudentFirestore {
    
    var adultStudentUUID: String
    var isKid: Bool
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
            "adultStudentUUID" : adultStudentUUID,
            "isKid" : isKid,
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
    
    
    // initializer to allow creation of an AdultStudentFirestore object
    init(adultStudentUUID: String = "\(UUID())",
        isKid: Bool = false,
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
        
        self.adultStudentUUID = adultStudentUUID
        self.isKid = isKid
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


extension AdultStudentFirestore: AdultStudentFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let adultStudentUUID = dictionary["adultStudentUUID"] as? String else {
            
            print("ERROR: nil value found for adultStudentUUID in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 103.")
            return nil
        }
        
        guard let isKid = dictionary["isKid"] as? Bool else {
            
            print("ERROR: nil value found for isKid in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 109.")
            return nil
        }
        
        guard let isInstructor = dictionary["isInstructor"] as? Bool else {
            
            print("ERROR: nil value found for isInstructor in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 115.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 121.")
            return nil
        }
        
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 128.")
            return nil
        }
        
        guard let birthdate = dictionary["birthdate"] as? Date else {
            
            print("ERROR: nil value found for birthdate in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 134.")
            return nil
        }
        
        guard let mostRecentPromotion = dictionary["mostRecentPromotion"] as? Date else {
            
            print("ERROR: nil value found for mostRecentPromotion in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 140.")
            return nil
        }
        
        //        guard let studentStatus = dictionary["studentStatus"] as? StudentStatus else {
        //
        //            print("ERROR: nil value found for studentStatus in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 148.")
        //            return nil
        //        }
        
        guard let profilePic = dictionary["profilePic"] as? String else {
            
            print("ERROR: nil value found forprofilePic in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 152.")
            return nil
        }
        
        guard let username = dictionary["username"] as? String else {
            
            print("ERROR: nil value found for username in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 158.")
            return nil
        }
        
        guard let password = dictionary["password"] as? String else {
            
            print("ERROR: nil value found for password in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 164.")
            return nil
        }
        
        guard let firstName = dictionary["firstName"] as? String else {
            
            print("ERROR: nil value found for firstName in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 170.")
            return nil
        }
        
        guard let lastName = dictionary["lastName"] as? String else {
            
            print("ERROR: nil value found for lastName in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 176.")
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 182.")
            return nil
        }
        
        guard let mobile = dictionary["mobile"] as? String else {
            
            print("ERROR: nil value found for mobile in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 188.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in AdultStudentFirestore.swift -> init(dictionary:) - line 194.")
            return nil
        }
        
        self.init(adultStudentUUID: adultStudentUUID, isKid: isKid, isInstructor: isInstructor, dateCreated: dateCreated, dateEdited: dateEdited, birthdate: birthdate, mostRecentPromotion: mostRecentPromotion, profilePic: profilePic, username: username, password: password, firstName: firstName, lastName: lastName, phone: phone, mobile: mobile, email: email)
    }
}
