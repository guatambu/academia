//
//  AdultStudentTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/7/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultStudentTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var isChosen = false
    
    let beltBuilder = BeltBuilder()
    
    weak var delegate: GroupMembersDelegate?
    
    // tableViewCell cell contents
    @IBOutlet weak var roundProfilePicView: DesignableView!
    @IBOutlet weak var userThumbnailImageViewOutlet: UIImageView!
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
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
    
    
    // MARK: - Actions
    @IBAction func profilePicTapped(_ sender: UIButton) {
        
        // toggle isChosen Boolean value
        isChosen = !isChosen
        
        print(isChosen)
        
        // add/remove student to appropriate model controller's source of truth
        
        guard let studentAdultCD = studentAdultCD else {
            print("ERROR: nil value found while attepting to unwrap optional adultStudentCD in AdultStudentTableViewCell.swift -> profilePicTapped() - line 53.")
            return
        }
        
        guard var adultMembersCD = delegate?.adultMembersCD else {
            
            print("ERRORL: nil value found while trying to unwrap adultMembersCD array via delegate in AdultStudentTableViewCell.swift -> profilePicTapped() - line 59.")
            return
        }
        
        // toggle roundProfilePicView borderColor
        if isChosen {
            
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
            
            // CoreData version
            print("AdultStudentTableViewCell -> adultMembersCD BEFORE new addition: \(adultMembersCD)")
            adultMembersCD.append(studentAdultCD)
            print("AdultStudentTableViewCell -> adultMembersCD AFTER new addition: \(adultMembersCD)")
            delegate?.adultMembersCD = adultMembersCD
            print("delegate.adultMembersCD AFTER new addition: \(String(describing: delegate?.adultMembersCD))")
            
        } else {
            
            roundProfilePicView.borderColor = UIColor.clear
            
            // CoreData version
            delegate!.adultMembersCD = delegate!.adultMembersCD.filter({ $0 != studentAdultCD })
        }
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        // CoreData verison
        guard let studentAdultCD = studentAdultCD else {
            print("ERROR: nil value found while attepting to unwrap optional studentAdultCD in AdultStudentTableViewCell.swift -> updateViews() - line 91.")
            return
        }
        
        if let profilePicData = studentAdultCD.profilePic {
            
            userThumbnailImageViewOutlet.image = UIImage(data: profilePicData)
        }
        if let firstName = studentAdultCD.firstName, let lastName = studentAdultCD.lastName {
            cellTitleOutlet.text = "\(firstName) \(lastName)"
        }
        
        // if inEditingMode == true and this student is present in groupToEdit.kidMembers array, we should see the propfile pic selected
        if isChosen {
            roundProfilePicView.borderColor = beltBuilder.redBeltRed
        }
    }
    
}

