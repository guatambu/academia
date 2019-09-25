//
//  LocationsImageMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

class LocationsImageMenuTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var locationThumbnailImageView: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
//    var location: Location? {
//        didSet {
//            updateViews()
//        }
//    }
    
    var location: LocationFirestore? {
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
        
        guard let location = location else {
            print("failed to unwrap a location object in LocationImageMenuTVCell")
//            print("how many locations we got in location source of truth: \(LocationModelController.shared.locations.count)")
            
            return
        }
        
        guard let locationThumbnailImageView = locationThumbnailImageView else { return }
        
        print("LocationsImageMenuTVCell location object name: \(location.locationName)")
        
//        // populate cell UI elements
//        locationThumbnailImageView.image = UIImage(data: locationPicData)
        cellTitleOutlet.text = "\(location.locationName)"
        // Placeholder image
        let placeholderImage = UIImage(named: "profile_pic_placeholder_image.png")
        // convert location URL String to URL
        let url = URL(string: location.profilePicStorageURL)
        // profile pic imageView Load the image using SDWebImage
        locationThumbnailImageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: [], completed: nil)
    }
}
