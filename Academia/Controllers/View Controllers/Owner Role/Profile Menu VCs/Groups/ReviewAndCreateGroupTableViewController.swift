//
//  ReviewAndCreateGroupTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

class ReviewAndCreateGroupTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var groupName: String?
    var active: Bool?
    var groupDescription: String?
    var kidMembers: [KidStudent]?
    var adultMembers: [AdultStudent]?
    var kidMembersCD: [StudentKidCD]?
    var adultMembersCD: [StudentAdultCD]?
    
    var kidMembersFirestore: [KidStudentFirestore]?
    var adultMembersFirestore: [AdultStudentFirestore]?

    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    @IBOutlet weak var studentAdvisoryLabelOutlet: UILabel!
    
    // Firebase Firestore properties
    var groupsCollectionRef: CollectionReference!
    var activeGroupFirestore: LocationFirestore?
    
    var db: Firestore!
    // The handler for the FIREBASE Auth state listener, to allow cancelling later.
    var handle: AuthStateDidChangeListenerHandle?

    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedGroupInfo()
        
        // run checks to produce advisory info to user regarding student types selected to a group
        if let kidMembers = kidMembers, let adultMembers = adultMembers, kidMembers.isEmpty && adultMembers.isEmpty {
            
            studentAdvisoryLabelOutlet.isHidden = false
            studentAdvisoryLabelOutlet.text = "no students added to group"
        
        } else if let kidMembers = kidMembers, kidMembers.isEmpty {
            
            studentAdvisoryLabelOutlet.isHidden = false
            studentAdvisoryLabelOutlet.text = "no kids added to group"
            
        } else if let adultMembers = adultMembers, adultMembers.isEmpty {
            
            studentAdvisoryLabelOutlet.isHidden = false
            studentAdvisoryLabelOutlet.text = "no adults added to group"
            
        } else {
            
            studentAdvisoryLabelOutlet.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        // Firestore Test properties setup
        db = Firestore.firestore()
    }
    
    
    // MARK: - Actions
    
    @IBAction func createGroupButtonTapped(_ sender: DesignableButton) {
        
        // create GroupCD data model object
        createAndSaveGroupCoreDataModel()
        
        // create GroupFirestore data model object
        createGroupFirestoreDataModel()
            
//        // create the new location in the LocationModelController source of truth
//        createGroup()
        
        // programmatic segue back to the MyLocations TVC to view the current locations
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is OwnerGroupListTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
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
        
        return 32
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        guard let kidMembersCD = kidMembersCD, let adultMembersCD = adultMembersCD else {
//
//            print("ERROR: nil value for either kidMembersCD and/or adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 133")
//            return 0
//        }
        
        guard let kidMembersFirestore = kidMembersFirestore, let adultMembersFirestore = adultMembersFirestore else {
            
            print("ERROR: nil value for either kidMembersFirestore and/or adultMemebersFirestore array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 160")
            return 0
        }
        
        if section == 0 {
            
//            return kidMembersCD.count
            
            return kidMembersFirestore.count
            
        } else if section == 1 {

//            return adultMembersCD.count
            return adultMembersFirestore.count
            
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let kidMembersCD = kidMembersCD, let adultMembersCD = adultMembersCD else {
//
//            print("ERROR: nil value for either kidMembersCD and/or adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 154")
//            return UITableViewCell()
//        }
        
        guard let kidMembersFirestore = kidMembersFirestore, let adultMembersFirestore = adultMembersFirestore else {
            
            print("ERROR: nil value for either kidMembersFirestore and/or adultMemebersFirestore array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 190")
            
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewKidStudentCell", for: indexPath) as! ReviewKidStudentTableViewCell
            
//            cell.kidStudentCD = kidMembersCD[indexPath.row]
            
            cell.kidStudentFirestore = kidMembersFirestore[indexPath.row]
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewAdultStudentCell", for: indexPath) as! ReviewAdultStudentTableViewCell
            
//            cell.adultStudentCD = adultMembersCD[indexPath.row]
            
            cell.adultStudentFirestore = adultMembersFirestore[indexPath.row]
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let kidMembers = kidMembers, let adultMembers = adultMembers else {
//            
//            print("ERROR: nil value for either kidMembers and/or adultMemebers array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 186")
//            return
//        }
        
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
            
//            // CoreData version
//            guard let kidMembersCD = kidMembersCD else {
//
//                print("ERROR: nil value for kidMembersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 242.")
//                return
//            }
//
//            let kidMembersCDSet = NSSet(array: kidMembersCD)
//
//            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
//            let kids = kidMembersCDSet.sortedArray(using: [nameSort])
//
//            guard let studentKidCD = kids[indexPath.row] as? StudentKidCD else {
//                print("ERROR: nil value for studentKidCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 252.")
//                return
//            }
//
//            destViewController.studentKidCD = studentKidCD
            
            guard let kidMembersFirestore = kidMembersFirestore else {
                
                print("ERROR: nil value for kidMembersFirestore array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 269.")
                
                return
            }
            
            let kidStudentFirestore = kidMembersFirestore[indexPath.row] 
            
            destViewController.kidStudentFirestore = kidStudentFirestore
            
        } else if indexPath.section == 1 {
            // adultStudent setup      
            
//            // CoreData version
//            guard let adultMembersCD = adultMembersCD else {
//
//                print("ERROR: nil value for adultMembersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 288.")
//                return
//            }
//
//            let adultMembersCDSet = NSSet(array: adultMembersCD)
//
//            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
//            let adults = adultMembersCDSet.sortedArray(using: [nameSort])
//
//            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
//                print("ERROR: nil value for studentAdultCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 298.")
//                return
//            }
//
//            destViewController.studentAdultCD = studentAdultCD
            
            guard let adultMembersFirestore = adultMembersFirestore else {
                
                print("ERROR: nil value for adultMembersFirestore array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 288.")
                
                return
            }
            
            let adultStudentFirestore = adultMembersFirestore[indexPath.row]
            
            destViewController.adultStudentFirestore = adultStudentFirestore
            
        }
    }
}


// MARK: - Helper Methods -> populateCompletedGroupInfo(), createGroup()
extension ReviewAndCreateGroupTableViewController {
    
    func populateCompletedGroupInfo() {
        
        guard let groupName = groupName, let groupDescription = groupDescription else {
                print("there was a nil value in the groupName and/or groupDescription passed to ReviewAndCreateGroupTVC.swift -> populateCompletedGroupInfo() - line 267")
                return
        }
        // name outlet
        groupNameLabelOutlet.text = groupName
        // active outlet
        if active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        lastChangedLabelOutlet.text = "\(Date())"
        // payment program description
        groupDescriptionTextView.text = "\(groupDescription)"
    }
    
//    func createGroup() {
//
//        guard let groupName = groupName else { print("fail groupName"); return }
//        guard let active = active else { print("fail active");  return }
//        guard let groupDescription = groupDescription else { print("fail groupDescription"); return }
//        guard let kidMembers = kidMembers else {
//            print("fail kidMembers")
//            return }
//        guard let adultMembers = adultMembers else { print("fail adultMembers"); return }
//
//        GroupModelController.shared.add(active: active, name: groupName, description: groupDescription, kidMembers: kidMembers, adultMembers: adultMembers)
//    }
}


// MARK: - funciton to create and save group to CoreData
extension ReviewAndCreateGroupTableViewController {
    
    func createAndSaveGroupCoreDataModel() {
        
        guard let groupName = groupName else { print("fail groupName"); return }
        guard let active = active else { print("fail active");  return }
        guard let groupDescription = groupDescription else { print("fail groupDescription"); return }
        
        let newGroupCD = GroupCD(active: active, name: groupName, groupDescription: groupDescription)
        
        // configure newGroup's "to-many" properties
        if let kidMembersCD = kidMembersCD {
            // if present in kidMembersCD array, add kids to newGroup's kidMembers
            if !kidMembersCD.isEmpty {
                for kid in kidMembersCD {
                    newGroupCD.addToKidMembers(kid)
                }
            }
        }
        if let adultMembersCD = adultMembersCD {
            // if present in adultMembersCD array, add adults to newGroup's adultMembers
            if !adultMembersCD.isEmpty {
                for adult in adultMembersCD {
                    newGroupCD.addToAdultMembers(adult)
                }
            }
        }
        
        // add the created and configured group to the source of truth
        GroupCDModelController.shared.add(group: newGroupCD)
        // save to CoreData
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func createGroupFirestoreDataModel() {
        
        guard let groupName = groupName else { print("fail groupName"); return }
        guard let active = active else { print("fail active");  return }
        guard let groupDescription = groupDescription else { print("fail groupDescription"); return }
        
        // create FIREBASE FIRESTORE location data object and save to cloud Firestore
        if Auth.auth().currentUser != nil {
            
            let user = Auth.auth().currentUser
            
            if let user = user {
                
                let userUID = user.uid
    
                // FIREBASE FIRESTORE CREATE AND SAVE NEW OWNER MODEL
                let group = GroupFirestore(isActive: active, name: groupName, groupDescription: groupDescription)
                            
                // set the Firebase Firestore Location collection reference
                groupsCollectionRef = Firestore.firestore().collection("owners").document(userUID).collection("groups")
                            
                groupsCollectionRef.document().setData(group.dictionary) { (error) in
                    
                    if let error = error {
                        print("ERROR: \(error.localizedDescription) error occurred while trying to save location to Firebase Firestore in ReviewAndCreateLocationVC -> createLocation() - line 237.")
                    } else {
                        print("new location data successfully saved to Firebase Firestore in owner's location collection")
                    }
                }
            }
        }        
    }
}

