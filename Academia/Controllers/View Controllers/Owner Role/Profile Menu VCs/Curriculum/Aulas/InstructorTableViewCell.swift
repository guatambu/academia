//
//  InstructorTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class InstructorTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var isChosen = false
    
    let beltBuilder = BeltBuilder()
    
    weak var delegate: InstructorsDelegate?
    
    // tableViewCell cell contents
    @IBOutlet weak var roundProfilePicView: DesignableView!
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var instructor: AdultStudent? {
        didSet {
            updateViews()
        }
    }
    
    var instructorCD: StudentAdultCD? {
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
        
//        guard let instructor = instructor else {
//            print("ERROR: nil value found while attepting to unwrap optional adultStudent in AdultStudentTableViewCell.swift -> profilePicTapped - line 57.")
//            return
//        }
//
//        guard var instructors = delegate?.instructors else {
//
//            print("ERRORL: nil value found while trying to unwrap adultMembers array via delegate in AdultStudentTableViewCell.swift -> profilePicTapped() - line 63")
//            return
//        }
//
//        if isChosen {
//            instructors.append(instructor)
//            delegate?.instructors = instructors
//            print("instructorss: \(String(describing: delegate?.instructors))")
//
//        } else {
//            delegate?.instructors = delegate?.instructors.filter({ $0 != instructor }) ?? []
//        }
        
        // CoreData version
        guard let instructorCD = instructorCD else {
            print("ERROR: nil value found while attepting to unwrap instructor in InstructorTableViewCell.swift -> profilePicTapped - line 86.")
            return
        }
        
        guard var instructorsCD = delegate?.instructorsCD else {
            
            print("ERRORL: nil value found while trying to unwrap instructors array via delegate in InstructorTableViewCell.swift -> profilePicTapped() - line 92")
            return
        }
        
        if isChosen {
            instructorsCD.append(instructorCD)
            delegate?.instructorsCD = instructorsCD
            print("instructorss: \(String(describing: delegate?.instructorsCD))")
            
        } else {
            delegate?.instructorsCD = delegate?.instructorsCD.filter({ $0 != instructorCD }) ?? []
        }
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
//        guard let instructor = instructor else {
//            print("ERROR: nil value found while attepting to unwrap optional adultStudent in AdultStudentTableViewCell.swift -> updateViews() - line 84.")
//            return
//        }
//
//        userThumbnailImageViewOutlet.image = instructor.profilePic
//        cellTitleOutlet.text = "\(instructor.firstName) \(instructor.lastName)"
        
        // CoreData version
        guard let instructorCD = instructorCD else {
            print("ERROR: nil value found while attepting to unwrap optional ownerInstructorCD in OwnerInstructorTableViewCell.swift -> updateViews() - line 121.")
            return
        }
        
        if let profilePicData = instructorCD.profilePic {
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        cellTitleOutlet.text = "\(instructorCD.firstName ?? "") \(instructorCD.lastName ?? "")"
        
        // when inEditingMode = true for ClassInstrcuctorsTVC, toggle roundProfilePicView borderColor
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        } else {
            roundProfilePicView.borderColor = UIColor.clear
        }
    }
    
}
