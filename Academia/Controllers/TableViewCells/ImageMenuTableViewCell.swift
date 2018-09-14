//
//  ImageMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ImageMenuTableViewCell: UITableViewCell {
    
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
        
        // check if the student is an adult
        guard let adultStudent = adultStudent else { return }
        userThumbnailImageViewOutlet.image = adultStudent.profilePic
        cellTitleOutlet.text = "\(adultStudent.firstName) \(adultStudent.lastName)"
        
        // check to see if the student is a kid
        guard let kidStudent = kidStudent else { return }
        userThumbnailImageViewOutlet.image = kidStudent.profilePic
        cellTitleOutlet.text = "\(kidStudent.firstName) \(kidStudent.lastName)"
        
        // check to see if the student is a location
        guard let location = location else { return }
        userThumbnailImageViewOutlet.image = location.profilePic
        cellTitleOutlet.text = "\(location.locationName)"
    }
}
