//
//  AddStudentsToGroupTableViewController.swift
//  Academia
//
//  Created by Michel Guatambu Davis on 12/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddStudentsToGroupTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    var groupMembers: [Any]?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        if groupNameTextField.text != "" {
            
            updateGroupInfo()
            
            self.returnToPaymentProgramInfo()
            
            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        }
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        print("to billing details segue")
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
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

}


// MARK: - Editing Mode for Individual User case specific setup
extension AddStudentsToGroupTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateGroupInfo() {
        guard let group = groupToEdit else { return }
        // group update info
        if groupNameTextField.text != "" {
            GroupModelController.shared.update(group: group, active: active, name: groupNameTextField.text, description: groupDescriptionTextView.text, members: nil)
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
        
        welcomeLabelOutlet.text = "Program: \(groupToEdit.name)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        groupDescriptionTextView.text = groupToEdit.description
        groupNameTextField.text = groupToEdit.name
    }
}

