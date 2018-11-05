//
//  LocationsImageMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationsImageMenuTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var locationThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
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
        
        guard let location = location else { return }
        
        locationThumbnailImageViewOutlet.image = location.profilePic
        cellTitleOutlet.text = "\(location.locationName)"
        
    }


}
