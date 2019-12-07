//
//  GroupInfoDetailsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class GroupInfoDetailsTableViewController: UITableViewController {

    // MARK: - Properties
    var group: Group?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    
    // CoreData Properties
    var groupCD: GroupCD?
    var groupCDToEdit: GroupCD?
    
    // Firebase Firestore properties
    var groupFirestoreTuple: (String, GroupFirestore)?
    var kidMembers: [KidStudentFirestore]?
    var adultMembers: [AdultStudentFirestore]?
    
    var ownersCollectionRef: CollectionReference = Firestore.firestore().collection("owners")
    var kidStudentsCollectionRef: CollectionReference = Firestore.firestore().collection("kidStudents")
    var adultStudentsCollectionRef: CollectionReference = Firestore.firestore().collection("adultStudents")
    
    var db: Firestore!
    // The handler for the FIREBASE Auth state listener, to allow cancelling later.
    var handle: AuthStateDidChangeListenerHandle?
    var groupsListener: ListenerRegistration!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // initiate Firestore Snapshot Listeneer to update tableView
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if Auth.auth().currentUser != nil {
                    
                guard /*let groupDocumentID = self.groupFirestoreTuple?.0,*/ let group = self.groupFirestoreTuple?.1 else {
                    
                    print("ERROR: nil value found for groupFirestoreTuple value(s) in GroupInfoDetailsTableViewController.swift -> viewWillAppear() - line 64.")
                    return
                }
            
// TODO: we will want to update changes which include additions to either of the two member arrays, or the various group details themselves and call the Firestore db in the editing process when we save
                
                // reset the members arrays array to empty
                self.kidMembers = []
                self.adultMembers = []
                
                if let kidMembers = group.kidMembers {
                    // iterate through the kidMembers array of UID strings
                    for kidUID in kidMembers {
                        // create the specific document Referebce with kidUID
                        let docRef = self.kidStudentsCollectionRef.document(kidUID)
                        // go get the kidStudent document in Firestore
                        docRef.getDocument { (document, error) in
                            // run checks to see if the document.data() exists
                            if let data = document?.data() {
                                // create the correspomding data object
                                if let kid = KidStudentFirestore(dictionary: data) {
                                    // append to the specfic mebers array
                                    self.kidMembers?.append(kid)
                                }
                            } else {
                                print("ERROR: value for kidUID Document.data() does not exist found for in GroupInfoDetailsTableViewController.swift -> viewWillAppear() - line 86. ")
                            }
                        }
                    }
                    
                } else {
                    print("ERROR: nil value found for group.kidMembers array in GroupInfoDetailsTableViewController.swift -> viewWillAppear() - line 92.")
                }
                
                if let adultMembers = group.adultMembers {
                    
                    // iterate through the kidMembers array of UID strings
                    for adultUID in adultMembers {
                        // create the specific document Referebce with kidUID
                        let docRef = self.kidStudentsCollectionRef.document(adultUID)
                        // go get the kidStudent document in Firestore
                        docRef.getDocument { (document, error) in
                            // run checks to see if the document.data() exists
                            if let data = document?.data() {
                                // create the correspomding data object
                                if let adult = AdultStudentFirestore(dictionary: data) {
                                    // append to the specfic mebers array
                                    self.adultMembers?.append(adult)
                                }
                            } else {
                                print("ERROR: value for adultUID Document.data() does not exist found for in GroupInfoDetailsTableViewController.swift -> viewWillAppear() - line 111. ")
                            }
                        }
                    }
                    
                } else {
                    print("ERROR: nil value found for group.adultMembers array in GroupInfoDetailsTableViewController.swift -> viewWillAppear() - line 117.")
                }
                
                // alphabetize the member arrays according to location name
                self.kidMembers = self.kidMembers?.sorted { $0.firstName.lowercased() < $1.firstName.lowercased() }
                self.adultMembers = self.adultMembers?.sorted { $0.firstName.lowercased() < $1.firstName.lowercased() }
            
                // populate the group info details
                self.populateCompletedGroupInfo()
                // update the students tableView
                self.tableView.reloadData()
                
            }
        }
    //        populateCompletedGroupInfo()
    //
    //        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        // set Firestore b property
        db = Firestore.firestore()
    }
    
    
    // MARK: - Actions
    
    @objc func backToGroupInfoDetails() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addStudentButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toStudentChoiceVC") as! StudentChoiceViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        backButtonItem.action = #selector(backToGroupInfoDetails)
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // TODO: - follow the isOwnerAddingNewStudent workflow for CoreData implementaiton
        
        // set properties on destinationVC
        destViewController.isOwner = false
        destViewController.isOwnerAddingStudent = true
        destViewController.group = group
        destViewController.groupCD = groupCD
        
    }
    
    @IBAction func deleteGroupButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Group", message: "are you sure you want to delete this group?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive) { (alert) in
            
            guard let groupCD = self.groupCD else {
                print("ERROR: nil value found for groupCD in GroupInfoDetailsViewController.swift -> deleteGroupButtonTapped(sender:) - line 92.")
                return
            }
            GroupCDModelController.shared.remove(group: groupCD)
            
            // programmatically performing the segue
            guard let viewControllers = self.navigationController?.viewControllers else { return }
            
            for viewController in viewControllers {
                
                if viewController is OwnerGroupListTableViewController{
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
            
            print("how many location we got now: \(GroupModelController.shared.groups.count)")
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
    
    // MARK: - editButtonTapped()
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toGroupNameAndDescription") as! GroupNameAndDescriptionViewController
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
        
        // set properties on destinationVC
        destViewController.inEditingMode = true
        
        destViewController.groupCDToEdit = groupCD
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
        
        // CoreData versions
        guard let groupCD = groupCD else {
            
            print("ERROR: nil value for groupCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 208")
            return 0
        }
        
        guard let kidMembersCD = groupCD.kidMembers, let adultMembersCD = groupCD.adultMembers else {
            
            print("ERROR: nil value for either kidMembersCD and/or adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 214")
            return 0
        }

        if section == 0 {
            
            return kidMembersCD.count
            
        } else if section == 1 {

            return adultMembersCD.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CoreData versions
        guard let groupCD = groupCD else {
            
            print("ERROR: nil value for groupCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 208")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            guard let kidMembersCD = groupCD.kidMembers else {
                
                print("ERROR: nil value for either kidMembersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 239")
                return UITableViewCell()
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "kidStudentCell", for: indexPath) as? KidGroupInfoDetailsTableViewCell else {
                
                return UITableViewCell()
            }
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let kids = kidMembersCD.sortedArray(using: [nameSort])
            
            guard let studentKidCD = kids[indexPath.row] as? StudentKidCD else { return UITableViewCell() }
            
            print("GroupInfoDetailsTableViewController -> studentKidCD.firstName: \(String(describing: studentKidCD.firstName))")
            
            if let profilePicData = studentKidCD.profilePic, let profilePic = UIImage(data: profilePicData) {
                print("\(profilePic.scale)")
            }
            
            cell.studentKidCD = studentKidCD
            
            return cell
            
        } else {
            
            guard let adultMembersCD = groupCD.adultMembers else {
                
                print("ERROR: nil value for either adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 261")
                return UITableViewCell()
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "adultStudentCell", for: indexPath) as? AdultGroupInfoDetailsTableViewCell else {
                
                return UITableViewCell()
            }
            
            // CoreData Version
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultMembersCD.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else { return UITableViewCell() }
            
            print("GroupInfoDetailsTableViewController -> studentAdultCD.firstName: \(String(describing: studentAdultCD.firstName))")
            
            cell.studentAdultCD = studentAdultCD
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // CoreData versions
        guard let groupCD = groupCD else {
            
            print("ERROR: nil value for groupCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 208")
            return
        }
        
        guard let kidMembersCD = groupCD.kidMembers, let adultMembersCD = groupCD.adultMembers else {
            
            print("ERROR: nil value for either kidMembersCD and/or adultMemebersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 214")
            return
        }
        
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
            
            // CoreData Version
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let kids = kidMembersCD.sortedArray(using: [nameSort])
            
            guard let studentKidCD = kids[indexPath.row] as? StudentKidCD else {
                print("ERROR: nil value for either studentKidCD in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 214")
                return
            }
            
            destViewController.studentKidCD = studentKidCD
            destViewController.isKid = true
            
        } else if indexPath.section == 1 {
            
            // adultStudent setup
            
            // CoreData Version
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultMembersCD.sortedArray(using: [nameSort])

            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for either studentAdultCD in ReviewAndCreateGroupTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 379")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
            destViewController.isKid = false
            
        }
    }
}


extension GroupInfoDetailsTableViewController {
    
    func populateCompletedGroupInfo() {
        
        // CoreData version
        guard let groupCD = groupCD else {
            print("there was a nil value in the groupCD passed to GroupInfoDetailsTableViewController.swift -> populateCompletedGroupInfo() - line 256")
            return
        }
        // VC title
        groupNameLabelOutlet.text = groupCD.name
        // active outlet
        if groupCD.active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        print(groupCD.active)
        // lastChanged outlet
        if let dateEdited = groupCD.dateEdited {
            
            lastChangedLabelOutlet.text = "\(dateEdited)"
        }
        // payment program description
        groupDescriptionTextView.text = "\(groupCD.groupDescription ?? "")"
    }
}


// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and group profileVC
extension UIViewController {
    
    func returnToGroupInfo() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is GroupInfoDetailsTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}
