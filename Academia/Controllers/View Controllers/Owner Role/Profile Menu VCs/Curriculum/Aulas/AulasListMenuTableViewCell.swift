//
//  AulasListMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AulasListMenuTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var aulaTimeLabelOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var aula: Aula? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        guard let aula = aula else {
            print("ERROR: nil value found for aula property in AulasListMenuTableViewCell.swift -> updateViews() - line 34")
            return
        }
        
        cellTitleOutlet.text = "\(aula.aulaName)"
        aulaTimeLabelOutlet.text = "\(aula.time ?? "")"
    }
}
