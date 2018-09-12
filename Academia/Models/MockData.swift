//
//  MockData.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

struct MockData {

    // location

    static var myLocation = Location(active: true, dateCreated: Date(), dateEdited: Date(), profilePic: #imageLiteral(resourceName: "download.jpg"), locationName: "my location", streetAddress: "1267 the spot blvd.", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social: nil)

    // payment programs

    static var kidsProgram = PaymentProgram(active: true, programName: "Kids A", dateCreated: Date(), dateEdited: Date(), groups: [kidsParents], billingType: ["1st of month"], billingOptions: ["online with credit card"], paymentDescription: "long string", paymentAgreement: "legal agreement language", signatureType: ["digital signature"])

    static var adultsProgram = PaymentProgram(active: true, programName: "Adults A", dateCreated: Date(), dateEdited: Date(), groups: [kidsParents], billingType: ["1st of month", "15th of month"], billingOptions: ["online with credit card"], paymentDescription: "long string", paymentAgreement: "legal agreement language", signatureType: ["digital signature"])

    // classes

    static let kidsClassA = Aula(active: true, className: "kids A", daysOfTheWeek: [Aula.Weekdays.Monday, Aula.Weekdays.Wednesday, Aula.Weekdays.Friday], timeOfDay: [Aula.ClassTimes.eighteen], location: myLocation, groups: [kidsParents], students: [kidA, kidB], instructor: [instructorA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [kidA, kidB])

    static let adultClassA: Aula = Aula(active: true, className: "adult A", daysOfTheWeek: [Aula.Weekdays.Monday, Aula.Weekdays.Wednesday, Aula.Weekdays.Friday], timeOfDay: [Aula.ClassTimes.nineteen], location: myLocation, groups: [adults], students: [adultA, adultB], instructor: [instructorA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [adultA, adultB])

    // users

    static var owner: User = User(isOwner: true, isInstructor: true, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, instructors, adults, kidsParents], paymentProgram: nil, permission: [User.Permissions.owner], kidsBelt: nil, adultBasicBelt: nil, blackBelt: blackBelt, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "owner", firstName: "steve", lastName: "meister", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")

    static var instructorA: User = User(isOwner: false, isInstructor: true, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, instructors, adults], paymentProgram: adultsProgram, permission: [User.Permissions.instructor], kidsBelt: nil, adultBasicBelt: purpleBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "instructorA", firstName: "rod", lastName: "schneider", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")

    static var instructorB: User = User(isOwner: false, isInstructor: true, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, instructors, adults], paymentProgram: adultsProgram, permission: [User.Permissions.instructor], kidsBelt: nil, adultBasicBelt: nil, blackBelt: blackBelt, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "instructorB", firstName: "daniel", lastName: "hoover", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")

    static var adultA: User = User(isOwner: false, isInstructor: false, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, adults], paymentProgram: adultsProgram, permission: [User.Permissions.adultStudent], kidsBelt: nil, adultBasicBelt: blueBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "adultA", firstName: "rob", lastName: "roberts", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")

    static var adultB: User = User(isOwner: false, isInstructor: false, isKid: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, adults], paymentProgram: adultsProgram, permission: [User.Permissions.adultStudent], kidsBelt: nil, adultBasicBelt: brownBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "adultB", firstName: "ruben", lastName: "destafani", parentGuardian: nil, streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")

    static var kidA: User = User(isOwner: false, isInstructor: false, isKid: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents, kidsParents], paymentProgram: kidsProgram, permission: [User.Permissions.parentGuardian], kidsBelt: grayBlackBelt, adultBasicBelt: nil, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "kidA", firstName: "hunter", lastName: "deucey", parentGuardian: "douchy deucy", streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")

    static var kidB: User = User(isOwner: false, isInstructor: false, isKid: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(),  promotions: nil, mostRecentPromotion: nil, attendance: nil, userStatus: [User.UserStatus.active], groups: [allStudents,kidsParents], paymentProgram: kidsProgram, permission: [User.Permissions.parentGuardian], kidsBelt: orangeBelt, adultBasicBelt: nil, blackBelt: nil, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "kidB", firstName: "marla", lastName: "unasis", parentGuardian: "alabaster unasis", streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com", emergencyContact: "my wife", emergencyContactPhone: "(543) 879-9987", emergencyContactRelationship: "wife")

    // groups

    static var kidsParents: Group = Group(active: true, name: "kids Parents", dateCreated: Date(), dateEdited: Date(), members: [kidA, kidB, owner], paymentProgram: [kidsProgram], location: myLocation, aula: [kidsClassA])

    static var adults = Group(active: true, name: "adults", dateCreated: Date(), dateEdited: Date(), members: [adultA, adultB, instructorA, instructorB, owner], paymentProgram: [adultsProgram], location: myLocation, aula: [adultClassA])

    static var instructors = Group(active: true, name: "instructors", dateCreated: Date(), dateEdited: Date(), members: [owner, instructorB, instructorA], paymentProgram: [adultsProgram], location: myLocation, aula: [adultClassA])

    // when mock data is included, fails with this group.  it may fail in other groups.  but the UI runs when the mock data is not included
    static var allStudents = Group(active: true, name: "all students", dateCreated: Date(), dateEdited: Date(), members: [owner, instructorA, instructorB, adultA, adultB, kidA, kidB], paymentProgram: [adultsProgram, kidsProgram], location: myLocation, aula: [kidsClassA, adultClassA])



    // adult basic belts

    static let whiteBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 year", firstStripeTime: "3m", secondStripeTime: "3m", thirdStripeTime: "3m", fourthStripeTime: "3m")

    static let blueBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "Blue Belt", active: true, elligibleForNextBelt: true, belt: UIColor.blue, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "2 years", firstStripeTime: "4m", secondStripeTime: "6m", thirdStripeTime: "6m", fourthStripeTime: "4m")

    static let purpleBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "Purple Belt", active: true, elligibleForNextBelt: true, belt: UIColor.purple, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 1/2 years", firstStripeTime: "3m", secondStripeTime: "4m", thirdStripeTime: "4m", fourthStripeTime: "4m")

    static let brownBelt = AdultBasicBelt(dateCreated: Date(), dateEdited: Date(), name: "Brown Belt", active: true, elligibleForNextBelt: true, belt: UIColor.brown, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 1/2 years", firstStripeTime: "3m", secondStripeTime: "4m", thirdStripeTime: "4m", fourthStripeTime: "4m")

    static var adultBasicBelts = [whiteBelt, blueBelt, purpleBelt, brownBelt]

    // adult black belts

    static let blackBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.black, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.black, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: false, eigthWhiteDegree: false, ninthWhiteDegree: false, tenthWhiteDegree: false, beltTimeLabel: "31 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: nil, labelEigthDegreeTime: nil, labelNinthDegreeTime: nil, labelTenthDegreeTime: nil)

    static let redBlackBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.black, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.red, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: false, tenthWhiteDegree: false, beltTimeLabel: "10 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: nil, labelTenthDegreeTime: nil)

    static let redWhiteBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.red, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: true, tenthWhiteDegree: false, beltTimeLabel: "7 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: "7y", labelTenthDegreeTime: nil)

    static let redBelt = AdultBlackBelt(dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.red, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: nil, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: true, tenthWhiteDegree: true, beltTimeLabel: "7 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: "7y", labelTenthDegreeTime: "7y")

    static var blackBelts = [blackBelt, redBlackBelt, redWhiteBelt, redBelt]

    // kids belts

    static let kidsWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: false, thirdRedStripe: false, fourthRedStripe: false, firstBlackStripe: false, secondBlackStripe: false, thirdBlackStripe: false, beltTimeLabel: "6 months", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: nil, labelThirdRedStripe: nil, labelFourthRedStripe: nil, labelFirstBlackStripe: nil, labelSecondBlackStripe: nil, labelThirdBlackStripe: nil)

    static let grayWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Gray White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let grayBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Gray Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let grayBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Gray Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let yellowWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Yellow White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let yellowBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Yellow Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let yellowBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Yellow Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let orangeWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Orange White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let orangeBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Orange Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let orangeBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Ornge Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let greenWhiteBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Green White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let greenBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Green Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let greenBlackBelt = KidsBelt(dateCreated: Date(), dateEdited: Date(), name: "Green Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static var kidsBelts = [kidsWhiteBelt, grayWhiteBelt, grayBelt, grayBlackBelt, yellowWhiteBelt, yellowBelt, yellowBlackBelt, orangeWhiteBelt, orangeBelt, orangeBlackBelt, greenWhiteBelt, greenBelt, greenBlackBelt]

}




























