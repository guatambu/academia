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
            
            guard var groupMembers = delegate?.groupMembers else {
                print("ERROR:  nil value for groupMembers in AddNewStudentGroupImageMenuTableViewCell.swift -> profilePicTapped(_ sender: ) - line 69")
                return
            }
            
            if isChosen {
                
                
                groupMembers.append(adultStudent)
                
                // maybe need to 6create more specific type arrays rather than [Any] ... more like a [KidStudent] and [AdultStudent]... or maybe better a protocol to link them all together like a macro Student protocol and make a [Student]? array for groupMembers rather than [Any]?
                
                // Solution to ^^^ ... two separate arrays, one for AdultStudents and one for KidStudents, and these will be used to keep the groupMembers array organized for secitons.  in other words the groupMembers array will just be an array of arrays that will be used to track the sections for the overall displayed data which we will always organize into adults and kids sections when displayed in tableView or collecitonView format
                
            } else {
                guard let index = groupMembers.index(of: adultStudent) else {
                    print("ERROR: no index value found for adultStudent in AdultStudentModelController.shared.adults.  AddNewStudentGroupImageMenuTableViewCell -> profilePicTapped(_ sender:) - line 62")
                    return
                }
                groupMembers.remove(at: index)
            }
            
            
        } else if let kidStudent = kidStudent {
            if isChosen {
                KidStudentModelController.shared.kids.append(kidStudent)
                
            } else {
                guard let index = KidStudentModelController.shared.kids.index(of: kidStudent) else {
                    print("ERROR: no index value found for adultStudent in AdultStudentModelController.shared.adults.  AddNewStudentGroupImageMenuTableViewCell -> profilePicTapped(_ sender:) - line 62")
                    return
                }
                KidStudentModelController.shared.kids.remove(at: index)
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
