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
    var userUID: String? {
        
        didSet {
            getLocationPic()
        }
    }
    
    var location: LocationFirestore? {
        didSet {
            updateViews()
        }
    }
    
    var locationName: String?
    
    
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
        
        locationName = location.locationName
        
        print("LocationsImageMenuTVCell location object name: \(locationName ?? "")")
        
//        // populate cell UI elements
//        locationThumbnailImageView.image = UIImage(data: locationPicData)
        
        cellTitleOutlet.text = "\(location.locationName)"
    }
    
    func getLocationPic() {
        
        guard let userUID = userUID else {
            
            print("failed to unwrap a userUID in LocationImageMenuTVCell")
            
            return
            
        }
        
        if let locationName = locationName {
            
            let locationPicStorgaeRef = Storage.storage().reference().child("profilePics/locations/").child("\(userUID)").child("\(locationName)")
            
            // Placeholder image
            let placeholderImage = UIImage(named: "profile_pic_placeholder_image.png")
            
            // profile pic imageView Load the image using SDWebImage
            locationThumbnailImageView.sd_setImage(with: locationPicStorgaeRef, placeholderImage: placeholderImage)
        }
    }
}
