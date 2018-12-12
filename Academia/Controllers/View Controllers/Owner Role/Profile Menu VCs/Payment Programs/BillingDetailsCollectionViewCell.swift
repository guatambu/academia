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
    
    let beltBuilder = BeltBuilder()
    
    let uncheckedBox32 = UIImage(named: "unchecked_checkbox_32.png")
    let uncheckedBox50 = UIImage(named: "unchecked_checkbox_50.png")
    let checkedBox32 = UIImage(named: "checked_tickbox_32.png")
    let checkedBox50 = UIImage(named: "checked_tickbox_50.png")
    
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var billingDetailsLabel: UILabel!
    
    
    // MARK: - updateViews()
    func updateViews() {
        if let billingType = billingType {
            billingDetailsLabel.text = billingType.rawValue
            checkboxImageView.image = uncheckedBox32
            collectionCellView.layer.borderWidth = 1
            collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
            collectionCellView.layer.cornerRadius = 10
        }
        
        if let billingDate = billingDate {
            billingDetailsLabel.text = billingDate.rawValue
            checkboxImageView.image = uncheckedBox32
            checkboxImageView.image = uncheckedBox32
            collectionCellView.layer.borderWidth = 1
            collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
            collectionCellView.layer.cornerRadius = 10
        }
        
        if let signatureType = signatureType {
            billingDetailsLabel.text = signatureType.rawValue
            checkboxImageView.image = uncheckedBox32
            checkboxImageView.image = uncheckedBox32
            collectionCellView.layer.borderWidth = 1
            collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
            collectionCellView.layer.cornerRadius = 10
        }
    }
}
