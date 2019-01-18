//
//  TimeOfDayCollectionViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/17/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class TimeOfDayCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var timeOfDay: ClassTimeComponents.Hours? {
        didSet {
            updateViews()
        }
    }
    
    let beltBuilder = BeltBuilder()
    
    //    var inEditingMode = false
    var selectedTimesOfDay: [ClassTimeComponents.Hours]?
    
    
    let uncheckedBox32 = UIImage(named: "unchecked_box_32")
    let checkedBox32 = UIImage(named: "checked_box_32")
    
    weak var delegate: TimeOfDayDelegate?
    
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var timeOfDayLabelOutlet: UILabel!
    @IBOutlet weak var isSelectedButtonOutlet: DesignableButton!
    
    
    // MARK: - updateViews()
    func updateViews() {
        
        guard let timeOfDay = timeOfDay else {
            print("ERROR:  nil value for timeOfDay in TimeOfDayCollectionViewCell.swift -> updateViews() - line 42")
            return
        }
        
        timeOfDayLabelOutlet.text = "\(timeOfDay.rawValue)"
        checkboxImageView.image = uncheckedBox32
        collectionCellView.layer.borderWidth = 1
        collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
        collectionCellView.layer.cornerRadius = 10
        
        // NOTE: this may have something to do with asynchronous threads
        
        guard let times = delegate?.times else {
            print("ERROR:  nil value for times in TimeOfDayCollectionViewCell.swift -> updateViews() - line 55")
            return
        }
        
        if times.contains("\(timeOfDay.rawValue)") {
            
            checkboxImageView.image = checkedBox32
            
        } else {
            
            checkboxImageView.image = uncheckedBox32
            
        }
        
    }
    
    
    // MARK: Actions
    
    @IBAction func timeOfDaySelectionButtonTapped(_ sender: DesignableButton) {
        
        guard let timeOfDay = timeOfDay else {
            print("ERROR:  nil value for timeOfDay in TimeOfDayCollectionViewCell.swift -> timeOfDaySelectionButtonTapped() - line 77")
            return
        }
        
        guard var times = delegate?.times else {
            print("ERROR:  nil value for times in TimeOfDayCollectionViewCell.swift -> timeOfDaySelectionButtonTapped() - line 82")
            return
        }
        
        if times.contains("\(timeOfDay.rawValue)") {
            
            checkboxImageView.image = uncheckedBox32
            
            delegate?.times = times.filter({ $0 != "\(timeOfDay.rawValue)" })
            
            print("\(String(describing: delegate?.times))")
            
        } else {
            
            checkboxImageView.image = checkedBox32
            
            times.append("\(timeOfDay.rawValue)")
            
            delegate?.times = times
            
            print("\(String(describing: delegate?.times))")
            
        }
    }
    
}

