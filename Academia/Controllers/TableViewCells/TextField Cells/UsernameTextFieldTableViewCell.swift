//
//  UsernameTextFieldTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 8/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class UsernameTextFieldTableViewCell: UITableViewCell, UITextInputTraits {
    
    // MARK: - Properties
    
    @IBOutlet weak var usernameTextFieldOutlet: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        usernameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "", attributes: avenirFont)
        
        // turns of autocorrect in this UITextField
        usernameTextFieldOutlet.autocorrectionType = UITextAutocorrectionType.no
        // turns off auto-capitaization in this UITextfield
        usernameTextFieldOutlet.autocapitalizationType = UITextAutocapitalizationType.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
