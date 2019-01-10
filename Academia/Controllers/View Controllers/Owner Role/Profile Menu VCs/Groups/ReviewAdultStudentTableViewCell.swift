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
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        guard let adultStudent = adultStudent  else {
            
            print("ERROR: nil value found when unwrapping adultStudent in ReviewKidStudentTableViewCell.swift -> updateViews() - line 40")
            
            return
        }
        
        userThumbnailImageViewOutlet.image = adultStudent.profilePic
        cellTitleOutlet.text = "\(adultStudent.firstName) \(adultStudent.lastName)"
    }
}

