//
//  ReviewKidStudentTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class ReviewKidStudentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var kidStudentCD: StudentKidCD? {
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
        
        guard let studentKidCD = kidStudentCD  else {
            
            print("ERROR: nil value found when unwrapping kidStudentCD in ReviewKidStudentTableViewCell.swift -> updateViews() - line 40")
            
            return
        }
        
        if let profilePicData = studentKidCD.profilePic {
            
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        if let firstName = studentKidCD.firstName, let lastName = studentKidCD.lastName {
            cellTitleOutlet.text = "\(firstName) \(lastName)"
        }
    }
    
}
