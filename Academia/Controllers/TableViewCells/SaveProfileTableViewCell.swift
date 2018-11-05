//
//  SaveProfileTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class SaveProfileTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: SegueFromSaveProfileNibCellDelegate!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    
    @IBAction func saveProfileButtonTapped(_ sender: UIButton) {
        
        var profileData = "replace with profile object data when time comes"
        if(self.delegate != nil){
            self.delegate.callSegueFromNibCell(nibCellData: profileData as AnyObject)
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
