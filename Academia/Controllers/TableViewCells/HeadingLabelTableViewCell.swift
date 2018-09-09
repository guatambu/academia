//
//  HeadingLabelTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 9/9/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class HeadingLabelTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var headingOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
