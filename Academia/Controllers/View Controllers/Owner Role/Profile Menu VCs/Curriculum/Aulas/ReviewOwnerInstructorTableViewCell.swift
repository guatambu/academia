//
//  ReviewOwnerInstructorTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ReviewOwnerInstructorTableViewCell: UITableViewCell {

    
    // MARK: - Properties
    
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
    }
}

