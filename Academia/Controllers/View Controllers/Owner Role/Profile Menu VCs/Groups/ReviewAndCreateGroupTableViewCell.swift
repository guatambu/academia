//
//  ReviewAndCreateGroupTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class ReviewAndCreateGroupTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var adultStudent: AdultStudent? {
        didSet {
            updateViews()
        }
    }
    
    var kidStudent: KidStudent? {
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
        
        if let adultStudent = adultStudent {
            userThumbnailImageViewOutlet.image = adultStudent.profilePic
            cellTitleOutlet.text = "\(adultStudent.firstName) \(adultStudent.lastName)"
        } else if let kidStudent = kidStudent {
            userThumbnailImageViewOutlet.image = kidStudent.profilePic
            cellTitleOutlet.text = "\(kidStudent.firstName) \(kidStudent.lastName)"
        }
    }
    
}
