//
//  SignatureCollectionViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class SignatureCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties

    var signatureType: Billing.BillingSignature? {
        didSet {
            updateViews()
        }
    }
    
    var isSignatureCurrentlySelected = false
    
    let beltBuilder = BeltBuilder()
    
//    var inEditingMode: Bool?
    var selectedSignatureTypes: [Billing.BillingSignature]?
    
    let uncheckedBox32 = UIImage(named: "unchecked_box_32")
    let checkedBox32 = UIImage(named: "checked_box_32")
    
    weak var delegate: SignatureTypeDelegate?
    
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var billingDetailsLabel: UILabel!
    @IBOutlet weak var isSelectedButtonOutlet: DesignableButton!
    
    
    
    // MARK: - updateViews()
    func updateViews() {
        
        guard let signatureType = signatureType else {
            print("ERROR:  nil value for signatureType in SignatureCollectionViewCell.swift -> updateViews() - line 44")
            return
        }
        
        billingDetailsLabel.text = signatureType.rawValue
        checkboxImageView.image = uncheckedBox32
        collectionCellView.layer.borderWidth = 1
        collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
        collectionCellView.layer.cornerRadius = 10
        
        guard let signatureTypes = delegate?.signatureTypes else {
            print("ERROR:  nil value for signatureTypes in SignatureCollectionViewCell.swift -> updateViews() - line 55")
            return
        }
        
        if signatureTypes.contains(signatureType) {
            
            checkboxImageView.image = checkedBox32
            
        } else {
            
            checkboxImageView.image = uncheckedBox32
            
        }
        
    }
    
    
    // MARK: Actions
    
    @IBAction func signatureSelectionButtonTapped(_ sender: DesignableButton) {
        
        guard let signatureType = signatureType else {
            print("ERROR:  nil value for signatureType in SignatureCollectionViewCell.swift -> signatureSelectionButtonTapped() - line 77")
            return
        }
        
        guard var signatureTypes = delegate?.signatureTypes else {
            print("ERROR:  nil value for billingTypes in SignatureCollectionViewCell.swift -> signatureSelectionButtonTapped() - line 82")
            return
        }
        
        if signatureTypes.contains(signatureType) {
            
            checkboxImageView.image = uncheckedBox32
            
            delegate?.signatureTypes = signatureTypes.filter({ $0 != signatureType })
            
            print("\(String(describing: delegate?.signatureTypes))")
            
        } else {
            
            checkboxImageView.image = checkedBox32
            
            signatureTypes.append(signatureType)
            
            delegate?.signatureTypes = signatureTypes
            
            print("\(String(describing: delegate?.signatureTypes))")
            
        }
    }

}
