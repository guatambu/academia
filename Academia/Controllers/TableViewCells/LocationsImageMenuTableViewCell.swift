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
        
        guard let location = location else {
            print("failed to unwrap a location object in LocationImageMenuTVCell")
            print("how many locations we got in location source of truth: \(LocationModelController.shared.locations.count)")
            
            return
        }
        print("LocationsImageMenuTVCell location object: \(location)")
        
        locationThumbnailImageViewOutlet.image = location.locationPic
        cellTitleOutlet.text = "\(location.locationName)"
        
    }


}
