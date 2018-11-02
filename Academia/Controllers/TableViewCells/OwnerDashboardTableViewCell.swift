//
//  OwnerDashboardTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/23/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class OwnerDashboardTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    

    @IBOutlet weak var checkboxButtonOutlet: UIButton!
    @IBOutlet weak var rightRedArrowOutlet: UIImageView!
    @IBOutlet weak var onBoardingTaskTitleOutlet: UILabel!
    @IBOutlet weak var onBoardingTaskDescriptionOutlet: UILabel!
    
    var onBoardTask: OnBoardingTask? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
    }
    
    
    // MARK: - awakeFromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        guard let onBoardTask = onBoardTask else { return }
        
        onBoardingTaskTitleOutlet.text = onBoardTask.title
        onBoardingTaskDescriptionOutlet.text = onBoardTask.descriptionDetail
        
        
        guard let onBoardTaskComplete = onBoardTask.isCompleted else { return }
        
        if onBoardTaskComplete {
            checkboxButtonOutlet.imageView?.image = #imageLiteral(resourceName: "checked_tick_box_32.png")
        } else {
            checkboxButtonOutlet.imageView?.image = #imageLiteral(resourceName: "unchecked_checkbox_32.png")
        }
    }
}
