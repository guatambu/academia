//
//  KidGroupInfoDetailsTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class KidGroupInfoDetailsTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var kidStudent: KidStudent? {
        didSet {
            updateViews()
        }
    }
    
    var studentKidCD: StudentKidCD? {
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
        guard let studentKidCD = studentKidCD else {
            print("ERROR: nil value found while attepting to unwrap optional kidStudentCD in KidGroupInfoDetailsTableViewCell.swift -> updateViews() - line 59.")
            return
        }
        
        if let profilePicData = studentKidCD.profilePic {
            
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        if let firstName = studentKidCD.firstName, let lastName = studentKidCD.lastName {
            cellTitleOutlet.text = "\(firstName) \(lastName)"
        }
    }
}
