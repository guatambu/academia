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
    var dateCreated: Date
    var dateEdited: Date
    var birthdate: Date
    var mostRecentPromotion: Date?
    //var studentStatus: StudentStatusCD?
    //var belt: BeltCD
    var profilePic: String?
    var username: String
    var password: String
    var firstName: String
    var lastName: String
    var parentGuardian: String
    //var address: AddressCD
    var phone: String?
    var mobile: String?
    var email: String
    //var emergencyContact: EmergencyContactCD
    
    
    var dictionary: [String : Any] {
        return [
            "kidStudentUUID" : kidStudentUUID,
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
            "birthdate" : birthdate,
            "mostRecentPromotion" : mostRecentPromotion ?? Date(),
            // "studentStatus" : studentStatus,
            // "belt" : username,
            "profilePic" : profilePic ?? "",
            "username" : username,
            // "address" : address,
            "firstName" : firstName,
            "lastName" : lastName,
            "parentGuardian" : parentGuardian,
            "phone" : phone ?? "",
            "mobile" : mobile ?? "",
            "email" : email,
            // "emergencyContact" : emergencyContact
        ]
    }
    
    
    // initializer to allow creation of an KidStudentFirestore object
    init(kidStudentUUID: String = "\(UUID())",
        dateCreated: Date = Date(),
        dateEdited: Date = Date(),
        birthdate: Date,
        mostRecentPromotion: Date?,
        //studentStatus: StudentStatusCD?,
        //belt: BeltCD,
        profilePic: String?,
        username: String,
        password: String,
        firstName: String,
        lastName: String,
        parentGuardian: String,
        //address: AddressCD,
        phone: String?,
        mobile: String?,
        email: String
        //emergencyContact: EmergencyContactCD
        ) {
        
        self.kidStudentUUID = kidStudentUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.mostRecentPromotion = mostRecentPromotion
        //self.studentStatus = studentStatus
        //self.belt = belt
        self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.parentGuardian = parentGuardian
        //self.address = address
        self.phone = phone
        self.mobile = mobile
        self.email = email
        //self.emergencyContact = emergencyContact
    }
}


extension KidStudentFirestore: KidStudentFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let kidStudentUUID = dictionary["kidStudentUUID"] as? String else {
            
            print("ERROR: nil value found for kidStudentUUID in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 111.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 117.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found for dateEdited in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 123.")
            return nil
        }
        
        guard let birthdate = dictionary["birthdate"] as? Date else {
            print("ERROR: nil value found for birthdate in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 128.")
            return nil
        }
        
        guard let mostRecentPromotion = dictionary["mostRecentPromotion"] as? Date else {
            
            print("ERROR: nil value found for mostRecentPromotion in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 134.")
            return nil
        }
        
        //        guard let studentStatus = dictionary["studentStatus"] as? StudentStatus else {
        //
        //            print("ERROR: nil value found for studentStatus in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 140.")
        //            return nil
        //        }
        
        //        guard let belt = dictionary["belt"] as? Belt else {
        //
        //            print("ERROR: nil value found for belt in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 146.")
        //            return nil
        //        }
        
        guard let profilePic = dictionary["profilePic"] as? String else {
            
            print("ERROR: nil value found forprofilePic in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 152.")
            return nil
        }
        
        guard let username = dictionary["username"] as? String else {
            
            print("ERROR: nil value found for username in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 158.")
            return nil
        }
        
        guard let password = dictionary["password"] as? String else {
            
            print("ERROR: nil value found for password in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 164.")
            return nil
        }
        
        guard let firstName = dictionary["firstName"] as? String else {
            
            print("ERROR: nil value found for firstName in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 170.")
            return nil
        }
        
        guard let lastName = dictionary["lastName"] as? String else {
            
            print("ERROR: nil value found for lastName in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 176.")
            return nil
        }
        
        guard let parentGuardian = dictionary["parentGuardian"] as? String else {
            
            print("ERROR: nil value found for parentGuardian in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 182.")
            return nil
        }
        
        //        guard let address = dictionary["address"] as? AddressFirestore else {
        //
        //            print("ERROR: nil value found for address in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 188.")
        //            return nil
        //        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 194.")
            return nil
        }
        
        guard let mobile = dictionary["mobile"] as? String else {
            
            print("ERROR: nil value found for mobile in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 200.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 206.")
            return nil
        }
        
        //        guard let emergencyContact = dictionary["emergencyContact"] as? EmergencyContactFirestore else {
        //
        //            print("ERROR: nil value found for emergencyContact in firestore dictionary in KidStudentFirestore.swift -> init(dictionary:) - line 212.")
        //            return nil
        //        }
        
        self.init(kidStudentUUID: kidStudentUUID, dateCreated: dateCreated, dateEdited: dateEdited, birthdate: birthdate, mostRecentPromotion: mostRecentPromotion, profilePic: profilePic, username: username, password: password, firstName: firstName, lastName: lastName, parentGuardian: parentGuardian, phone: phone, mobile: mobile, email: email)
    }
}

