//
//  User.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class User {
    
    // MARK: - Properties
    
    // Bool
    var isOwner: Bool
    var isInstructor: Bool
    var isKid: Bool
    
    // Date
    var dateCreated: Date
    var dateEdited: Date
    var birthdate: Date
    var promotions: [String: Date]?
    var mostRecentPromotion: Date?
    var attendance: [Date]?
    
    // Status
    var userStatus: [UserStatus]
    
    // Data Model related
    var status: UserStatus?
    var groups: [Group?]
    var paymentProgram: PaymentProgram?
    var permission: [Permissions]
    var kidsBelt: KidsBelt?
    var adultBasicBelt: AdultBasicBelt?
    var blackBelt: AdultBlackBelt?
    
    // Images
    var profilePic: UIImage?
    
    // Strings
    var username: String
    var firstName: String
    var lastName: String
    var parentGuardian: String?
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    var phone: String?
    var mobile: String?
    var email: String
    var emergencyContact: String
    var emergencyContactPhone: String
    var emergencyContactRelationship: String
    
    
    // Permissions
    
    enum Permissions {
        case owner
        case instructor
        case adultStudent
        case parentGuardian
    }
    
    // User Status
    
    enum UserStatus {
        case active
        case inactive
        case paused
        case medicalPause
        case delinquent
        case paid
    }
    
    // Basic Memberwise Initializer
    init(isOwner: Bool,
         isInstructor: Bool,
         isKid: Bool,
         dateCreated: Date,
         dateEdited: Date,
         birthdate: Date,
         promotions: [String: Date]?,
         mostRecentPromotion: Date?,
         attendance: [Date]?,
         userStatus: [UserStatus],
         groups: [Group],
         paymentProgram: PaymentProgram?,
         permission: [Permissions],
         kidsBelt: KidsBelt?,
         adultBasicBelt: AdultBasicBelt?,
         blackBelt: AdultBlackBelt?,
         profilePic: UIImage?,
         username: String,
         firstName: String,
         lastName: String,
         parentGuardian: String?,
         streetAddress: String,
         city: String,
         state: String,
         zipCode: String,
         phone: String?,
         mobile: String?,
         email: String,
         emergencyContact: String,
         emergencyContactPhone: String,
         emergencyContactRelationship: String
         ) {
        
        self.isOwner = isOwner
        self.isInstructor = isInstructor
        self.isKid = isKid
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendance = attendance
        self.userStatus = userStatus
        self.kidsBelt = kidsBelt
        self.adultBasicBelt = adultBasicBelt
        self.blackBelt = blackBelt
        self.groups = groups
        self.paymentProgram = paymentProgram
        self.permission = permission
        self.profilePic = profilePic
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.parentGuardian = parentGuardian
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContact = emergencyContact
        self.emergencyContactPhone = emergencyContactPhone
        self.emergencyContactRelationship = emergencyContactRelationship
    }
}


//var owner: User = User(isOwner: true, isInstructor: true, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, instructors, adults, kidsParents], paymentProgram: nil, permission: [User.Permissions.owner], kidsBelt: nil, adultBasicBelt: nil, blackBelt: blackBelt, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "owner", firstName: "steve", lastName: "meister", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")
//
//var instructorA: User = User(isOwner: false, isInstructor: true, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, instructors, adults], paymentProgram: adultsProgram, permission: [User.Permissions.instructor], kidsBelt: nil, adultBasicBelt: purpleBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "instructorA", firstName: "rod", lastName: "schneider", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")
//
//var instructorB: User = User(isOwner: false, isInstructor: true, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, instructors, adults], paymentProgram: adultsProgram, permission: [User.Permissions.instructor], kidsBelt: nil, adultBasicBelt: nil, blackBelt: blackBelt, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "instructorB", firstName: "daniel", lastName: "hoover", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")
//
//var adultA: User = User(isOwner: false, isInstructor: false, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, adults], paymentProgram: adultsProgram, permission: [User.Permissions.adultStudent], kidsBelt: nil, adultBasicBelt: blueBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "adultA", firstName: "rob", lastName: "roberts", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")
//
//var adultB: User = User(isOwner: false, isInstructor: false, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, adults], paymentProgram: adultsProgram, permission: [User.Permissions.adultStudent], kidsBelt: nil, adultBasicBelt: brownBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "adultB", firstName: "ruben", lastName: "destafani", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")
//
//var kidA: User = User(isOwner: false, isInstructor: false, isKid: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, kidsParents], paymentProgram: kidsProgram, permission: [User.Permissions.parentGuardian], kidsBelt: grayBlackBelt, adultBasicBelt: nil, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "kidA", firstName: "hunter", lastName: "deucey", parentGuardian: "douchy deucy", streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")
//
//var kidB: User = User(isOwner: false, isInstructor: false, isKid: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, kidsParents], paymentProgram: kidsProgram, permission: [User.Permissions.parentGuardian], kidsBelt: orangeBelt, adultBasicBelt: nil, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "kidB", firstName: "marla", lastName: "unasis", parentGuardian: "alabaster unasis", streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")




































