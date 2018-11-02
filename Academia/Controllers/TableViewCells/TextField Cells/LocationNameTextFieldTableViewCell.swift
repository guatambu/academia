//
//  LocationNameTextFieldTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 8/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationNameTextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var locationNameTextFieldOutlet: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        locationNameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "", attributes: avenirFont)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
