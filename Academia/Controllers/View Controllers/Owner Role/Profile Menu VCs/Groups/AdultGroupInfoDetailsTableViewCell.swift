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
        
        guard let adultStudent = adultStudent  else {
            
            print("ERROR: nil value found when unwrapping adultStudent in ReviewKidStudentTableViewCell.swift -> updateViews() - line 40")
            
            return
        }
        
        userThumbnailImageViewOutlet.image = adultStudent.profilePic
        cellTitleOutlet.text = "\(adultStudent.firstName) \(adultStudent.lastName)"
        
        // CoreData verison
        guard let studentAdultCD = studentAdultCD else {
            print("ERROR: nil value found while attepting to unwrap optional kidStudentCD in KidStudentTableViewCell.swift -> updateViews() - line 98.")
            return
        }
        
        if let profilePicData = studentAdultCD.profilePic {
            
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        if let firstName = studentAdultCD.firstName, let lastName = studentAdultCD.lastName {
            cellTitleOutlet.text = "\(firstName) \(lastName)"
        }
        
        print("\(String(describing: studentAdultCD.firstName))")
        
        if let profilePicData = studentAdultCD.profilePic, let profilePic = UIImage(data: profilePicData) {
            print("\(profilePic.scale)")
        }
    }
}

