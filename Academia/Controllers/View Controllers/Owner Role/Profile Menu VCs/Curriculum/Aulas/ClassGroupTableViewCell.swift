//
//  ClassGroupTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/25/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class ClassGroupTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isChosen = false
    
    @IBOutlet weak var groupSelectionButtonOutlet: UIButton!
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
    @IBOutlet weak var redArrowImage: UIImageView!
    
    weak var delegate: ClassGroupDelegate?
    
    var group: Group? {
        didSet {
            updateViews()
        }
    }
    
    var groupCD: GroupCD? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func groupSelectionButtonTapped(_ sender: UIButton) {
        
        // toggle isChosen Boolean value
        isChosen = !isChosen
        
//        guard let group = group else {
//            print("ERROR: nil value found while attepting to unwrap optional group in ClassGroupTableViewCell.swift -> groupSelectionButtonTapped(sender:) - line 33.")
//            return
//        }
        
        guard let groupCD = groupCD else {
            print("ERROR: nil value found while attepting to unwrap optional groupCD in ClassGroupTableViewCell.swift -> groupSelectionButtonTapped(sender:) - line 33.")
            return
        }
        
        // toggle groupSelectionButtonOutlet.isSelected property
        if isChosen {
            groupSelectionButtonOutlet.isSelected = true
        } else {
            groupSelectionButtonOutlet.isSelected = false
        }
        
        // append/remove group from array
        addGroup(groupCD: groupCD)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpButtons()
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
//        guard let group = group else {
//            print("ERROR: nil value found while attepting to unwrap optional group in ClassGroupTableViewCell.swift -> updateViews() - line 56.")
//            return
//        }
//
//        groupNameLabelOutlet.text = "\(group.name)"
        
        // CoreData version
        guard let groupCD = groupCD else {
            print("ERROR: nil value found while attempting to unwrap optional groupCD in ClassGroupTableViewCell.swift -> updateViews() - line 56.")
            return
        }
        
        groupNameLabelOutlet.text = "\(groupCD.name ?? "")"
        
        // when inEditingMode = true for ClassInstrcuctorsTVC, toggle roundProfilePicView borderColor
        if isChosen {
            groupSelectionButtonOutlet.isSelected = true
        } else {
            groupSelectionButtonOutlet.isSelected = false
        }
    }


    // MARK: - Helper Methods
    
    func setUpButtons() {
        let normalImage = UIImage(named: "unchecked_box_100.png")
        let selectedImage = UIImage(named: "checked_box_100.png")
        
        groupSelectionButtonOutlet.setImage(normalImage, for: .normal)
        groupSelectionButtonOutlet.setImage(selectedImage, for: .selected)
    }
    
    func addGroup(groupCD: GroupCD?) {
        
//        guard let group = group else {
//            print("ERROR: nil value found while attepting to unwrap optional group in ClassGroupTableViewCell.swift -> addGroup(group:) - line 77.")
//            return
//        }
//
//        guard var classGroups = delegate?.classGroups else {
//
//            print("ERRORL: nil value found while trying to unwrap delegate?.classGroups array via delegate in ClassGroupTableViewCell.swift -> addGroup(group:) - line 83")
//            return
//        }
//
//        if classGroups.contains(group) {
//
//            delegate?.classGroups = classGroups.filter({ $0 != group })
//
//            print("\(String(describing: delegate?.classGroups))")
//
//        } else {
//
//            classGroups.append(group)
//
//            delegate?.classGroups = classGroups
//
//            print("\(String(describing: delegate?.classGroups))")
//        }
        
        // CoreData version
        guard let groupCD = groupCD else {
            print("ERROR: nil value found while attepting to unwrap optional groupCD in ClassGroupTableViewCell.swift -> addGroup(group:) - line 127.")
            return
        }
        
        guard var classGroupsCD = delegate?.classGroupsCD else {
            
            print("ERRORL: nil value found while trying to unwrap delegate?.classGroupsCD array via delegate in ClassGroupTableViewCell.swift -> addGroup(group:) - line 83")
            return
        }
        
        if classGroupsCD.contains(groupCD) {
            
            delegate?.classGroupsCD = classGroupsCD.filter({ $0 != groupCD })
            
            print("\(String(describing: delegate?.classGroupsCD))")
            
        } else {
            
            classGroupsCD.append(groupCD)
            
            delegate?.classGroupsCD = classGroupsCD
            
            print("\(String(describing: delegate?.classGroupsCD))")
        }
    }

}
