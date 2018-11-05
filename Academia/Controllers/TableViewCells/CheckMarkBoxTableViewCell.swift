//
//  CheckMarkBoxTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/9/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class CheckMarkBoxTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var messageOutlet: UILabel!
    @IBOutlet weak var checkboxButtonOutlet: UIButton!
    
    
    // MARK: - Actions / Gesture Recognizers
    
    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
