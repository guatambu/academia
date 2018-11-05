//
//  MyCells.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

enum MyCells: String {
    // cell cases where String contains capital letter(s) represent cells that will most likely NOT display the raw value string to users.  will be used for dev informational purposes
    case profilePicCell = "Profile Pic"
    case beltCell = "Belt Cell"
    case statusCell = "Status"
    case isInstructorCell = "Instructor?"
    case isKidCell = "In Kids Program?"
    case saveProfileButtonCell = "Save Profile"
    case onBoardingDashboardCell = "Dashboard"
    case generalMenuCell = "General Menu"
    case digitalSignatureCell = "Digital Signature"
    case imageMenuCell = "Image Menu"
    case headingLabelCell = "Heading"
    case subHeadingLabelCell = "Subheading"
    case checkmarkBoxCell = "Checkmark Box"
    case spacerCell = "Spacer Cell"
    
    // cell cases where strings are all lowercase represent raw values that may be presented to the user
    case birthdateCell = "tap to enter date of birth"
    case usernameCell = "tap to enter username"
    case firstNameCell = "tap to enter first name"
    case lastNameCell = "tap to enter last name"
    case streetAddressCell = "tap to enter street address"
    case cityCell = "tap to enter city"
    case stateCell = "tap to enter state"
    case zipCodeCell = "tap to enter zip code"
    case phoneCell = "tap to enter phone"
    case mobileCell = "tap to enter mobile"
    case emailCell = "tap to enter email"
    case parentGuardianCell = "tap to enter parent/guardian"
    case paymentProgramCell = "tap to enter payment program"
    case schoolGroupsCell = "tap to enter school group"
    case emergencyContactCell = "tap to enter emergency contact"
    case emergencyContactPhoneCell = "tap to enter emergency phone number"
    case emergencyContactRelationshipCell = "tap to enter relationship with emergency contact"
    case locationNameCell = "tap to enter a location name"
    case websiteCell = "tap to enter a website"
    case socialNetworksCell = "tap to enter social networks"
    case agreementTextViewCell = "tap to enter program agreement"
    case descriptionTextViewCell = "tap to enter program description"
    
}
































