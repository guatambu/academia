//
//  Location+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension Location {
    
    convenience init(locationUID: String,
                     active: Bool,
                     dateCreated: Date,
                     dateEdited: Date,
                     profilePic: UIImage?,
                     locationName: String,
                     streetAddress: String,
                     city: String,
                     state: String,
                     zipCode: String,
                     phone: String,
                     website: String?,
                     email: String?,
                     social: String?,
                     context: NSManagedObjectContext
        ) {
        
        self.init(context: context)
        
        self.locationUID = locationUID
        self.active = active
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.profilePic = profilePic
        self.locationName = locationName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.website = website
        self.email = email
        self.social = social
    }
    
}

//extension Location: Equatable {
//    
//    static func ==(lhs: Location, rhs: Location) -> Bool {
//        if lhs.city != rhs.city { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.email != rhs.email { return false }
//        if lhs.locationName != rhs.locationName { return false }
//        if lhs.locationUID != rhs.locationUID { return false }
//        if lhs.state != rhs.state { return false }
//        if lhs.streetAddress != rhs.streetAddress { return false }
//        if lhs.zipCode != rhs.zipCode { return false }
//        
//        return true
//    }
//}

