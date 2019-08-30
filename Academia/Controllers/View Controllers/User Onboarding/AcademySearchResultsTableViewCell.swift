//
//  AcademySearchResultsTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/16/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

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
    
    var locationPic: UIImage? {
        didSet {
            updateImageView()
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
            
            print("failed to unwrap a location object in AcademySearchResultsTableViewCell.swift -> updateViews()")
            
            return
        }
        // populate cell UI elements
        cellTitleOutlet.text = "\(location.locationName)"
        cellTeacherNameOutlet.text = "\(location.ownerName)"
        cellSubtitleOutlet.text = "\(location.city), \(location.state) \(location.zipCode)"
    }
    
    func updateImageView() {
        
        guard let locationPic = locationPic else {
            
            print("failed to unwrap a locationPic in AcademySearchResultsTableViewCell.swift -> updateImageView()")
            
            return
        }
        // populate cell UIImageView
        locationThumbnailImageView.image = locationPic
    }
}
