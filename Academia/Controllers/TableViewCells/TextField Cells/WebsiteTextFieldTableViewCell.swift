//
//  WebsiteTextFieldTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 8/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class WebsiteTextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var websiteTextFieldOutlet: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        websiteTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "", attributes: avenirFont)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
