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
    
    
    // MARK: - Actions
    @IBAction func profilePicTapped(_ sender: UIButton) {
        
        // toggle isChosen Boolean value
        isChosen = !isChosen
        
        print(isChosen)
        
        // add/remove student to appropriate model controller's source of truth
        guard let kidStudent = kidStudent else {
            print("ERROR: nil value found while attepting to unwrap optional kidStudent in KidStudentTableViewCell.swift -> profilePicTapped() - line 59.")
            return
        }
        
        guard var kidMembers = delegate?.kidMembers else {
            
            print("ERRORL: nil value found while trying to unwrap kidMembers array via delegate in KidStudentTableViewCell.swift -> profilePicTapped() - line 65")
            return
        }
        
        guard let studentKidCD = studentKidCD else {
            print("ERROR: nil value found while attepting to unwrap optional kidStudentCD in KidStudentTableViewCell.swift -> profilePicTapped() - line 71.")
            return
        }
        
        guard var kidMembersCD = delegate?.kidMembersCD else {
            
            print("ERRORL: nil value found while trying to unwrap kidMembersCD array via delegate in KidStudentTableViewCell.swift -> profilePicTapped() - line 77")
            return
        }
        
        // toggle roundProfilePicView borderColor
        if isChosen {
            
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
            print("kidMembers: \(kidMembers)")
            kidMembers.append(kidStudent)
            print("kidMembers: \(kidMembers)")
            delegate?.kidMembers = kidMembers
            print("delegate kidMembers: \(String(describing: delegate?.kidMembers))")
            
            // CoreData version
            print("kidMembersCD: \(kidMembersCD)")
            kidMembersCD.append(studentKidCD)
            print("kidMembersCD: \(kidMembersCD)")
            delegate?.kidMembersCD = kidMembersCD
            print("delegate kidMembersCD: \(String(describing: delegate?.kidMembersCD))")

        } else {
            
            roundProfilePicView.borderColor = UIColor.clear
            delegate!.kidMembers = delegate!.kidMembers.filter({ $0 != kidStudent })
            
            // CoreData version
            delegate!.kidMembersCD = delegate!.kidMembersCD.filter({ $0 != studentKidCD })
        }
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
//        guard let kidStudent = kidStudent else {
//            print("ERROR: nil value found while attepting to unwrap optional kidStudent in KidStudentTableViewCell.swift -> updateViews() - line 93.")
//            return
//        }
        
        
//        userThumbnailImageViewOutlet.image = kidStudent.profilePic
//        cellTitleOutlet.text = "\(kidStudent.firstName) \(kidStudent.lastName)"
        
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
        
        // if inEditingMode == true and this student is present in groupToEdit.kidMembers array, we should see the propfile pic selected
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        }
    }

}
