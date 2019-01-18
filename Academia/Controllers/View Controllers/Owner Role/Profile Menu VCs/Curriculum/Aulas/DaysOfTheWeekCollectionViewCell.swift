//
//  DaysOfTheWeekCollectionViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 1/17/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class DaysOfTheWeekCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var day: ClassTimeComponents.Weekdays? {
        didSet {
            updateViews()
        }
    }
    
    let beltBuilder = BeltBuilder()
    
    //    var inEditingMode = false
    var selectedDaysOfTheWeek: [ClassTimeComponents.Weekdays]?
    
    
    let uncheckedBox32 = UIImage(named: "unchecked_box_32")
    let checkedBox32 = UIImage(named: "checked_box_32")
    
    weak var delegate: DaysOfTheWeekDelegate?
    
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var daysOfTheWeekLabelOutlet: UILabel!
    @IBOutlet weak var isSelectedButtonOutlet: DesignableButton!
    
    
    // MARK: - updateViews()
    func updateViews() {
        
        guard let day = day else {
            print("ERROR:  nil value for day in DayOfTheWeekCollectionViewCell.swift -> updateViews() - line 42")
            return
        }
        
        daysOfTheWeekLabelOutlet.text = day.rawValue
        checkboxImageView.image = uncheckedBox32
        collectionCellView.layer.borderWidth = 1
        collectionCellView.layer.borderColor = beltBuilder.grayBeltGray.cgColor
        collectionCellView.layer.cornerRadius = 10
        
        // NOTE: this may have something to do with asynchronous threads
        
        guard let days = delegate?.daysOfTheWeek else {
            print("ERROR:  nil value for days in DaysOfTheWeekCollectionViewCell.swift -> updateViews() - line 55")
            return
        }
        
        if days.contains(day) {
            
            checkboxImageView.image = checkedBox32
            
        } else {
            
            checkboxImageView.image = uncheckedBox32
            
        }
        
    }
    
    
    // MARK: Actions
    
    @IBAction func daySelectionButtonTapped(_ sender: DesignableButton) {
        
        guard let day = day else {
            print("ERROR:  nil value for day in DaysOfTheWeekCollectionViewCell.swift -> daySelectionButtonTapped() - line 77")
            return
        }
        
        guard var days = delegate?.daysOfTheWeek else {
            print("ERROR:  nil value for billingTypes in TypeCollectionViewCell.swift -> typeSelectionButtonTapped() - line 82")
            return
        }
        
        if days.contains(day) {
            
            checkboxImageView.image = uncheckedBox32
            
            delegate?.daysOfTheWeek = days.filter({ $0 != day })
            
            print("\(String(describing: delegate?.daysOfTheWeek))")
            
        } else {
            
            checkboxImageView.image = checkedBox32
            
            days.append(day)
            
            delegate?.daysOfTheWeek = days
            
            print("\(String(describing: delegate?.daysOfTheWeek))")
            
        }
    }
    
}
