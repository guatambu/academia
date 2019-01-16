//
//  AdultStudentTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/7/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultStudentTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var isChosen = false
    
    let beltBuilder = BeltBuilder()
    
    weak var delegate: GroupMembersDelegate?
    
    // tableViewCell cell contents
    @IBOutlet weak var roundProfilePicView: DesignableView!
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var adultStudent: AdultStudent? {
        didSet {
            updateViews()
        }
    }
    

    // MARK: - awakeFromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - Actions
    @IBAction func profilePicTapped(_ sender: UIButton) {
        
        // toggle isChosen Boolean value
        isChosen = !isChosen
        
        // toggle roundProfilePicView borderColor
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        } else {
            roundProfilePicView.borderColor = UIColor.clear
        }
        
        // add/remove student to appropriate model controller's source of truth
        guard let adultStudent = adultStudent else {
            print("ERROR: nil value found while attepting to unwrap optional adultStudent in AdultStudentTableViewCell.swift -> profilePicTapped - line 57.")
            return
        }
            
        guard var adultMembers = delegate?.adultMembers else {
                
            print("ERRORL: nil value found while trying to unwrap adultMembers array via delegate in AdultStudentTableViewCell.swift -> profilePicTapped() - line 63")
            return
        }
        
        if isChosen {
            
            adultMembers.append(adultStudent)
            delegate?.adultMembers = adultMembers

            print("adultMembers: \(String(describing: delegate?.adultMembers))")
            
        } else {
            
            delegate?.adultMembers = adultMembers.filter({ $0 != adultStudent })
        }
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        guard let adultStudent = adultStudent else {
            print("ERROR: nil value found while attepting to unwrap optional adultStudent in AdultStudentTableViewCell.swift -> profilePicTapped - line 84.")
            return
        }

        userThumbnailImageViewOutlet.image = adultStudent.profilePic
        cellTitleOutlet.text = "\(adultStudent.firstName) \(adultStudent.lastName)"
        
        // if inEditingMode == true and this student is present in groupToEdit.adultMembers array, we should see the propfile pic selected
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        }
    }
    
}

