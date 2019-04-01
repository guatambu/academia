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
    
    @IBOutlet weak var locationThumbnailImageView: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
//    var location: Location? {
//        didSet {
//            updateViews()
//        }
//    }
    
    var location: LocationCD? {
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
            print("how many locations we got in location source of truth: \(LocationModelController.shared.locations.count)")
            
            return
        }
        guard let locationPicData = location.locationPic else {
            print("ERROR: nil value found for locationPic in LocationsImageMenuTableViewCell.swift -> updateViews() - line 53.")
            return
        }
        guard let locationName = location.locationName else {
            print("ERROR: nil value found for locationName in LocationsImageMenuTableViewCell.swift -> updateViews() - line 55.")
            return
        }
        
        print("LocationsImageMenuTVCell location object name: \(locationName)")
        
        // populate cell UI elements
        locationThumbnailImageView.image = UIImage(data: locationPicData)
        cellTitleOutlet.text = "\(locationName)"
        
    }


}
