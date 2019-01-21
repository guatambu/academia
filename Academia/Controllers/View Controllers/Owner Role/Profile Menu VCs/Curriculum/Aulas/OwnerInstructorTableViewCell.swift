//
//  OwnerInstructorTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class OwnerInstructorTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var isChosen = false
    
    let beltBuilder = BeltBuilder()
    
    weak var delegate: InstructorsDelegate?
    
    // tableViewCell cell contents
    @IBOutlet weak var roundProfilePicView: DesignableView!
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var ownerInstructor: Owner? {
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
        guard let ownerInstructor = ownerInstructor else {
            print("ERROR: nil value found while attepting to unwrap optional adultStudent in AdultStudentTableViewCell.swift -> profilePicTapped - line 57.")
            return
        }
        
        guard var ownerInstructors = delegate?.ownerInstructors else {
            
            print("ERRORL: nil value found while trying to unwrap adultMembers array via delegate in AdultStudentTableViewCell.swift -> profilePicTapped() - line 63")
            return
        }
        
        if isChosen {
            ownerInstructors.append(ownerInstructor)
            delegate?.ownerInstructors = ownerInstructors
            print("ownerInstructors: \(String(describing: delegate?.ownerInstructors))")
            
        } else {
            delegate?.ownerInstructors = (delegate?.ownerInstructors.filter({ $0 != ownerInstructor })) ?? []
        }
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        guard let ownerInstructor = ownerInstructor else {
            print("ERROR: nil value found while attepting to unwrap optional adultStudent in AdultStudentTableViewCell.swift -> profilePicTapped - line 84.")
            return
        }
        
        userThumbnailImageViewOutlet.image = ownerInstructor.profilePic
        cellTitleOutlet.text = "\(ownerInstructor.firstName) \(ownerInstructor.lastName)"
    }
    
}
