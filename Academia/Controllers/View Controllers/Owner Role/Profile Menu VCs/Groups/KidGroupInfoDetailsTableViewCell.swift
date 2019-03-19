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
        
        guard let kidStudent = kidStudent  else {
            
            print("ERROR: nil value found when unwrapping kidStudent in ReviewKidStudentTableViewCell.swift -> updateViews() - line 40")
            
            return
        }
        
        cellTitleOutlet.text = "\(kidStudent.firstName) \(kidStudent.lastName)"
        userThumbnailImageViewOutlet.image = kidStudent.profilePic ?? UIImage(contentsOfFile: "user_placeholder")
        
        print("cell: \(kidStudent.firstName)")
        print("cell: \(String(describing: kidStudent.profilePic?.size))")
        
        
        // CoreData verison
        guard let studentKidCD = studentKidCD else {
            print("ERROR: nil value found while attepting to unwrap optional kidStudentCD in KidStudentTableViewCell.swift -> updateViews() - line 98.")
            return
        }
        
        if let profilePicData = studentKidCD.profilePic {
            
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        if let firstName = studentKidCD.firstName, let lastName = studentKidCD.lastName {
            cellTitleOutlet.text = "\(firstName) \(lastName)"
        }
        
        print("\(String(describing: studentKidCD.firstName))")
        
        if let profilePicData = studentKidCD.profilePic, let profilePic = UIImage(data: profilePicData) {
            print("\(profilePic.scale)")
        }
    }
}
