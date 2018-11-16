//
//  BeltTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/16/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // belt holder UIView
    @IBOutlet weak var beltHolderView: UIView!
    // UILabels
    @IBOutlet weak var beltLabelOutlet: UILabel!
    @IBOutlet weak var ageRequirementLabelOutlet: UILabel!
    @IBOutlet weak var stripeALabelOutlet: UILabel!
    @IBOutlet weak var stripeBLabelOutlet: UILabel!
    @IBOutlet weak var stripeCLabelOutlet: UILabel!
    @IBOutlet weak var stripeDLabelOutlet: UILabel!
    @IBOutlet weak var stripeELabelOutlet: UILabel!
    @IBOutlet weak var stripeFLabelOutlet: UILabel!
    
    
    // MARK: - awakeFromNib()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

}
