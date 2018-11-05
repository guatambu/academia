//
//  ConfirmPasswordTextFieldTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davison 11/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ConfirmPasswordTextFieldTableViewCell: UITableViewCell, UITextInputTraits {
    
    // MARK: - Properties
    
    @IBOutlet weak var confirmPasswordLabelOutlet: UILabel!
    @IBOutlet weak var confirmPasswordTextFieldOutlet: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        confirmPasswordTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "", attributes: avenirFont)
        
        // turns of autocorrect in this UITextField
        confirmPasswordTextFieldOutlet.autocorrectionType = UITextAutocorrectionType.no
        // turns off auto-capitaization in this UITextfield
        confirmPasswordTextFieldOutlet.autocapitalizationType = UITextAutocapitalizationType.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
