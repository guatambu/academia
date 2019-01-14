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
    }
    
}
