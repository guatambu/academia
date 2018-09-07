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

    var user: User? {
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
        
        if let user = user {
            userThumbnailImageViewOutlet.image = user.profilePic
            cellTitleOutlet.text = "\(user.firstName) \(user.lastName)"
        } else if let location = location {
            userThumbnailImageViewOutlet.image = location.profilePic
            cellTitleOutlet.text = "\(location.locationName)"
        }
    }


}
