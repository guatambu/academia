//
//  GroupNameAndDescriptionViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class GroupNameAndDescriptionViewController: UIViewController {

    // MARK: - Properties
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // welcome label outlets
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    // payment program info outlets
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
    @IBOutlet weak var groupNameTextField: UITextField!
    // active switch + details
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    // program description textView
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //populateCompletedProfileInfo()
    }
    
    
    // MARK: - Actions
    
    @IBAction func activeSwitchToggled(_ sender: UISwitch) {
        
        active = !active
        
        print("GroupNameAndDescriptionVC active property: \(active)")
    }
    
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        if groupNameTextField.text != "" {
            
            updateGroupInfo()
            
            self.returnToPaymentProgramInfo()
            
            print("update group name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        }
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
      
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toAddStudentsToGroup") as! AddStudentsToGroupTableViewController
        
        // run check to see is there is a paymentProgramName
        guard groupNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        groupName = groupNameTextField.text
        groupDescription = groupDescriptionTextView.text
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.groupName = groupName
        destViewController.active = active
        destViewController.groupDescription = groupDescription
        
        destViewController.inEditingMode = inEditingMode
        destViewController.groupToEdit = groupToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in onboarding
        updateGroupInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension GroupNameAndDescriptionViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateGroupInfo() {
        guard let group = groupToEdit else { return }
        // group update info
        if groupNameTextField.text != "" {
            GroupModelController.shared.update(group: group, active: active, name: groupNameTextField.text, description: groupDescriptionTextView.text, kidMembers: nil, adultMembers: nil, kidStudent: nil, adultStudent: nil)
            print("update group name: \(GroupModelController.shared.groups[0].name)")
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            groupEditingSetup()
        }
        
        print("GroupNameAndDescriptionVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func groupEditingSetup() {
        
        guard let groupToEdit = groupToEdit else {
            return
        }
        
        welcomeLabelOutlet.text = "Group: \(groupToEdit.name)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        groupDescriptionTextView.text = groupToEdit.description
        groupNameTextField.text = groupToEdit.name
    }
}
