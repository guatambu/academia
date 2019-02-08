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
        
        guard let aula = aula else { return }
        
        cellTitleOutlet.text = aula.aulaName
        
        guard let times = aula.time else { return }
        cellSubtitleOutlet.text = "\(times):00"
        
    }
}
