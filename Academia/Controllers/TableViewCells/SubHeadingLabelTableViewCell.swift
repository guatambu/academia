//
//  SubHeadingLabelTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/9/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class SubHeadingLabelTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    @IBOutlet weak var subHeadingOutlet: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
