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
    
    static var allStudents = Group(active: true, name: "all students", dateCreated: Date(), dateEdited: Date(), members: [owner, adultA])
    
    // location

    static var myLocation = Location(active: true, dateCreated: Date(), dateEdited: Date(), profilePic: #imageLiteral(resourceName: "download.jpg"), locationName: "my location", streetAddress: "1267 the spot blvd.", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social: nil)

    // payment programs

    static var programA: PaymentProgram = PaymentProgram(active: true, programName: "programA", dateCreated: Date(), dateEdited: Date(), billingType: ["digital"], billingOptions: ["1st of month"], paymentDescription: "things", paymentAgreement: "stuff", signatureType: ["digital"])
    
    // classes

    static let adultClassA: Aula = Aula(active: true, className: "adult A", daysOfTheWeek: [Aula.Weekdays.Monday, Aula.Weekdays.Wednesday, Aula.Weekdays.Friday], timeOfDay: [Aula.ClassTimes.nineteen], location: myLocation, students: [adultA], instructor: [adultA], currentDate: Date(), dateCreated: Date(), dateEdited: Date(), attendees: [adultA])

    // users

    static var owner: Owner = Owner(isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, groups: nil, permission: UserPermissions.owner, adultBasicBelt: nil, blackBelt: blackBelt, profilePic: #imageLiteral(resourceName: "download.jpg"), username: "owner", firstName: "steve", lastName: "meister", streetAddress: "1234 street dr.", city: "coolville", state: "CA", zipCode: "93421", phone: "(523) 763-0961", mobile: "(312) 736-7843", email: "my@email.com")
    
    static var adultA: AdultStudent = AdultStudent(isInstructor: true, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), promotions: nil, mostRecentPromotion: nil, attendance: nil, studentStatus: [StudentStatus.active, StudentStatus.paid], groups: nil, paymentProgram: programA, permission: [UserPermissions.instructor, UserPermissions.adultStudent], adultBasicBelt: purpleBelt, blackBelt: nil, profilePic: #imageLiteral(resourceName: "academia_sample_profile_pic.jpeg"), username: "adultA", firstName: "dan", lastName: "cnakle", streetAddress: "123 my street blvd.", city: "theTown", state: "CA", zipCode: "92346", phone: "123-987-0980", mobile: "098-865-1234", email: "adult@email.com", emergencyContact: "margie", emergencyContactPhone: "858-098-1234", emergencyContactRelationship: "wife")

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




























