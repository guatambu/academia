//
//  AddStudentsToGroupTableViewController.swift
//  Academia
//
//  Created by Michel Guatambu Davis on 12/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddStudentsToGroupTableViewController: UITableViewController, GroupMembersDelegate {
    
    // MARK: - Properties
    
    // Mock Data
    
    var mockAdults = [MockData.adultA]
    var mockKids = [MockData.kidA]
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    var kidMembers: [KidStudent]?
    var adultMembers: [AdultStudent]?
    
    var addedToGroup = false
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // welcome label outlets
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up delegate relationship with AddNewStudentGroupTableViewCell
        tableView.delegate = self

    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Group update profile info
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            print("ERROR: fail to unwrap kidMembers and/or adultmembers. AddStudentsToGroupTableViewController.swift -> saveButtontapped() - line 63")
            return
        }
        if kidMembers.isEmpty == false || adultMembers.isEmpty == false {
            
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
        let destViewController = mainView.instantiateViewController(withIdentifier: "toReviewAndCreateGroup") as! ReviewAndCreateGroupTableViewController
        
        // run check to see is there are groupMembers
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            print("ERROR: fail to unwrap kidMembers and/or adultmembers. AddStudentsToGroupTableViewController.swift -> saveButtontapped() - line 93")
            return
        }
        
        guard kidMembers.isEmpty == true && adultMembers.isEmpty == true else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
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
        destViewController.kidMembers = kidMembers
        destViewController.adultMembers = adultMembers
        
        destViewController.inEditingMode = inEditingMode
        destViewController.groupToEdit = groupToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in onboarding
        updateGroupInfo()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return mockKids.count
            
        } else if section == 1 {
            return mockAdults.count
            
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addNewGroupStudentImageMenuCell", for: indexPath) as! AddNewStudentGroupImageMenuTableViewCell
        
        // set the delegate to communicate between the custom cell and the TVC
        cell.delegate = self

        // Configure the cell...
        if indexPath.section == 0 {
            cell.adultStudent = mockAdults[indexPath.row]
            
        } else if indexPath.section == 1 {
            cell.kidStudent = mockKids[indexPath.row]
            
        }

        return cell
    }

}


// MARK: - Editing Mode for Individual User case specific setup
extension AddStudentsToGroupTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateGroupInfo() {
        guard let group = groupToEdit else { return }
        // group update info
        GroupModelController.shared.update(group: group, active: nil, name: nil, description: nil, kidMembers: kidMembers, adultMembers: adultMembers)
        print("how many members in the group: \(GroupModelController.shared.groups.count)")
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
        
    }
}

