//
//  AgreementTextViewTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AgreementTextViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var agreementTextViewOutlet: UITextView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
