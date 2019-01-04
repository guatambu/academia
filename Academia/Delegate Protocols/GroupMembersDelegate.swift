//
//  GroupMembersDelegate.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

// MARK: - AddStudentToGroupTVC to AddNewStudentGroupImageMenuTableViewCell Delegate protocol to access TVC's groupMembers array property
protocol GroupMembersDelegate: class {
    var kidMembers: [KidStudent] { get set }
    var adultMembers: [AdultStudent] { get set }
    
}
