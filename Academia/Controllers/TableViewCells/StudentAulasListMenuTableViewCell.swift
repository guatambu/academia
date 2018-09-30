//
//  StudentAulasListMenuTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 9/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentAulasListMenuTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var cellTitleOutlet: UILabel!
    @IBOutlet weak var cellSubtitleOutlet: UILabel!
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    var title: String? {
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
        guard let title = title else { return }
        
        cellTitleOutlet.text = title
        
    }

}
