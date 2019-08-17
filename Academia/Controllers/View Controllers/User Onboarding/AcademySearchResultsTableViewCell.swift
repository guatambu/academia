//
//  AcademySearchResultsTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/16/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class AcademySearchResultsTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var locationThumbnailImageView: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var cellTeacherNameOutlet: UILabel!
    @IBOutlet weak var cellSubtitleOutlet: UILabel!
    
    var locationFirestore: LocationFirestore? {
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
        
        guard let location = locationFirestore else {
            print("failed to unwrap a location object in LocationImageMenuTVCell")
            print("how many locations we got in location source of truth: \(LocationModelController.shared.locations.count)")
            
            return
        }
        guard let locationPicData = location.locationPic else {
            print("ERROR: nil value found for locationPic in LocationsImageMenuTableViewCell.swift -> updateViews() - line 53.")
            return
        }
        
        print("LocationsImageMenuTVCell location object name: \(location.locationName)")
        
        // populate cell UI elements
        locationThumbnailImageView.image = UIImage(named: locationPicData)
        cellTitleOutlet.text = "\(location.locationName)"
        cellTeacherNameOutlet.text = "\(location.ownerName)"
        cellSubtitleOutlet.text = "\(location.address.city), \(location.address.state) \(location.address.zipCode)"
    }

}
