//
//  PaymentBillingDateFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
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
    var mostRecentPromotion: Date?
    //var studentStatus: StudentStatusCD?
    //var belt: BeltCD
    var profilePic: String?
    var username: String
    var password: String
    var firstName: String
    var lastName: String
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
            "mostRecentPromotion" : mostRecentPromotion ?? Date(),
            // "studentStatus" : studentStatus,
            // "belt" : username,
            "profilePic" : profilePic ?? "",
            "username" : username,
            // "address" : address,
            "firstName" : firstName,
            "lastName" : lastName,
            "phone" : phone ?? "",
            "mobile" : mobile ?? "",
            "email" : email,
            // "emergencyContact" : emergencyContact
        ]
    }
    
    
    // convenience initializer to allow creation of an OwnerCD object via Academia CoreDataStack's managedObjectContext
    init(kidStudentUUID: String = "\(UUID())",
        dateCreated: Date = Date(),
        dateEdited: Date = Date(),
        mostRecentPromotion: Date?,
        //studentStatus: StudentStatusCD?,
        //belt: BeltCD,
        profilePic: String?,
        username: String,
        password: String,
        firstName: String,
        lastName: String,
        //address: AddressCD,
        phone: String?,
        mobile: String?,
        email: String
        //emergencyContact: EmergencyContactCD
        ) {
        
        self.kidStudentUUID = kidStudentUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.mostRecentPromotion = mostRecentPromotion
        //self.studentStatus = studentStatus
        //self.belt = belt
        self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
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
            
            print("ERROR: nil value found for kidStudentUUID in firestore dictionary in TestModel.swift -> init(dictionary:) - line 118.")
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
        
        guard let mostRecentPromotion = dictionary["mostRecentPromotion"] as? Date else {
            
            print("ERROR: nil value found for mostRecentPromotion in firestore dictionary in TestModel.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        //        guard let studentStatus = dictionary["studentStatus"] as? StudentStatus else {
        //
        //            print("ERROR: nil value found for studentStatus in firestore dictionary in TestModel.swift -> init(dictionary:) - line 148.")
        //            return nil
        //        }
        
        //        guard let belt = dictionary["belt"] as? Belt else {
        //
        //            print("ERROR: nil value found for belt in firestore dictionary in TestModel.swift -> init(dictionary:) - line 154.")
        //            return nil
        //        }
        
        guard let profilePic = dictionary["profilePic"] as? String else {
            
            print("ERROR: nil value found forprofilePic in firestore dictionary in TestModel.swift -> init(dictionary:) - line 160.")
            return nil
        }
        
        guard let username = dictionary["username"] as? String else {
            
            print("ERROR: nil value found for username in firestore dictionary in TestModel.swift -> init(dictionary:) - line 106.")
            return nil
        }
        
        guard let password = dictionary["password"] as? String else {
            
            print("ERROR: nil value found for password in firestore dictionary in TestModel.swift -> init(dictionary:) - line 112.")
            return nil
        }
        
        guard let firstName = dictionary["firstName"] as? String else {
            
            print("ERROR: nil value found for firstName in firestore dictionary in TestModel.swift -> init(dictionary:) - line 166.")
            return nil
        }
        
        guard let lastName = dictionary["lastName"] as? String else {
            
            print("ERROR: nil value found for lastName in firestore dictionary in TestModel.swift -> init(dictionary:) - line 172.")
            return nil
        }
        
        //        guard let address = dictionary["address"] as? AddressFirestore else {
        //
        //            print("ERROR: nil value found for address in firestore dictionary in TestModel.swift -> init(dictionary:) - line 178.")
        //            return nil
        //        }
        
        guard let phone = dictionary["phone"] as? String else {
            
            print("ERROR: nil value found for phone in firestore dictionary in TestModel.swift -> init(dictionary:) - line 184.")
            return nil
        }
        
        guard let mobile = dictionary["mobile"] as? String else {
            
            print("ERROR: nil value found for mobile in firestore dictionary in TestModel.swift -> init(dictionary:) - line 190.")
            return nil
        }
        
        guard let email = dictionary["email"] as? String else {
            
            print("ERROR: nil value found for email in firestore dictionary in TestModel.swift -> init(dictionary:) - line 196.")
            return nil
        }
        
        //        guard let emergencyContact = dictionary["emergencyContact"] as? EmergencyContactFirestore else {
        //
        //            print("ERROR: nil value found for emergencyContact in firestore dictionary in TestModel.swift -> init(dictionary:) - line 202.")
        //            return nil
        //        }
        
        self.init(kidStudentUUID: kidStudentUUID, dateCreated: dateCreated, dateEdited: dateEdited, mostRecentPromotion: mostRecentPromotion, profilePic: profilePic, username: username, password: password, firstName: firstName, lastName: lastName, phone: phone, mobile: mobile, email: email)
    }
}
