//
//  GroupMembersDelegate.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

// MARK: - AddStudentToGroupTVC to KidStudent... and AdultStudentTableViewCell Delegate protocol to access TVC's kidMembers and adultMembers array properties both regular and CoreData versions
protocol GroupMembersDelegate: class {
    var kidMembers: [KidStudent] { get set }
    var adultMembers: [AdultStudent] { get set }
    var kidMembersCD: [StudentKidCD] { get set }
    var adultMembersCD: [StudentAdultCD] { get set }
}
