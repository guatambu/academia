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
            if isChosen {
                AdultStudentModelController.shared.adults.append(adultStudent)
                
            } else {
                guard let index = AdultStudentModelController.shared.adults.index(of: adultStudent) else {
                    print("ERROR: no index value found for adultStudent in AdultStudentModelController.shared.adults.  AddNewStudentGroupImageMenuTableViewCell -> profilePicTapped(_ sender:) - line 62")
                    return
                }
                AdultStudentModelController.shared.adults.remove(at: index)
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
