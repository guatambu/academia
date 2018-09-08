//
//  DescriptionTextViewTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 9/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class DescriptionTextViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var descriptionOutlet: UILabel!
    @IBOutlet weak var descriptionTextViewOutlet: UITextView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
