//
//  AddNewStudentGroupImageMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// TODO: figure out why the ERROR is occurring in console for the delegate (see  console)

import UIKit

class AddNewStudentGroupImageMenuTableViewCell: UITableViewCell {

    // MARK: - Properties

    var isChosen = false
    
    let beltBuilder = BeltBuilder()
    
    weak var delegate: GroupMembersDelegate?
    
    @IBOutlet weak var roundProfilePicView: DesignableView!
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var adultStudent: AdultStudent? {
        didSet {
            updateViews()
        }
    }
    
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
        if let adultStudent = adultStudent {
            
            if isChosen {
                delegate?.adultMembers?.append(adultStudent)
                
            } else {
                delegate?.adultMembers = delegate?.adultMembers?.filter({ $0 != adultStudent })
            }
            
            
        } else if let kidStudent = kidStudent {
            
            if isChosen {
                delegate?.kidMembers?.append(kidStudent)
                
                
            } else {
                delegate?.kidMembers = delegate?.kidMembers?.filter({ $0 != kidStudent })
            }
        }
        
        print(delegate?.adultMembers ?? "unwrapping of delegate.adultMmebers fails with nil value")
        print(delegate?.kidMembers ?? "unwrapping of delegate.kidMmebers fails with nil value")
        
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        if let adultStudent = adultStudent {
            userThumbnailImageViewOutlet.image = adultStudent.profilePic
            cellTitleOutlet.text = "\(adultStudent.firstName) \(adultStudent.lastName)"
        } else if let kidStudent = kidStudent {
            userThumbnailImageViewOutlet.image = kidStudent.profilePic
            cellTitleOutlet.text = "\(kidStudent.firstName) \(kidStudent.lastName)"
        }
    }

}
