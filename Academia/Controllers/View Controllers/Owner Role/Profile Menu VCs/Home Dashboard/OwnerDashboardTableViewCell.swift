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
    @IBOutlet weak var checkBoxImageView: UIImageView!
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

        // here we can account for the different dashboard cases as the use of the app evolves over time with owner adding to their school's details, resources,a nd information.  open to ideas for info to display
        switch onBoardTask.name {
        case "welcome":
            // after the initial onboarding is done, think of somehting relevant to put here in the description.  maybe good bjj quotes to rotate through every so often?
            initialDashboardSetup()
            onBoardTask.isCompleted = true
            
        case "startGettingPaid":
            // initial setup with payment processor required. after that, we show some basic monthly sales info to current day in the month?
            initialDashboardSetup()
            onBoardTask.isCompleted = false
            
        case "setUpPaymentPrograms":
            // here we encourage the initial workflow from the owner. after initial setup, perhaps an ata a glance in description for how many active contracts the owner currently has running?  either just the actual agreements themselves or maybe a tally of how many active paying contracts present in the school?
            if PaymentProgramCDModelController.shared.paymentPrograms.isEmpty {
                // encourage owner to setup paymnet programs promtply as an early thing to do
                initialDashboardSetup()
                
                onBoardTask.isCompleted = false
            } else {
                
                // show the current amount in sales?
                //                onBoardingTaskTitleOutlet.text
                // at a a glance in description for how many active contracts the owner currently has running
                if PaymentProgramCDModelController.shared.paymentPrograms.count == 1 {
                    
                    onBoardingTaskDescriptionOutlet.text = "you currently have \(PaymentProgramCDModelController.shared.paymentPrograms.count) payment program available."
                    
                } else {
                    
                    onBoardingTaskDescriptionOutlet.text = "you currently have \(PaymentProgramCDModelController.shared.paymentPrograms.count) payment programs available."
                }
                
                onBoardTask.isCompleted = true
            }
            
        case "locationsSetUp":
            // encourage the creatioon of location(s), and then after we have that, show hom many locations the owner has
            
            if LocationCDModelController.shared.locations.isEmpty {
                // encourage the creatioon of location(s)
                initialDashboardSetup()
                
                onBoardTask.isCompleted = false
            } else {
                
                if LocationCDModelController.shared.locations.count == 1 {
                    // show hom many locations the owner has
                    onBoardingTaskTitleOutlet.text = "\(LocationCDModelController.shared.locations.count) Location"
                    // details for the description message
                    onBoardingTaskDescriptionOutlet.text = "you currently have \(LocationCDModelController.shared.locations.count) location setup"
                    
                } else {
                    // show hom many locations the owner has
                    onBoardingTaskTitleOutlet.text = "\(LocationCDModelController.shared.locations.count) Locations"
                    // details for the description message
                    onBoardingTaskDescriptionOutlet.text = "you currently have \(LocationCDModelController.shared.locations.count) locations setup"
                    
                }
                onBoardTask.isCompleted = true
            }
            
        case "messagingGroups":
            // encourage the creation of groups to organize students into message groups. once have message groups, then can show total number of students macro, and then micro for each group?
            if GroupCDModelController.shared.groups.isEmpty {
                // encourage the creation of groups to organize students into message groups.
                initialDashboardSetup()
                
                onBoardTask.isCompleted = false
            } else {
                
                if GroupCDModelController.shared.groups.count == 1 {
                    
                    // show total number of students macro...
                    onBoardingTaskTitleOutlet.text = "\(GroupCDModelController.shared.groups.count) Messaging Group"
                    
                } else {
                    // show total number of students macro...
                    onBoardingTaskTitleOutlet.text = "\(GroupCDModelController.shared.groups.count) Messaging Groups"
                }
                // and then micro for each group?
                onBoardingTaskDescriptionOutlet.text = "currently, there are \((StudentAdultCDModelController.shared.studentAdults.count + StudentKidCDModelController.shared.studentKids.count)) total students with \(StudentAdultCDModelController.shared.studentAdults.count) adults, \(StudentKidCDModelController.shared.studentKids.count) kids enrolled across all locaitons."
                
                onBoardTask.isCompleted = true
            }
            
        case "createClassSchedule":
            // encourage the creation of classes.  once done, offer link to view current schedule.
            if AulaCDModelController.shared.aulas.isEmpty {
                // encourage the creation of classes.
                initialDashboardSetup()
                
                onBoardTask.isCompleted = false
                
            } else {
                
                if AulaCDModelController.shared.aulas.count == 1 {
                
                    onBoardingTaskTitleOutlet.text = "\(AulaCDModelController.shared.aulas.count) Class Scheduled"
                    
                } else {
                    
                    onBoardingTaskTitleOutlet.text = "\(AulaCDModelController.shared.aulas.count) Classes Scheduled"
                }
                
                // offer link to view current schedule.
                onBoardingTaskDescriptionOutlet.text = "click to review your current schedule"
                
                onBoardTask.isCompleted = true
            }
            
        case "reviewBeltSystems":
            // as of this point, this is a relatively static cell
            initialDashboardSetup()
            onBoardTask.isCompleted = true
        default:
            print("ERROR: reached default case in switch statement in OwnerDashboardTableViewCell.swift -> updateViews() - line 76.")
        }
        
        // set the checkbox image in the cell
        guard let onBoardTaskComplete = onBoardTask.isCompleted else { return }
        
        if onBoardTaskComplete {
            checkBoxImageView.image = UIImage(named: "checked_box_50")
        } else {
            checkBoxImageView.image = UIImage(named: "unchecked_box_50")
        }

        
    }
    
    func initialDashboardSetup() {
        
        guard let onBoardTask = onBoardTask else { return }
        
        onBoardingTaskTitleOutlet.text = onBoardTask.title
        onBoardingTaskDescriptionOutlet.text = onBoardTask.descriptionDetail
    }
}
