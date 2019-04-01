//
//  ReviewInstructorTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ReviewInstructorTableViewCell: UITableViewCell {

    // MARK: - Properties

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
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
//        guard let instructor = instructor else {
//            print("ERROR: nil value found while attepting to unwrap optional adultStudent in AdultStudentTableViewCell.swift -> updateViews() - line 42.")
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
    }
}

