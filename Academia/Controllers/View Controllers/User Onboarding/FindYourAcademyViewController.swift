//
//  FindYourAcademyViewController.swift
//  Academia
//
//  Created by Michael Guatmbu Davis on 3/1/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import Firebase

class FindYourAcademyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid = false
    var academyChoice: String?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    var isSearching: Bool = false
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var searchBarButtonOutlet: UIButton!
    @IBOutlet weak var pleaseFindAcademyLabelOutlet: UILabel!
    @IBOutlet weak var searchResultsTableViewOutlet: UITableView!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    // CoreData properties
    var groupCD: GroupCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchResultsTableViewOutlet.isHidden = true
        // likely will want to setup an active firestore listener
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // likely will want to dismiss the active firestore listener
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarOutlet.delegate = self
        
        searchResultsTableViewOutlet.isHidden = true
        searchResultsTableViewOutlet.delegate = self
        searchResultsTableViewOutlet.dataSource = self
        
    }
    

    // MARK: Actions
    
    @IBAction func tapAnywhereTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        if isSearching == true {
            
            isSearching = false
            
            searchBarOutlet.resignFirstResponder()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        
        // programmatically performing the Kid Student segue
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toSignUpLoginViewController") as! SignUpLoginViewController
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
        
        // pass desired data to relevant view controller
        destViewController.isOwner = self.isOwner
        destViewController.isKid = self.isKid
        destViewController.academyChoice = academyChoice
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        destViewController.groupCD = groupCD
        
    }
    
    // MARK: TableView DataSource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension FindYourAcademyViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        
        searchBar.resignFirstResponder()
        
        isSearching = false
        
        // keyboard search button fires off the firestore query and returns the query search results
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        // un-hide table view to display search results
        searchResultsTableViewOutlet.isHidden = false
        
        isSearching = true
        
    }
    
}


