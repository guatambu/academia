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
    
    var billingType: Billing.BillingType? {
        didSet {
            updateViews()
        }
    }
    
    var billingDate: Billing.BillingDate? {
        didSet {
            updateViews()
        }
    }
    
    var signatureType: Billing.BillingSignature? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var billingDetailsLabel: UILabel!
    
    
    // MARK: - updateViews()
    func updateViews() {
        if let billingType = billingType {
            billingDetailsLabel.text = billingType.rawValue
        }
        
        if let billingDate = billingDate {
            billingDetailsLabel.text = billingDate.rawValue
        }
        
        if let signatureType = signatureType {
            billingDetailsLabel.text = signatureType.rawValue
        }
    }
}
