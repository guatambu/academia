//
//  LocationCollectionViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/17/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var location: Location? {
        didSet {
            updateViews()
        }
    }
    
    let beltBuilder = BeltBuilder()
    
    //    var inEditingMode = false
    var locations: [Location]?
    
    
    let uncheckedBox32 = UIImage(named: "unchecked_box_32")
    let checkedBox32 = UIImage(named: "checked_box_32")
    
    weak var delegate: AulaLocationDelegate?
    
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var locationLabelOutlet: UILabel!
    @IBOutlet weak var isSelectedButtonOutlet: DesignableButton!
    
    
    // MARK: - updateViews()
    func updateViews() {
        
        guard let location = location else {
            print("ERROR:  nil value for location in LocationCollectionViewCell.swift -> updateViews() - line 42")
            return
        }
        
        locationLabelOutlet.text = location.locationName
        checkboxImageView.image = uncheckedBox32
        collectionCellView.layer.borderWidth = 1
        collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
        collectionCellView.layer.cornerRadius = 10
        
        // NOTE: this may have something to do with asynchronous threads
        
        guard let locations = delegate?.locations else {
            print("ERROR:  nil value for location in LocationCollectionViewCell.swift -> updateViews() - line 55")
            return
        }
        
        if locations.contains(location) {
            
            checkboxImageView.image = checkedBox32
            
        } else {
            
            checkboxImageView.image = uncheckedBox32
            
        }
        
    }
    
    
    // MARK: Actions
    
    @IBAction func locationSelectionButtonTapped(_ sender: DesignableButton) {
        
        guard let location = location else {
            print("ERROR:  nil value for location in LocationCollectionViewCell.swift -> locationSelectionButtonTapped() - line 77")
            return
        }
        
        guard var locations = delegate?.locations else {
            print("ERROR:  nil value for billingTypes in TypeCollectionViewCell.swift -> typeSelectionButtonTapped() - line 78")
            return
        }
        
        if locations.contains(location) {
            
            checkboxImageView.image = uncheckedBox32
            
            delegate?.locations = locations.filter({ $0 != location })
            
            print("\(String(describing: delegate?.locations))")
            
        } else {
            
            checkboxImageView.image = checkedBox32
            
            locations.append(location)
            
            delegate?.locations = locations
            
            print("\(String(describing: delegate?.locations))")
            
        }
    }
    
}

