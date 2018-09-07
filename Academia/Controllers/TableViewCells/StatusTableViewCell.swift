//
//  StatusTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 8/31/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var statusLabelOutlet: UILabel!
    @IBOutlet weak var detailLabelOutlet: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
