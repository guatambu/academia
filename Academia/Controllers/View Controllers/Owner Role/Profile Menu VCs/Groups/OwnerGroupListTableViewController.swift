//
//  OwnerGroupListTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class OwnerGroupListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()
    
    // an array of tuples that allow the documentID value and the group object to be grouped and passed together
    var groups: [(String, GroupFirestore)] = []
    
    // Firebase Firestore properties
    var ownersCollectionRef: CollectionReference = Firestore.firestore().collection("owners")
    
    var db: Firestore!
    // The handler for the FIREBASE Auth state listener, to allow cancelling later.
    var handle: AuthStateDidChangeListenerHandle?
    var groupsListener: ListenerRegistration!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // initiate Firestore Snapshot Listeneer to update tableView
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if Auth.auth().currentUser != nil {
                
                let user = Auth.auth().currentUser
                
                if let user = user {
                    
                    let userUID = user.uid
                    
                    self.groupsListener = self.ownersCollectionRef.document("\(userUID)")
                        .collection("groups")
                        .addSnapshotListener { querySnapshot, error in
                            
                            guard let documents = querySnapshot?.documents else {
                                print("Error fetching documents: \(error!.localizedDescription) in OwnerGroupListTableViewController.swift -> viewWillAppear() - line 55.")
                                return
                            }
                            
                            // reset the locations array to empty
                            self.groups = []
                            // repopulate it in case of updated data
                            for document in documents {
                                
                                let data = document.data()
                                
                                if let group = GroupFirestore(dictionary: data) {
                                    
                                    self.groups.append((document.documentID, group))
                                }
                            }
                            // alphabetize the array according to location name
                            self.groups = self.groups.sorted { $0.1.name.lowercased() < $1.1.name.lowercased() }
                            // update the tableView
                            self.tableView.reloadData()
                    }
                }
            }
        }
        
        //tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // remove the Firestore SnapshotListener when no longer needed
        groupsListener.remove()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Student Groups"
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        db = Firestore.firestore()
    }
    
    
    // MARK: - Actions
    
    @IBAction func addNewGroupButtonTapped(_ sender: UIBarButtonItem) {
        // programmatically performing the group segue
        
        // instantiate the relevant storyboard
        let ownerStudentFlowView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerStudentFlowView.instantiateViewController(withIdentifier: "toGroupNameAndDescription") as! GroupNameAndDescriptionViewController
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
        
    }
    

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return GroupCDModelController.shared.groups.count
        
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ownerStudentGroupsMenuCell", for: indexPath) as? StudentGroupGeneralMenuTableViewCell else { return UITableViewCell() }
        
//        let groupCD = GroupCDModelController.shared.groups[indexPath.row]
//
//        // Configure the cell...
//        cell.title = groupCD.name
        
        let group = groups[indexPath.row]
        
        // Configure the cell...
        cell.title = group.1.name

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the group segue
        
        // instantiate the relevant storyboard
        let ownerStudentFlowView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerStudentFlowView.instantiateViewController(withIdentifier: "toGroupInfoDetails") as! GroupInfoDetailsTableViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage(contentsOfFile: "")
        
//        // get the desired groupCD for the selected cell
//        let groupCD = GroupCDModelController.shared.groups[indexPath.row]
//        // pass CoreData payment program on to InfoDetails view
//        destViewController.groupCD = groupCD
        
        // get the desired groupFirestore for the selected cell
        let groupFirestoreTuple = groups[indexPath.row]
        // pass groupFirestore on to InfoDetails view
        destViewController.groupFirestoreTuple = groupFirestoreTuple
        
    }
}







