//
//  TypeCollectionViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// TODO: set up delegate and necessary protocol and pass that around to PAymentProgramBillingDetailsVC so i can pass info around from this cell's button actions to host VC

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var billingType: Billing.BillingType? {
        didSet {
            updateViews()
        }
    }
    
    let beltBuilder = BeltBuilder()
    
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
            print("ERROR:  nil value for billingType in TypeCollectionViewCell.swift -> updateViews() - line 73")
            return
        }
            
        billingDetailsLabel.text = billingType.rawValue
        checkboxImageView.image = uncheckedBox32
        collectionCellView.layer.borderWidth = 1
        collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
        collectionCellView.layer.cornerRadius = 10
        
        guard let billingTypes = delegate?.billingTypes else {
            print("ERROR:  nil value for billingTypes in TypeCollectionViewCell.swift -> updateViews() - line 83")
            return
        }
    
        if billingTypes.contains(billingType) {
    
        checkboxImageView.image = checkedBox32
    
        } else {
    
        checkboxImageView.image = uncheckedBox32
    
        }
    
        print("cell: \(billingType.rawValue) \nbillingTypes: \(billingTypes)")
        
    }
    
    
    // MARK: Actions
    
    @IBAction func typeSelectionButtonTapped(_ sender: DesignableButton) {
        
        guard let billingType = billingType else {
            print("ERROR:  nil value for billingType in TypeCollectionViewCell.swift -> typeSelectionButtonTapped() - line 85")
            return
        }
        
        guard var billingTypes = delegate?.billingTypes else {
            print("ERROR:  nil value for billingTypes in TypeCollectionViewCell.swift -> typeSelectionButtonTapped() - line 90")
            return
        }
        
        if billingTypes.contains(billingType) {
            
            checkboxImageView.image = uncheckedBox32
                
            delegate?.billingTypes = billingTypes.filter({ $0 != billingType })
            
            print("\(String(describing: delegate?.billingTypes))")
            
        } else {
            
            checkboxImageView.image = checkedBox32
            
            billingTypes.append(billingType)
            
            delegate?.billingTypes = billingTypes
            
            print("\(String(describing: delegate?.billingTypes))")

        }
    }
    
}
