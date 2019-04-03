//
//  AddStudentsToGroupTableViewController.swift
//  Academia
//
//  Created by Michel Guatambu Davis on 12/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class AddStudentsToGroupTableViewController: UITableViewController, GroupMembersDelegate {
    
    // MARK: - Properties

    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    var kidMembers: [KidStudent] = []
    var adultMembers: [AdultStudent] = []
    var kidMembersCD: [StudentKidCD] = []
    var adultMembersCD: [StudentAdultCD] = []
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    // welcome label outlets
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    // CoreData Properties
    var groupCD: GroupCD?
    var groupCDToEdit: GroupCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Group update profile info
        updateGroupInfo()
        
        self.returnToGroupInfo()
        
        print("update... \nkidsMembers.count = \(String(describing: self.groupCDToEdit?.kidMembers?.count))\nadultMembers.count = \(String(describing: self.groupCDToEdit?.adultMembers?.count))")
        
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toReviewAndCreateGroup") as! ReviewAndCreateGroupTableViewController
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass data to destViewController
        destViewController.groupName = groupName
        destViewController.active = active
        destViewController.groupDescription = groupDescription
        destViewController.kidMembersCD = kidMembersCD
        destViewController.adultMembersCD = adultMembersCD
        
        destViewController.inEditingMode = inEditingMode
        destViewController.groupToEdit = groupToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
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

            return StudentKidCDModelController.shared.studentKids.count
            
        } else if section == 1 {

            return StudentAdultCDModelController.shared.studentAdults.count
            
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
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.kidMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {
                    
                    // CoreData version
                    guard let kidsToEditCD = groupCDToEdit?.kidMembers else {
                        print("ERROR: nil value for kidsToEditCE in AddStudentsToGroupTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 205")
                        return UITableViewCell()
                    }
                    
                    let kidCD = StudentKidCDModelController.shared.studentKids[indexPath.row]
                    
                    if kidsToEditCD.contains(kidCD) {
                        
                        cell.isChosen = true
                    }
                    
                    cell.studentKidCD = StudentKidCDModelController.shared.studentKids[indexPath.row]
                    
                    return cell
                }
            }
       
            cell.studentKidCD = StudentKidCDModelController.shared.studentKids[indexPath.row]
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adultStudentCell", for: indexPath) as! AdultStudentTableViewCell
            
            // set delegate to communicate with AddNewStudentGroupImageMenuTableViewCell
            cell.delegate = self
            
            // set the isChosen to true if inEditingMode == true and current student is present in groupToEdit.adultMembers array to display the student as chosen
            if let inEditingMode = inEditingMode {
                
                if inEditingMode {

                    // CoreData version
                    guard let adultsToEditCD = groupCDToEdit?.adultMembers else {
                        print("ERROR: nil value for adultsToEditCD in AddStudentsToGroupTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 205")
                        return UITableViewCell()
                    }
                    
                    let adultCD = StudentAdultCDModelController.shared.studentAdults[indexPath.row]
                    
                    if adultsToEditCD.contains(adultCD) {
                        
                        cell.isChosen = true
                    }
                    
                    cell.studentAdultCD = StudentAdultCDModelController.shared.studentAdults[indexPath.row]
                    
                    return cell
                }
            }
            
            cell.studentAdultCD = StudentAdultCDModelController.shared.studentAdults[indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toProfileComplete") as! OwnersStudentDetailViewController
        
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)

        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if indexPath.section == 0 {
            
            // kidStudent setup
            
            // CoreData version
            
            let studentKidCD = StudentKidCDModelController.shared.studentKids[indexPath.row]
            
            destViewController.studentKidCD = studentKidCD
            
        } else if indexPath.section == 1 {
            
            // adult setup
            
            // CoreData version
            
            let studentAdultCD = StudentAdultCDModelController.shared.studentAdults[indexPath.row]
            
            destViewController.studentAdultCD = studentAdultCD
        }
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension AddStudentsToGroupTableViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateGroupInfo() {
        
        if kidMembersCD.count != 0 && adultMembersCD.count != 0 {
        
            // CoreData GroupCD update info
            guard let groupCDToEdit = groupCDToEdit else { return }
        
            groupCDToEdit.adultMembers = []
            groupCDToEdit.kidMembers = []
        
            for existingAdult in adultMembersCD {
                groupCDToEdit.addToAdultMembers(existingAdult)
            }
        
            for existingKid in kidMembersCD {
                groupCDToEdit.addToKidMembers(existingKid)
            }
        }
        // save to CoreData
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            groupEditingSetup()
            
        } else {
            nextButtonOutlet.isHidden = false
            nextButtonOutlet.isEnabled = true
        }
        
        print("AddStudentsToGroupTVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func groupEditingSetup() {
        
        guard let groupCDToEdit = groupCDToEdit else {
            return
        }
        guard let kidMembers = groupCDToEdit.kidMembers else { return }
        guard let adultMembers = groupCDToEdit.adultMembers else { return }
        
        welcomeLabelOutlet.text = "Group: \(groupCDToEdit.name ?? "")"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        nextButtonOutlet.isHidden = true
        nextButtonOutlet.isEnabled = false
        
        // sync up the grouptoEdit students with this TVC's properties when inEditingMode == true
        let firstNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
        
        let adults = adultMembers.sortedArray(using: [lastNameSort, firstNameSort]) as! [StudentAdultCD]
        let kids = kidMembers.sortedArray(using: [lastNameSort, firstNameSort]) as! [StudentKidCD]
        
        kidMembersCD = kids
        adultMembersCD = adults
    }
}


