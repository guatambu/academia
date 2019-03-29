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
        
        print("classGroupsCD array contents at load of cell: \(String(describing: delegate?.classGroupsCD))")
    }


    // MARK: - Helper Methods
    
    func setUpButtons() {
        let normalImage = UIImage(named: "unchecked_box_100.png")
        let selectedImage = UIImage(named: "checked_box_100.png")
        
        groupSelectionButtonOutlet.setImage(normalImage, for: .normal)
        groupSelectionButtonOutlet.setImage(selectedImage, for: .selected)
    }
    
    func addGroup(groupCD: GroupCD) {
        
        // CoreData version
        
        guard var classGroupsCD = delegate?.classGroupsCD else {
            
            print("ERRORL: nil value found while trying to unwrap delegate?.classGroupsCD array via delegate in ClassGroupTableViewCell.swift -> addGroup(group:) - line 83")
            return
        }
        print("classGroupsCD array contents: \(classGroupsCD)")
        // check to see if the selected group is in the classGroupsCD array
        if classGroupsCD.contains(groupCD) {
            // if it DOES, then we toggle to remove it by filtering out the array for all the contents that do not match the groupCD property
            delegate?.classGroupsCD = classGroupsCD.filter({ $0 != groupCD })
            
            print("classGroupsCD array: \(String(describing: delegate?.classGroupsCD))")
            
        } else {
            // if the classsGroupsCD array does NOT contain the groupCD object, then we append it to the classGroupsCD array.
            classGroupsCD.append(groupCD)
            // set the delgate array property equal to the classGRoupsCD array
            delegate?.classGroupsCD = classGroupsCD
            
            print("classGroupsCD array: \(String(describing: delegate?.classGroupsCD))")
        }
    }

}
