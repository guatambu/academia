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
    
    var ownerInstructorCD: OwnerCD? {
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
        
        // CoreData version
        guard let ownerInstructorCD = ownerInstructorCD else {
            print("ERROR: nil value found while attepting to unwrap ownerInstructor in InstructorTableViewCell.swift -> profilePicTapped - line 86.")
            return
        }
        
        guard var ownerInstructorsCD = delegate?.ownerInstructorsCD else {
            
            print("ERRORL: nil value found while trying to unwrap ownerInstructors array via delegate in InstructorTableViewCell.swift -> profilePicTapped() - line 92")
            return
        }
        
        if isChosen {
            ownerInstructorsCD.append(ownerInstructorCD)
            delegate?.ownerInstructorsCD = ownerInstructorsCD
            print("instructorss: \(String(describing: delegate?.ownerInstructorsCD))")
            
        } else {
            delegate?.ownerInstructorsCD = delegate?.ownerInstructorsCD.filter({ $0 != ownerInstructorCD }) ?? []
        }
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        // CoreData version
        guard let ownerInstructorCD = ownerInstructorCD else {
            print("ERROR: nil value found while attepting to unwrap optional ownerInstructorCD in OwnerInstructorTableViewCell.swift -> updateViews() - line 121.")
            return
        }
        
        if let profilePicData = ownerInstructorCD.profilePic {
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        cellTitleOutlet.text = "\(ownerInstructorCD.firstName ?? "") \(ownerInstructorCD.lastName ?? "")"
        
        // when inEditingMode = true for ClassInstrcuctorsTVC, toggle roundProfilePicView borderColor
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        } else {
            roundProfilePicView.borderColor = UIColor.clear
        }
    }
    
}
