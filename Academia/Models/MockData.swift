//
//  MockData.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

struct MockData {

    // 1. build the mock data in the respective ViewController's viewDidLoad() rather than an external file like here

    // 2. app delegate then is home of user for the whole app

    // 3. should be ready to go going forward

    // groups
    static var allStudents = Group(groupUID: UUID(), active: true, name: "all students", description: "description", dateCreated: Date(), dateEdited: Date(), kidMembers: [kidA], adultMembers: [adultA])

    // location
    static var myLocation = Location(locationUID: UUID(), active: true, dateCreated: Date(), dateEdited: Date(), locationPic: #imageLiteral(resourceName: "owner_sample.png"), locationName: "my location", addressLine1: "1267 the spot blvd.", addressLine2: "", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social1: nil, social2: nil, social3: nil)

    // payment programs
    static var programA: PaymentProgram = PaymentProgram(paymentProgramUID: UUID(), active: true, programName: "programA", dateCreated: Date(), dateEdited: Date(), billingTypes: [Billing.BillingType.monthly], billingDates: [Billing.BillingDate.firstOfTheMonth], signatureTypes: [Billing.BillingSignature.digitallyTyped], paymentDescription: "things", paymentAgreement: "stuff")

    // classes
    static let adultClassA: Aula = Aula(aulaUID: UUID(), active: true, aulaName: "adult A", aulaDescription: "A class for the adults",  daysOfTheWeek: [ClassTimeComponents.Weekdays.Monday, ClassTimeComponents.Weekdays.Wednesday, ClassTimeComponents.Weekdays.Friday], time: "\(ClassTimeComponents.Hours24.eighteen.rawValue)", timeCode: 5, location: myLocation, kidAttendees: [kidA], adultAttendees: [adultA], instructor: [adultA], ownerInstructor: [owner], classGroups: [allStudents], currentDate: Date(), dateCreated: Date(), dateEdited: Date())

    // users
    static var owner: Owner = Owner(ownerUID: UUID(), isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, groups: nil, permission: UserPermissions.owner, belt: blackBelt, profilePic: #imageLiteral(resourceName: "owner_sample.png"), username: "owner", password: "password", firstName: "steve", lastName: "meister", addressLine1: "1234 street dr.", addressLine2: "123", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContactName: "margaret stewart", emergencyContactPhone: "345-123-0987", emergencyContactRelationship: "bae")

    static var adultA: AdultStudent = AdultStudent(adultStudentUID: UUID(), isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active, StudentStatus.paid], groups: nil, paymentProgram: programA, permission: [UserPermissions.instructor, UserPermissions.adultStudent], belt: purpleBelt, profilePic: #imageLiteral(resourceName: "student_sample.jpg"), username: "adultA", password: "adultA", firstName: "dan", lastName: "cnakle", addressLine1: "123 my street blvd.", addressLine2: "4A", city: "theTown", state: "CA", zipCode: "92346", phone: "123-987-0980", mobile: "098-865-1234", email: "adult@email.com", emergencyContactName: "margie", emergencyContactPhone: "858-098-1234", emergencyContactRelationship: "wife")
    
    static var adultB: AdultStudent = AdultStudent(adultStudentUID: UUID(), isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active, StudentStatus.paid], groups: nil, paymentProgram: programA, permission: [UserPermissions.instructor, UserPermissions.adultStudent], belt: blueBelt, profilePic: #imageLiteral(resourceName: "student_sample.jpg"), username: "adultB", password: "adultB", firstName: "pat", lastName: "jones", addressLine1: "765 my avenue ave.", addressLine2: "7G", city: "theTown", state: "CA", zipCode: "92346", phone: "123-987-4567", mobile: "098-345-7890", email: "beme@email.com", emergencyContactName: "sheila", emergencyContactPhone: "098-890-5674", emergencyContactRelationship: "the wife")

    static var kidA: KidStudent = KidStudent(kidUID: UUID(), dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active], groups: nil, paymentProgram: programA, permission: [UserPermissions.parentGuardian], belt: grayBelt, profilePic: #imageLiteral(resourceName: "kid_sample.jpg"), username: "kiddo", password: "kidA", firstName: "stevie", lastName: "johnson", parentGuardian: "david johnson", addressLine1: "123 street st.", addressLine2: "#3D", city: "city", state: "state", zipCode: "12334", phone: "123-098-0987", mobile: "345-678-5432", email: "email@email.com", emergencyContactName: "marsha johnson", emergencyContactPhone: "123-098-0997", emergencyContactRelationship: "momma")
    
    static var kidB: KidStudent = KidStudent(kidUID: UUID(), dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active], groups: nil, paymentProgram: programA, permission: [UserPermissions.parentGuardian], belt: grayWhiteBelt, profilePic: #imageLiteral(resourceName: "kid_sample.jpg"), username: "kiddie", password: "kidB", firstName: "griffin", lastName: "smith", parentGuardian: "david smith", addressLine1: "789 raod rd.", addressLine2: "#5A", city: "city", state: "state", zipCode: "12334", phone: "987-654-3210", mobile: "789-654-1234", email: "mel@email.com", emergencyContactName: "marsha smith", emergencyContactPhone: "321-654-0987", emergencyContactRelationship: "mom")

    static var adultStudents = [adultA]
    static var kidStudents = [kidA]

    // adult basic belts
    static let whiteBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultWhiteBelt, numberOfStripes: 4, beltTime: "1 year", minAgeRequirement: "none", iStripe: "1M", iiStripe: "1M", iiiStripe: "2M", ivStripe: "4M", vStripe: nil, viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)


    static let blueBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultBlueBelt, numberOfStripes: 4, beltTime: "2 years", minAgeRequirement: "16 years", iStripe: "4M", iiStripe: "4M", iiiStripe: "5M", ivStripe: "5M", vStripe: nil, viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)


    static let purpleBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultPurpleBelt, numberOfStripes: 4, beltTime: "1 1/2 years", minAgeRequirement: "16 years", iStripe: "3M", iiStripe: "3M", iiiStripe: "4M", ivStripe: "4M", vStripe: nil, viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)
    
    static let brownBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultBrownBelt, numberOfStripes: 4, beltTime: "1 1/2 years", minAgeRequirement: "18 years", iStripe: "3M", iiStripe: "3M", iiiStripe: "4M", ivStripe: "4M", vStripe: nil, viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)

    static var adultBasicBelts = [whiteBelt, blueBelt, purpleBelt, brownBelt]

    // adult black belts
    static let blackBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultBlackBelt, numberOfStripes: 6, beltTime: "31 years", minAgeRequirement: "19 years", iStripe: "3Y", iiStripe: "3Y", iiiStripe: "3Y", ivStripe: "5Y", vStripe: "5Y", viStripe: "5Y", viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)

    static let redBlackBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultRedBlackBelt, numberOfStripes: 7, beltTime: "7 years", minAgeRequirement: "50 years", iStripe: nil, iiStripe: nil, iiiStripe: nil, ivStripe: nil, vStripe: nil, viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)


    static let redWhiteBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultRedWhiteBelt, numberOfStripes: 8, beltTime: "10 years", minAgeRequirement: "57 years", iStripe: nil, iiStripe: nil, iiiStripe: nil, ivStripe: nil, vStripe: nil, viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)


    static let redBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultRedBelt, numberOfStripes: 10, beltTime: "", minAgeRequirement: "67 years", iStripe: nil, iiStripe: nil, iiiStripe: nil, ivStripe: nil, vStripe: nil, viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: "7Y", xiStripe: nil)


    static var blackBelts = [blackBelt, redBlackBelt, redWhiteBelt, redBelt]
    
    static var allAdultBelts = [whiteBelt, blueBelt, purpleBelt, brownBelt, blackBelt, redBlackBelt, redWhiteBelt, redBelt]

    // kids belts
    static let kidsWhiteBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsWhiteBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "3 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: nil, viiStripe: nil, viiiStripe: nil, ixStripe: nil, xStripe: nil, xiStripe: nil)


    static let grayWhiteBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreyWhiteBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "3 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)


    static let grayBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreyBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "3 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)

    static let grayBlackBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreyBlackBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "3 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)


    static let yellowWhiteBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsYellowWhiteBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "7 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)


    static let yellowBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsYellowBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "7 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)

    static let yellowBlackBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsYellowBlackBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "7 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)

    static let orangeWhiteBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsOrangeWhiteBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "10 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)


    static let orangeBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsOrangeBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "10 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)
    
    static let orangeBlackBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsOrangeBlackBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "10 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)


    static let greenWhiteBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreenWhiteBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "13 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)


    static let greenBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreenBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "13 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)

    static let greenBlackBelt = Belt(classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreenBlackBelt, numberOfStripes: 11, beltTime: "1 year", minAgeRequirement: "13 years", iStripe: "1M", iiStripe: "1M", iiiStripe: "1M", ivStripe: "1M", vStripe: "1M", viStripe: "1M", viiStripe: "1M", viiiStripe: "1M", ixStripe: "1M", xStripe: "1M", xiStripe: nil)


    static var kidsBelts = [kidsWhiteBelt, grayWhiteBelt, grayBelt, grayBlackBelt, yellowWhiteBelt, yellowBelt, yellowBlackBelt, orangeWhiteBelt, orangeBelt, orangeBlackBelt, greenWhiteBelt, greenBelt, greenBlackBelt]

}




























