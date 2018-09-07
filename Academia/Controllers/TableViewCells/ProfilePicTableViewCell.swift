//
//  ProfilePicTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ProfilePicTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    
    
    // MARK: - Actions
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        
        
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
