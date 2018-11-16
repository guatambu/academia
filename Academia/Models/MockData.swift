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

    static var allStudents = Group(groupUID: UUID(), active: true, name: "all students", dateCreated: Date(), dateEdited: Date(), members: [owner, adultA])

    // location

    static var myLocation = Location(locationUID: UUID(), active: true, dateCreated: Date(), dateEdited: Date(), profilePic: #imageLiteral(resourceName: "owner_sample.png"), locationName: "my location", streetAddress: "1267 the spot blvd.", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social: nil)

    // payment programs

    static var programA: PaymentProgram = PaymentProgram(paymentProgramUID: UUID(), active: true, programName: "programA", dateCreated: Date(), dateEdited: Date(), billingType: ["digital"], billingOptions: ["1st of month"], paymentDescription: "things", paymentAgreement: "stuff", signatureType: ["digital"])

    // classes

    static let adultClassA: Aula = Aula(aulaUID: UUID(), active: true, aulaName: "adult A", aulaDescription: "A class for the adults",  daysOfTheWeek: [Weekdays.Monday, Weekdays.Wednesday, Weekdays.Friday], timeOfDay: Aula.ClassTimes.nineteen, location: myLocation, students: [adultA], instructor: [adultA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [adultA])

    // users

    static var owner: Owner = Owner(ownerUID: UUID(), isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, groups: nil, permission: UserPermissions.owner, belt: blackBelt, profilePic: #imageLiteral(resourceName: "owner_sample.png"), username: "owner", firstName: "steve", lastName: "meister", addressLine1: "1234 street dr.", addressLine2: "123", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContactName: "margaret stewart", emergencyContactPhone: "345-123-0987", emergencyContactRelationship: "bae")

    static var adultA: AdultStudent = AdultStudent(adultStudentUID: UUID(), isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active, StudentStatus.paid], groups: nil, paymentProgram: programA, permission: [UserPermissions.instructor, UserPermissions.adultStudent], belt: purpleBelt, profilePic: #imageLiteral(resourceName: "student_sample.jpg"), username: "adultA", firstName: "dan", lastName: "cnakle", addressLine1: "123 my street blvd.", addressLine2: "4A", city: "theTown", state: "CA", zipCode: "92346", phone: "123-987-0980", mobile: "098-865-1234", email: "adult@email.com", emergencyContactName: "margie", emergencyContactPhone: "858-098-1234", emergencyContactRelationship: "wife")

    static var kidA: KidStudent = KidStudent(kidUID: UUID(), dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active], groups: nil, paymentProgram: programA, permission: [UserPermissions.parentGuardian], belt: grayBelt, profilePic: #imageLiteral(resourceName: "kid_sample.jpg"), username: "kiddo", firstName: "stevie", lastName: "johnson", parentGuardian: "david johnson", addressLine1: "123 street st.", addressLine2: "#3D", city: "city", state: "state", zipCode: "12334", phone: "123-098-0987", mobile: "345-678-5432", email: "email@email.com", emergencyContactName: "marsha johnson", emergencyContactPhone: "123-098-0997", emergencyContactRelationship: "momma")

    static var adultStudents = [adultA]
    static var kidStudents = [kidA]

    // adult basic belts

    static let whiteBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultWhiteBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultWhiteBelt, numberOfStripes: 4)


    static let blueBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultBlueBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultBlueBelt, numberOfStripes: 4)


    static let purpleBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultPurpleBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultPurpleBelt, numberOfStripes: 4)

    static let brownBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultBrownBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultBrownBelt, numberOfStripes: 4)


    static var adultBasicBelts = [whiteBelt, blueBelt, purpleBelt, brownBelt]

    // adult black belts

    static let blackBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultBlackBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultBlackBelt, numberOfStripes: 6)


    static let redBlackBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultRedBlackBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultRedBlackBelt, numberOfStripes: 7)


    static let redWhiteBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultRedWhiteBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultRedWhiteBelt, numberOfStripes: 8)


    static let redBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.adultRedBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.adultRedBelt, numberOfStripes: 10)


    static var blackBelts = [blackBelt, redBlackBelt, redWhiteBelt, redBelt]

    // kids belts

    static let kidsWhiteBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsWhiteBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsWhiteBelt, numberOfStripes: 11)


    static let grayWhiteBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsGreyWhiteBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreyWhiteBelt, numberOfStripes: 11)


    static let grayBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsGreyBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreyBelt, numberOfStripes: 11)


    static let grayBlackBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsGreyBlackBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreyBlackBelt, numberOfStripes: 11)


    static let yellowWhiteBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsYellowWhiteBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsYellowWhiteBelt, numberOfStripes: 11)


    static let yellowBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsYellowBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsYellowBelt, numberOfStripes: 11)


    static let yellowBlackBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsYellowBlackBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsYellowBlackBelt, numberOfStripes: 11)


    static let orangeWhiteBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsOrangeWhiteBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsOrangeWhiteBelt, numberOfStripes: 11)


    static let orangeBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsOrangeBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsOrangeBelt, numberOfStripes: 11)


    static let orangeBlackBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsOrangeBlackBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsOrangeBlackBelt, numberOfStripes: 11)


    static let greenWhiteBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsGreenWhiteBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreenWhiteBelt, numberOfStripes: 11)


    static let greenBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsGreenBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreenBelt, numberOfStripes: 11)


    static let greenBlackBelt = Belt(beltUID: UUID(), dateCreated: Date(), dateEdited: Date(), name: InternationalStandardBJJBelts.kidsGreenBlackBelt.rawValue, active: true, elligibleForNextBelt: false, classesToNextPromotion: 0, beltLevel: InternationalStandardBJJBelts.kidsGreenBlackBelt, numberOfStripes: 11)


    static var kidsBelts = [kidsWhiteBelt, grayWhiteBelt, grayBelt, grayBlackBelt, yellowWhiteBelt, yellowBelt, yellowBlackBelt, orangeWhiteBelt, orangeBelt, orangeBlackBelt, greenWhiteBelt, greenBelt, greenBlackBelt]

}




























