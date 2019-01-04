//
//  AddNewStudentGroupImageMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

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
        
        print("incoming isChosen value: \(isChosen)")
        
        // toggle isChosen Boolean value
        isChosen = !isChosen
        
        print("changed isChosen value: \(isChosen)")
        
        // toggle roundProfilePicView borderColor
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        } else {
            roundProfilePicView.borderColor = UIColor.clear
        }
        
        // add/remove student to appropriate model controller's source of truth
        if let adultStudent = adultStudent {
            
            guard var adultMembers = delegate?.adultMembers else {
                print("ERROR:  nil value for adultMembers in AddNewStudentGroupImageMenuTableViewCell.swift -> profilePicTapped(_ sender: ) - line 68")
                return
            }
            
            if isChosen {
                adultMembers.append(adultStudent)
                
            } else {
                guard let index = adultMembers.index(of: adultStudent) else {
                    print("ERROR: no index value found for adultStudent in adultMembers. AddNewStudentGroupImageMenuTableViewCell -> profilePicTapped(_ sender:) - line 77")
                    return
                }
                adultMembers.remove(at: index)
            }
            
            
        } else if let kidStudent = kidStudent {
            
            guard var kidMembers = delegate?.kidMembers else {
                print("ERROR:  nil value for kidMembers in AddNewStudentGroupImageMenuTableViewCell.swift -> profilePicTapped(_ sender: ) - line 87")
                return
            }
            
            if isChosen {
                kidMembers.append(kidStudent)
                
            } else {
                guard let index = kidMembers.index(of: kidStudent) else {
                    print("ERROR: no index value found for kidStudent in kidMembers. AddNewStudentGroupImageMenuTableViewCell -> profilePicTapped(_ sender:) - line 96")
                    return
                }
                kidMembers.remove(at: index)
            }
        }
        
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
