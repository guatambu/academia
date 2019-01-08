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
    var mockAdults = [MockData.adultA, MockData.adultA, MockData.adultA, MockData.adultA, MockData.adultA, MockData.adultA]
    var mockKids = [MockData.kidA, MockData.kidA, MockData.kidA, MockData.kidA, MockData.kidA, MockData.kidA, MockData.kidA]
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    var kidMembers: [KidStudent]?
    var adultMembers: [AdultStudent]?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
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
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toReviewAndCreateGroup") as! ReviewAndCreateGroupTableViewController
        
        // run check to see is there are groupMembers
        
        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
            print("ERROR: fail to unwrap kidMembers and/or adultmembers. AddStudentsToGroupTableViewController.swift -> nextButtontapped() - line 92")
            return
        }
        
        guard kidMembers.isEmpty == true && adultMembers.isEmpty == true else {
            
            welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
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
        
        return sectionHeaderLabels.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        sectionHeaderView.backgroundColor = UIColor.white
        
        let avenirFont16 = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        let label = UILabel()
        label.attributedText = NSAttributedString(string: sectionHeaderLabels[section], attributes: avenirFont16)
        label.frame = CGRect(x: 16, y: 0, width: 80, height: 40)
        
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
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

        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kidStudentCell", for: indexPath) as! KidStudentTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            cell.kidStudent = mockKids[indexPath.row]
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adultStudentCell", for: indexPath) as! AdultStudentTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            cell.adultStudent = mockAdults[indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toProfileComplete") as! OwnersStudentDetailViewController
        
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)

        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        if indexPath.section == 0 {
            // kidStudent setup
            let kid = mockKids[indexPath.row]
            
            destViewController.isOwner = false
            destViewController.isKid = true
            destViewController.username = kid.username
            destViewController.password = kid.password
            destViewController.firstName = kid.firstName
            destViewController.lastName = kid.lastName
            destViewController.parentGuardian = kid.parentGuardian
            destViewController.profilePic = kid.profilePic
            destViewController.birthdate = kid.birthdate
            destViewController.beltLevel = kid.belt.beltLevel
            destViewController.numberOfStripes = kid.belt.numberOfStripes
            destViewController.addressLine1 = kid.addressLine1
            destViewController.addressLine2 = kid.addressLine2
            destViewController.city = kid.city
            destViewController.state = kid.state
            destViewController.zipCode = kid.zipCode
            destViewController.phone = kid.phone
            destViewController.mobile = kid.mobile
            destViewController.email = kid.email
            destViewController.emergencyContactName = kid.emergencyContactName
            destViewController.emergencyContactRelationship = kid.emergencyContactRelationship
            destViewController.emergencyContactPhone = kid.emergencyContactPhone
            
        } else if indexPath.section == 1 {
            // adultStudent setup
            let adult = mockAdults[indexPath.row]
            
            destViewController.isOwner = false
            destViewController.isKid = false
            destViewController.username = adult.username
            destViewController.password = adult.password
            destViewController.firstName = adult.firstName
            destViewController.lastName = adult.lastName
            destViewController.profilePic = adult.profilePic
            destViewController.birthdate = adult.birthdate
            destViewController.beltLevel = adult.belt.beltLevel
            destViewController.numberOfStripes = adult.belt.numberOfStripes
            destViewController.addressLine1 = adult.addressLine1
            destViewController.addressLine2 = adult.addressLine2
            destViewController.city = adult.city
            destViewController.state = adult.state
            destViewController.zipCode = adult.zipCode
            destViewController.phone = adult.phone
            destViewController.mobile = adult.mobile
            destViewController.email = adult.email
            destViewController.emergencyContactName = adult.emergencyContactName
            destViewController.emergencyContactRelationship = adult.emergencyContactRelationship
            destViewController.emergencyContactPhone = adult.emergencyContactPhone
            
        }
        
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
        
        print("AddStudentsToGroupTVC -> inEditingMode: \(inEditingMode)")
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

