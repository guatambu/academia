//
//  Owner+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

extension Owner {
    
    convenience init(ownerUID: String,
                     isInstructor: Bool,
                     dateCreated: Date,
                     dateEdited: Date,
                     birthdate: Date,
                     promotions: [String: Date]?,
                     mostRecentPromotion: Date?,
                     attendance: [Date]?,
                     groups: [GroupX]?,
                     permission: UserPermissions,
                     adultBasicBelt: AdultBasicBeltX?,
                     blackBelt: AdultBlackBeltX?,
                     profilePic: UIImage?,
                     username: String,
                     firstName: String,
                     lastName: String,
                     streetAddress: String,
                     city: String,
                     state: String,
                     zipCode: String,
                     phone: String?,
                     mobile: String?,
                     email: String,
                     context: NSManagedObjectContext
        ) {
        
        self.init(context: context)
            
            self.ownerUID = ownerUID
            self.isInstructor = isInstructor
            self.dateCreated = dateCreated
            self.dateEdited = dateEdited
            self.birthdate = birthdate
            self.promotions = promotions
            self.mostRecentPromotion = mostRecentPromotion
            self.attendance = attendance
            self.adultBasicBelt = adultBasicBelt
            self.blackBelt = blackBelt
            self.groups = groups
            self.permission = permission
            self.profilePic = profilePic
            self.username = username
            self.firstName = firstName
            self.lastName = lastName
            self.streetAddress = streetAddress
            self.city = city
            self.state = state
            self.zipCode = zipCode
            self.phone = phone
            self.mobile = mobile
            self.email = email
    }
    
}


//extension Owner: Equatable {
//    
//    static func ==(lhs: Owner, rhs: Owner) -> Bool {
//        if lhs.birthdate != rhs.birthdate { return false }
//        if lhs.city != rhs.city { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.email != rhs.email { return false }
//        if lhs.firstName != rhs.firstName { return false }
//        if lhs.isInstructor != rhs.isInstructor { return false }
//        if lhs.lastName != rhs.lastName { return false }
//        if lhs.mobile != rhs.mobile { return false }
//        if lhs.ownerUID != rhs.ownerUID { return false }
//        if lhs.permission != rhs.permission { return false }
//        if lhs.phone != rhs.phone { return false }
//        if lhs.state != rhs.state { return false }
//        if lhs.streetAddress != rhs.streetAddress { return false }
//        if lhs.username != rhs.username { return false }
//        if lhs.zipCode != rhs.zipCode { return false }
//        
//        return true
//    }
//}

