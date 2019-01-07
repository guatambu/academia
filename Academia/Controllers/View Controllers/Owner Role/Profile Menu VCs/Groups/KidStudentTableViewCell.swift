//
//  KidStudentTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// TODO: figure out why the ERROR is occurring in console for the delegate (see  console)

import UIKit

class KidStudentTableViewCell: UITableViewCell {

    // MARK: - Properties

    var isChosen = false
    
    let beltBuilder = BeltBuilder()
    
    weak var delegate: GroupMembersDelegate?
    
    // tableViewCell cell contents
    @IBOutlet weak var roundProfilePicView: DesignableView!
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
    
    
    // MARK: - Actions
    @IBAction func profilePicTapped(_ sender: UIButton) {
        
        // toggle isChosen Boolean value
        isChosen = !isChosen
        
        // toggle roundProfilePicView borderColor
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        } else {
            roundProfilePicView.borderColor = UIColor.clear
        }

        // add/remove student to appropriate model controller's source of truth
        guard let kidStudent = kidStudent else {
            print("ERROR: nil value found while attepting to unwrap optional kidStudent in KidStudentTableViewCell.swift -> profilePicTapped() - line 57.")
            return
        }
        
        guard var kidMembers = delegate?.kidMembers else {
            
            print("ERRORL: nil value found while trying to unwrap kidMembers array via delegate in KidStudentTableViewCell.swift -> profilePicTapped() - line 65")
            return
        }
            
        if isChosen {
            kidMembers.append(kidStudent)
            delegate?.kidMembers? = kidMembers
            print("kidMembers: \(String(describing: delegate?.kidMembers))")
            
        } else {
            delegate?.kidMembers = delegate?.kidMembers?.filter({ $0 != kidStudent })
        }
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        guard let kidStudent = kidStudent else {
            print("ERROR: nil value found while attepting to unwrap optional adultStudent in KidStudentTableViewCell.swift -> updateViews() - line 85.")
            return
        }
        
        userThumbnailImageViewOutlet.image = kidStudent.profilePic
        cellTitleOutlet.text = "\(kidStudent.firstName) \(kidStudent.lastName)"
    }

}
