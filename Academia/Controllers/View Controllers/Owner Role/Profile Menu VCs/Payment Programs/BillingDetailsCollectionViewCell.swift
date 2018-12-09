//
//  BillingDetailsCollectionViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BillingDetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var billingDetailTitle: String? {
        didSet {
            updateLabelViews()
        }
    }
    
    var checkboxChecked: Bool? {
        didSet {
            updateCheckBoxValue()
        }
    }
    
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var billingDetailsLabel: UILabel!
    
    
    // MARK: - updateLabelViews()
    func updateLabelViews() {
        
    }
    
    // MARK: - updateCheckBoxValue
    func updateCheckBoxValue() {
        
    }
}
