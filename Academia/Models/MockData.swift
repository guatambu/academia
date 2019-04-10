//
//  MockData.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/5/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

struct MockData {

    // for demo accounts for TestFlight purposes
    

    // groups
    // CoreData
    static var allStudentsCD = GroupCD(active: true, name: "all students", groupDescription: "a group for all the people enrolled in the academy")
    
    // classes
    // CoreData
    static var adultsClass1 = AulaCD(active: true, aulaName: "adults 1", aulaDescription: "fundamentals class for adults", dayOfTheWeek: "Monday", time: "7:00 pm", timeCode: 10700, location: headquarters)

    // location
    // CoreData
    static var hqAddress = AddressCD(addressLine1: "123 street rd.", addressLine2: "suite 34", city: "gainsville", state: "WY", zipCode: "10293")
    
    static var hqLinks = LocationSocialLinksCD(socialLink1: "instagramLink", socialLink2: "facebookLink", socialLink3: "twitterLink")
    
    static var headquarters = LocationCD(locationPic: nil, locationName: "hq", phone: "(323) 543-9876", website: "wwww.academywebsite.com", email: "info@academywebsite.com", address: hqAddress, socialLinks: hqLinks, aula: nil)
    
    // payment programs
    // CoreData
    static var adultsProgram = PaymentProgramCD(active: true, dateCreated: Date(), dateEdited: Date(), programName: "adults", paymentDescription: "a program for adults", paymentAgreement: "adults program agreement")
    
    // users
    // CoreData
    
    // owner
    static var blackBeltCD = BeltCD(beltLevel: "black belt", beltPromotionAttendanceCriteria: nil, beltStripeAgeDetails: nil, classesToNextPromotion: nil, numberOfStripes: 1)
    
    static var ownerAddress = AddressCD(addressLine1: "321 owner st.", addressLine2: nil, city: "ownerville", state: "CA", zipCode: "91839")
    
    static var ownerEmergencyContact = EmergencyContactCD(name: "marge owner", phone: "(323) 123-0987", relationship: "significant other")
    
    static var ownerCD = OwnerCD(birthdate: Date(), mostRecentPromotion: nil, studentStatus: nil, belt: blackBeltCD, profilePic: nil, username: "owner", password: "owner", firstName: "jim", lastName: "owner", address: ownerAddress, phone: "(323) 123-7654", mobile: "(323) 555-1212", email: "owner@academywebiste.com", emergencyContact: ownerEmergencyContact)

    // adultA
    static var blueBeltCD = BeltCD(beltLevel: "blue belt", beltPromotionAttendanceCriteria: nil, beltStripeAgeDetails: nil, classesToNextPromotion: nil, numberOfStripes: 2)
    
    static var adultAAddress = AddressCD(addressLine1: "456 student st.", addressLine2: nil, city: "ownerville", state: "CA", zipCode: "91839")
    
    static var adultEmergencyContact = EmergencyContactCD(name: "betty student", phone: "(323) 098-5678", relationship: "significant other")
    
    static var adultA = StudentAdultCD(isInstructor: false, dateCreated: Date(), dateEdited: Date(), birthdate: Date(), studentStatus: nil, belt: blueBeltCD, profilePic: nil, username: "studentA", password: "studentA", firstName: "larry", lastName: "student", address: adultAAddress, phone: "(323) 345-6789)", mobile: "(323 945-0987)", email: "adultA@myemail.com", emergencyContact: adultEmergencyContact)
    
    // kidA
    static var grayBeltCD = BeltCD(beltLevel: "gray belt", beltPromotionAttendanceCriteria: nil, beltStripeAgeDetails: nil, classesToNextPromotion: nil, numberOfStripes: 6)
    
    static var kidAAddress = AddressCD(addressLine1: "456 kiddos blvd.", addressLine2: nil, city: "ownerville", state: "CA", zipCode: "91839")
    
    static var kidEmergencyContact = EmergencyContactCD(name: "susan kid", phone: "(323) 789-5674", relationship: "mother")
    
    static var kidA = StudentKidCD(dateCreated: Date(), dateEdited: Date(), birthdate: Date(), studentStatus: nil, belt: grayBeltCD, profilePic: nil, username: "kidA", password: "kidA", firstName: "daniel", lastName: "kid", parentGuardian: "susan kid", address: kidAAddress, phone: "(323) 678-1234", mobile: "(323) 432-9876", email: "mom@email.com", emergencyContact: kidEmergencyContact)
  

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




























