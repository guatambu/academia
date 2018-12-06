//
//  AddNewStudentGroupImageMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddNewStudentGroupImageMenuTableViewCell: UITableViewCell {

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
    
    var location: Location? {
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
        } else if let location = location {
            userThumbnailImageViewOutlet.image = location.locationPic
            cellTitleOutlet.text = "\(location.locationName)"
        }
    }

}
