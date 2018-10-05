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
    
    static var allStudents = Group(groupUID: "001", active: true, name: "all students", dateCreated: Date(), dateEdited: Date(), members: [owner, adultA])
    
    // location

    static var myLocation = Location(locationUID: "001", active: true, dateCreated: Date(), dateEdited: Date(), profilePic: #imageLiteral(resourceName: "owner_sample.png"), locationName: "my location", streetAddress: "1267 the spot blvd.", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social: nil)

    // payment programs

    static var programA: PaymentProgram = PaymentProgram(paymentProgramUID: "001", active: true, programName: "programA", dateCreated: Date(), dateEdited: Date(), billingType: ["digital"], billingOptions: ["1st of month"], paymentDescription: "things", paymentAgreement: "stuff", signatureType: ["digital"])
    
    // classes

    static let adultClassA: Aula = Aula(aulaUID: "001", active: true, className: "adult A", classDescription: "A class for the adults",  daysOfTheWeek: [Weekdays.Monday, Weekdays.Wednesday, Weekdays.Friday], timeOfDay: Aula.ClassTimes.nineteen, location: myLocation, students: [adultA], instructor: [adultA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [adultA])

    // users

    static var owner: Owner = Owner(ownerUID: "001", isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, groups: nil, permission: UserPermissions.owner, adultBasicBelt: nil, blackBelt: blackBelt, profilePic: #imageLiteral(resourceName: "owner_sample.png"), username: "owner", firstName: "steve", lastName: "meister", streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com")
    
    static var adultA: AdultStudent = AdultStudent(adultStudentUID: "001", isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active, StudentStatus.paid], groups: nil, paymentProgram: programA, permission: [UserPermissions.instructor, UserPermissions.adultStudent], adultBasicBelt: purpleBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "student_sample.jpg"), username: "adultA", firstName: "dan", lastName: "cnakle", streetAddress: "123 my street blvd.", city: "theTown", state: "CA", zipCode: "92346", phone: "123-987-0980", mobile: "098-865-1234", email: "adult@email.com", emergencyContact: "margie", emergencyContactPhone: "858-098-1234", emergencyContactRelationship: "wife")
    
    static var kidA: KidStudent = KidStudent(kidUID: "001", dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active], groups: nil, paymentProgram: programA, permission: [UserPermissions.parentGuardian], kidsBelt: grayBelt, profilePic: #imageLiteral(resourceName: "kid_sample.jpg"), username: "kiddo", firstName: "stevie", lastName: "johnson", parentGuardian: "david johnson", streetAddress: "123 street st.", city: "city", state: "state", zipCode: "12334", phone: "123-098-0987", mobile: "345-678-5432", email: "email@email.com", emergencyContact: "marsha johnson", emergencyContactPhone: "123-098-0997", emergencyContactRelationship: "momma")
    
    static var adultStudents = [adultA]
    static var kidStudents = [kidA]

    // adult basic belts

    static let whiteBelt = AdultBasicBelt(adultBasicBeltUID: "001", dateCreated: Date(), dateEdited: Date(), name: "White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 year", firstStripeTime: "3m", secondStripeTime: "3m", thirdStripeTime: "3m", fourthStripeTime: "3m")

    static let blueBelt = AdultBasicBelt(adultBasicBeltUID: "002", dateCreated: Date(), dateEdited: Date(), name: "Blue Belt", active: true, elligibleForNextBelt: true, belt: UIColor.blue, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "2 years", firstStripeTime: "4m", secondStripeTime: "6m", thirdStripeTime: "6m", fourthStripeTime: "4m")

    static let purpleBelt = AdultBasicBelt(adultBasicBeltUID: "003", dateCreated: Date(), dateEdited: Date(), name: "Purple Belt", active: true, elligibleForNextBelt: true, belt: UIColor.purple, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 1/2 years", firstStripeTime: "3m", secondStripeTime: "4m", thirdStripeTime: "4m", fourthStripeTime: "4m")

    static let brownBelt = AdultBasicBelt(adultBasicBeltUID: "004", dateCreated: Date(), dateEdited: Date(), name: "Brown Belt", active: true, elligibleForNextBelt: true, belt: UIColor.brown, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, beltTime: "1 1/2 years", firstStripeTime: "3m", secondStripeTime: "4m", thirdStripeTime: "4m", fourthStripeTime: "4m")

    static var adultBasicBelts = [whiteBelt, blueBelt, purpleBelt, brownBelt]

    // adult black belts

    static let blackBelt = AdultBlackBelt(adultBlackBeltUID: "001", dateCreated: Date(), dateEdited: Date(), name: "Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.black, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.black, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: false, eigthWhiteDegree: false, ninthWhiteDegree: false, tenthWhiteDegree: false, beltTimeLabel: "31 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: nil, labelEigthDegreeTime: nil, labelNinthDegreeTime: nil, labelTenthDegreeTime: nil)

    static let redBlackBelt = AdultBlackBelt(adultBlackBeltUID: "002", dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.black, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.red, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: false, tenthWhiteDegree: false, beltTimeLabel: "10 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: nil, labelTenthDegreeTime: nil)

    static let redWhiteBelt = AdultBlackBelt(adultBlackBeltUID: "003", dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: UIColor.red, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: true, tenthWhiteDegree: false, beltTimeLabel: "7 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: "7y", labelTenthDegreeTime: nil)

    static let redBelt = AdultBlackBelt(adultBlackBeltUID: "004", dateCreated: Date(), dateEdited: Date(), name: "Black Red Belt", active: true, elligibleForNextBelt: true, belt: UIColor.red, leftTeacherBar: UIColor.white, rightTeacherBar: UIColor.white, redBar: UIColor.red, coralBar: nil, firstWhiteDegree: true, secondWhiteDegree: true, thirdWhiteDegree: true, fourthWhiteDegree: true, fifthWhiteDegree: true, sixthWhiteDegree: true, seventhWhiteDegree: true, eigthWhiteDegree: true, ninthWhiteDegree: true, tenthWhiteDegree: true, beltTimeLabel: "7 years", labelFirstDegreeTime: "3y", labelSecondDegreeTime: "3y", labelThirdDegreeTime: "5y", labelFourthDegreeTime: "5y", labelFifthDegreeTime: "5y", labelSixthDegreeTime: "5y", labelSeventhDegreeTime: "5y", labelEigthDegreeTime: "5y", labelNinthDegreeTime: "7y", labelTenthDegreeTime: "7y")

    static var blackBelts = [blackBelt, redBlackBelt, redWhiteBelt, redBelt]

    // kids belts

    static let kidsWhiteBelt = KidsBelt(kidsBeltUID: "001", dateCreated: Date(), dateEdited: Date(), name: "White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.white, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: false, thirdRedStripe: false, fourthRedStripe: false, firstBlackStripe: false, secondBlackStripe: false, thirdBlackStripe: false, beltTimeLabel: "6 months", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: nil, labelThirdRedStripe: nil, labelFourthRedStripe: nil, labelFirstBlackStripe: nil, labelSecondBlackStripe: nil, labelThirdBlackStripe: nil)

    static let grayWhiteBelt = KidsBelt(kidsBeltUID: "002", dateCreated: Date(), dateEdited: Date(), name: "Gray White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let grayBelt = KidsBelt(kidsBeltUID: "003", dateCreated: Date(), dateEdited: Date(), name: "Gray Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let grayBlackBelt = KidsBelt(kidsBeltUID: "004", dateCreated: Date(), dateEdited: Date(), name: "Gray Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.gray, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let yellowWhiteBelt = KidsBelt(kidsBeltUID: "005", dateCreated: Date(), dateEdited: Date(), name: "Yellow White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let yellowBelt = KidsBelt(kidsBeltUID: "006", dateCreated: Date(), dateEdited: Date(), name: "Yellow Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let yellowBlackBelt = KidsBelt(kidsBeltUID: "007", dateCreated: Date(), dateEdited: Date(), name: "Yellow Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.yellow, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let orangeWhiteBelt = KidsBelt(kidsBeltUID: "008", dateCreated: Date(), dateEdited: Date(), name: "Orange White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let orangeBelt = KidsBelt(kidsBeltUID: "009", dateCreated: Date(), dateEdited: Date(), name: "Orange Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let orangeBlackBelt = KidsBelt(kidsBeltUID: "010", dateCreated: Date(), dateEdited: Date(), name: "Ornge Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.orange, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let greenWhiteBelt = KidsBelt(kidsBeltUID: "011", dateCreated: Date(), dateEdited: Date(), name: "Green White Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: UIColor.white, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let greenBelt = KidsBelt(kidsBeltUID: "012", dateCreated: Date(), dateEdited: Date(), name: "Green Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: nil, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static let greenBlackBelt = KidsBelt(kidsBeltUID: "013", dateCreated: Date(), dateEdited: Date(), name: "Green Black Belt", active: true, elligibleForNextBelt: true, belt: UIColor.green, beltCenterRibbonView: UIColor.black, blackBar: UIColor.black, firstWhiteStripe: true, secondWhiteStripe: true, thirdWhiteStripe: true, fourthWhiteStripe: true, firstRedStripe: true, secondRedStripe: true, thirdRedStripe: true, fourthRedStripe: true, firstBlackStripe: true, secondBlackStripe: true, thirdBlackStripe: true, beltTimeLabel: "1y", labelFirstWhiteStripe: "1m", labelSecondWhiteStripe: "1m", labelThirdWhiteStripe: "1m", labelFourthWhiteStripe: "1m", labelFirstRedStripe: "1m", labelSecondRedStripe: "1m", labelThirdRedStripe: "1m", labelFourthRedStripe: "1m", labelFirstBlackStripe: "1m", labelSecondBlackStripe: "1m", labelThirdBlackStripe: "1m")

    static var kidsBelts = [kidsWhiteBelt, grayWhiteBelt, grayBelt, grayBlackBelt, yellowWhiteBelt, yellowBelt, yellowBlackBelt, orangeWhiteBelt, orangeBelt, orangeBlackBelt, greenWhiteBelt, greenBelt, greenBlackBelt]

}




























