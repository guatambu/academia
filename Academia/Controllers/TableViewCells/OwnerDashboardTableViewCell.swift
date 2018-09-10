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
    
    @IBOutlet weak var checkBoxOutlet: UIImageView!
    @IBOutlet weak var rightRedArrowOutlet: UIImageView!
    @IBOutlet weak var onBoardingTaskTitleOutlet: UILabel!
    @IBOutlet weak var onBoardingTaskDescriptionOutlet: UILabel!
    
    var onBoardTask: OnBoardingTask? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Actions / Gesture Recognizers
    
    @IBAction func dashboardCellTapped(_ sender: UITapGestureRecognizer) {
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
        onBoardingTaskDescriptionOutlet.text = onBoardTask.description
        
        
        guard let onBoardTaskComplete = onBoardTask.isCompleted else { return }
        
        if onBoardTaskComplete {
            checkBoxOutlet.image = #imageLiteral(resourceName: "checked_tick_box_32.png")
        } else {
            checkBoxOutlet.image = #imageLiteral(resourceName: "unchecked_checkbox_32.png")
        }
    }
}
