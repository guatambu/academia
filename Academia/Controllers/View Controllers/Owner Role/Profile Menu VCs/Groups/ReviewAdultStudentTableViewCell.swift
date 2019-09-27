//
//  ReviewAdultStudentTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/7/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class ReviewAdultStudentTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var adultStudentCD: StudentAdultCD? {
        didSet {
            updateViews()
        }
    }
    
    var adultStudentFirestore: AdultStudentFirestore? {
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
        
        guard let studentAdultCD = adultStudentCD  else {
            
            print("ERROR: nil value found when unwrapping adultStudentCD in ReviewAdultStudentTableViewCell.swift -> updateViews() - line 40")
            
            return
        }
        
        if let profilePicData = studentAdultCD.profilePic {
            
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        if let firstName = studentAdultCD.firstName, let lastName = studentAdultCD.lastName {
            cellTitleOutlet.text = "\(firstName) \(lastName)"
        }
    }
}

