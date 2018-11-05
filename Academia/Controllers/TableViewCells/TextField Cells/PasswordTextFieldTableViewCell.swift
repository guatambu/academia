//
//  PasswordTextFieldTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PasswordTextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        passwordTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "", attributes: avenirFont)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
