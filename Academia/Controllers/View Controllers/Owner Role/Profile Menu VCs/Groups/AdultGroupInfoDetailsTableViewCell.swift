//
//  AdultGroupInfoDetailsTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultGroupInfoDetailsTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var adultStudent: AdultStudent? {
        didSet {
            updateViews()
        }
    }
    
    var studentAdultCD: StudentAdultCD? {
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

        // CoreData verison
        guard let studentAdultCD = studentAdultCD else {
            print("ERROR: nil value found while attepting to unwrap optional kidStudentCD in AdultGroupInfoDetailsTableViewCell.swift -> updateViews() - line 56.")
            return
        }
        
        if let profilePicData = studentAdultCD.profilePic {
            
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        if let firstName = studentAdultCD.firstName, let lastName = studentAdultCD.lastName {
            cellTitleOutlet.text = "\(firstName) \(lastName)"
        }
    }
}

