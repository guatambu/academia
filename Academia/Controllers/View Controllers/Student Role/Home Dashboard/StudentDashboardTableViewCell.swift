//
//  StudentDashboardTableViewCell.swift
//  Academia
//
//  Created by Kelly Johnson on 4/8/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentDashboardTableViewCell: UITableViewCell {
        
    // MARK: - Properties
    
    @IBOutlet weak var rightRedArrowOutlet: UIImageView!
    @IBOutlet weak var onBoardingTaskTitleOutlet: UILabel!
    @IBOutlet weak var onBoardingTaskDescriptionOutlet: UILabel!
    
    var onBoardTask: OnBoardingTask? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Actions
    
//    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
//    }
    
    
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
        
//        checkBoxImageView.image = UIImage()
        
//        guard let onBoardTaskComplete = onBoardTask.isCompleted else { return }
//        
//        if onBoardTaskComplete {
//            checkBoxImageView.image = UIImage(named: "checked_box_32")
//        } else {
//            checkBoxImageView.image = UIImage(named: "unchecked_box_32")
//        }
    }
}
