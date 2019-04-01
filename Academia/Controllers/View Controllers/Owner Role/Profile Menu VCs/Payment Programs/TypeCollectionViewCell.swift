//
//  TypeCollectionViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var billingType: Billing.BillingType? {
        didSet {
            updateViews()
        }
    }
    
    let beltBuilder = BeltBuilder()
    
    var selectedBillingTypes: [Billing.BillingType]?
    
    let uncheckedBox32 = UIImage(named: "unchecked_box_32")
    let checkedBox32 = UIImage(named: "checked_box_32")
    
    weak var delegate: BillingTypeDelegate?
    
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var billingDetailsLabel: UILabel!
    @IBOutlet weak var isSelectedButtonOutlet: DesignableButton!
    
    
    // MARK: - updateViews()
    func updateViews() {
        
        guard let billingType = billingType else {
            print("ERROR:  nil value for billingType in TypeCollectionViewCell.swift -> updateViews() - line 42")
            return
        }
            
        billingDetailsLabel.text = billingType.rawValue
        checkboxImageView.image = uncheckedBox32
        collectionCellView.layer.borderWidth = 1
        collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
        collectionCellView.layer.cornerRadius = 10
        
        // NOTE: this may have something to do with asynchronous threads 
            
        guard let billingTypes = delegate?.billingTypes else {
            print("ERROR:  nil value for billingTypes in TypeCollectionViewCell.swift -> updateViews() - line 55")
            return
        }
        
        if billingTypes.contains(billingType) {
            
            checkboxImageView.image = checkedBox32
            
        } else {
            
            checkboxImageView.image = uncheckedBox32
            
        }
        
    }
    
    
    // MARK: Actions
    
    @IBAction func typeSelectionButtonTapped(_ sender: DesignableButton) {
        
        guard let billingType = billingType else {
            print("ERROR:  nil value for billingType in TypeCollectionViewCell.swift -> typeSelectionButtonTapped() - line 77")
            return
        }
        
        guard var billingTypes = delegate?.billingTypes else {
            print("ERROR:  nil value for billingTypes in TypeCollectionViewCell.swift -> typeSelectionButtonTapped() - line 82")
            return
        }
        
        if billingTypes.contains(billingType) {
            
            checkboxImageView.image = uncheckedBox32
                
            delegate?.billingTypes = billingTypes.filter({ $0 != billingType })
            
            print("in TypeCollectionCell.swift - delegate.billingTypes: \(String(describing: delegate?.billingTypes))")
            
        } else {
            
            checkboxImageView.image = checkedBox32
            
            billingTypes.append(billingType)
            
            delegate?.billingTypes = billingTypes
            
            print("in TypeCollectionCell.swift - delegate.billingTypes: \(String(describing: delegate?.billingTypes))")

        }
    }
}
