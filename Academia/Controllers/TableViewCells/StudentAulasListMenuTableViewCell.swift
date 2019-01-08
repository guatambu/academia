//
//  StudentAulasListMenuTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentAulasListMenuTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var cellSubtitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var cell: Aula? {
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
        guard let cell = cell else { return }
        
        cellTitleOutlet.text = cell.aulaName
        cellSubtitleOutlet.text = "\(cell.timeOfDay):00"
        
    }
}
