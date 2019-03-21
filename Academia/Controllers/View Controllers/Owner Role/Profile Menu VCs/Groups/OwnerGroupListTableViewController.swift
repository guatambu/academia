//
//  OwnerGroupListTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class OwnerGroupListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // create a fetchedRequestController with predicate to grab the current GroupCD objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsController: NSFetchedResultsController<GroupCD>!
    
    let beltBuilder = BeltBuilder()
    
//    var allGroups = [MockData.allStudents]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // create fetch request and initialize results
        initializeFetchedResultsController()
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Student Groups"
 
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
        
//        return GroupModelController.shared.groups.count
        
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ownerStudentGroupsMenuCell", for: indexPath) as? StudentGroupGeneralMenuTableViewCell else { return UITableViewCell() }
        
//        let group = GroupModelController.shared.groups[indexPath.row]
        
        guard let groupCD = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("Attempt to configure cell without a managed object")
        }
        
        // Configure the cell...
        cell.title = groupCD.name
        
        print(groupCD.kidMembers as Any)

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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
        
        // get the desired groupCD for the selected cell
        let groupCD = fetchedResultsController.object(at: indexPath as IndexPath)
        // pass CoreData payment program on to InfoDetails view
        destViewController.groupCD = groupCD
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGroupDetails" {
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            guard let destination = segue.destination as? GroupInfoDetailsTableViewController else { return }
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            
//            let group = GroupModelController.shared.groups[indexPath.row]
//            destination.group = group
            
            let groupCD = fetchedResultsController.object(at: indexPath)
            destination.groupCD = groupCD
        }
    }
}


// MARK: - NSFetchedREsultsController initializer method
extension OwnerGroupListTableViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupCD")
        let groupNameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [groupNameSort]
        
        let moc = CoreDataStack.context
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<GroupCD>
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}








