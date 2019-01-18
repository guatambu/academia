//
//  DateCollectionViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var billingDate: Billing.BillingDate? {
        didSet {
            updateViews()
        }
    }

    let beltBuilder = BeltBuilder()
 
    var selectedBillingDates: [Billing.BillingDate]?
    
    let uncheckedBox32 = UIImage(named: "unchecked_box_32")
    let checkedBox32 = UIImage(named: "checked_box_32")
    
    weak var delegate: BillingDateDelegate?
    
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var billingDetailsLabel: UILabel!
    @IBOutlet weak var isSelectedButtonOutlet: DesignableButton!
    
    
    
    // MARK: - updateViews()
    func updateViews() {
        
        guard let billingDate = billingDate else {
            print("ERROR:  nil value for billingDate in DateCollectionViewCell.swift -> updateViews() - line 44")
            return
        }
        
        billingDetailsLabel.text = billingDate.rawValue
        checkboxImageView.image = uncheckedBox32
        collectionCellView.layer.borderWidth = 1
        collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
        collectionCellView.layer.cornerRadius = 10
        
        guard let billingDates = delegate?.billingDates else {
            print("ERROR:  nil value for billingDates in DateCollectionViewCell.swift -> updateViews() - line 55")
            return
        }
        
        if billingDates.contains(billingDate) {
            
            checkboxImageView.image = checkedBox32
            
        } else {
            
            checkboxImageView.image = uncheckedBox32
            
        }

    }
    
    
    // MARK: Actions
    
    @IBAction func dateSelectionButtonTapped(_ sender: DesignableButton) {
        
        guard let billingDate = billingDate else {
            print("ERROR:  nil value for billingDate in DateCollectionViewCell.swift -> dateSelectionButtonTapped() - line 77")
            return
        }
        
        guard var billingDates = delegate?.billingDates else {
            print("ERROR:  nil value for billingDates in DateCollectionViewCell.swift -> dateSelectionButtonTapped() - line 82")
            return
        }
        
        if billingDates.contains(billingDate) {
            
            checkboxImageView.image = uncheckedBox32
            
            delegate?.billingDates = billingDates.filter({ $0 != billingDate })
            
            print("\(String(describing: delegate?.billingDates))")
            
        } else {
            
            checkboxImageView.image = checkedBox32
            
            billingDates.append(billingDate)
            
            delegate?.billingDates = billingDates
            
            print("\(String(describing: delegate?.billingDates))")
            
        }
    }
}
