//
//  ClassGroupDelegate.swift
//  Academia
//
//  Created by Michael GUatambu Davis on 1/25/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

// MARK: - ClassGroupTVC.swift to ClassGroupTableViewCell.swift Delegate protocol to access TVC's classGroups array properties
protocol ClassGroupDelegate: class {
    var classGroups: [Group] { get set }
}

