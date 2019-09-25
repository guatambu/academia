//
//  MyLocationsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class MyLocationsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // create a fetchedRequestController with predicate to grab the current LocationsCD objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsController: NSFetchedResultsController<LocationCD>!
    
    var locations: [LocationFirestore] = []
    
    let beltBuilder = BeltBuilder()
    
    // Firebase Firestore properties
    var ownersCollectionRef: CollectionReference = Firestore.firestore().collection("owners")
    
    var db: Firestore!
    // The handler for the FIREBASE Auth state listener, to allow cancelling later.
    var handle: AuthStateDidChangeListenerHandle?
    var locationsListener: ListenerRegistration!
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // initiate Firestore Snapshot Listeneer to update tableView
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if Auth.auth().currentUser != nil {
                
                let user = Auth.auth().currentUser
                
                if let user = user {
                    
                    let userUID = user.uid
                    
                    self.locationsListener = self.ownersCollectionRef.document("\(userUID)")
                        .collection("locations")
                        .addSnapshotListener { querySnapshot, error in
                        
                        guard let documents = querySnapshot?.documents else {
                            print("Error fetching documents: \(error!.localizedDescription) in MyLocationsTableViewController.swift -> viewWillAppear() - line 55.")
                            return
                        }
                        
                        // reset the locations array to empty
                        self.locations = []
                        // repopulate it in case of updated data
                        for document in documents {
                            
                            let data = document.data()
                            
                            if let location = LocationFirestore(dictionary: data) {
                                
                                self.locations.append(location)
                                
                                
                            }
                        }
                        // update the tableView
                        self.tableView.reloadData()
                    }
                }
            }
        }
        // create fetch request and initialize results
//        initializeFetchedResultsController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // remove the Firestore SnapshotListener when no longer needed
        locationsListener.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        // initial Firestore query to get data
//        loadTableDataFromFirestore()

    }
    
    
    // MARK: loadData() from Firestore owner locations collections
    func loadTableDataFromFirestore() {
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if Auth.auth().currentUser != nil {
                
                let user = Auth.auth().currentUser
                
                if let user = user {
                    
                    let userUID = user.uid
                    
                    self.ownersCollectionRef.document("\(userUID)")
                        .collection("locations")
                        .getDocuments() { querySnapshot, error in
                        
                        guard let documents = querySnapshot?.documents else {
                            print("Error fetching documents: \(error!.localizedDescription) in MyLocationsTableViewController.swift -> viewWillAppear() - line 55.")
                            return
                        }
                        
                        for document in documents {
                            
                            let data = document.data()
                            
                            if let location = LocationFirestore(dictionary: data) {
                                
                                self.locations.append(location)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
//        return LocationModelController.shared.locations.count
        
//        guard let sections = fetchedResultsController.sections else {
//            fatalError("No sections in fetchedResultsController")
//        }
//        let sectionInfo = sections[section]
//        return sectionInfo.numberOfObjects
        
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ownerLocationsImageMenuCell", for: indexPath) as? LocationsImageMenuTableViewCell else { return UITableViewCell() }
        
//        let location = LocationModelController.shared.locations[indexPath.row]
        
        let location = locations[indexPath.row]
        
        // Configure the cell...
        cell.location = location

        return cell
    }

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        // pass any object as parameter, i.e. the tapped row
//        performSegue(withIdentifier: "toLocationDetail", sender: indexPath.row)
//    }
    
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLocationInfoDetails" {
            // Get the new ViewController using segue.destinationViewController
            guard let destVC = segue.destination as? LocationInfoDetailsViewController else { return }
            let indexPath = tableView.indexPathForSelectedRow!
            let location = locations[indexPath.row]
            
            // Pass the selected object to the new container
            /* destVC.locationCD = location */
        }
    }
}


// MARK: - NSFetchedREsultsController initializer method
//extension MyLocationsTableViewController: NSFetchedResultsControllerDelegate {
//
//    func initializeFetchedResultsController() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationCD")
//        let locationNameSort = NSSortDescriptor(key: "locationName", ascending: true)
//        request.sortDescriptors = [locationNameSort]
//
//        let moc = CoreDataStack.context
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<LocationCD>
//        fetchedResultsController.delegate = self
//
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            fatalError("Failed to initialize FetchedResultsController: \(error)")
//        }
//    }
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .delete:
//            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .move:
//            break
//        case .update:
//            break
//        @unknown default:
//            fatalError()
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            tableView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete:
//            tableView.deleteRows(at: [indexPath!], with: .fade)
//        case .update:
//            tableView.reloadRows(at: [indexPath!], with: .fade)
//        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        @unknown default:
//            fatalError()
//        }
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//}
