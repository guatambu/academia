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
    var searchResults: [LocationFirestore]?
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var nameSearchTextField: UITextField!
    @IBOutlet weak var locationSearchTextField: UITextField!
    @IBOutlet weak var pleaseFindAcademyLabelOutlet: UILabel!
    @IBOutlet weak var searchResultsTableViewOutlet: UITableView!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    // CoreData properties
    var groupCD: GroupCD?
    var db: Firestore!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // turns off auto-correct in these UITextFields
        nameSearchTextField.autocorrectionType = UITextAutocorrectionType.no
        locationSearchTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        nameSearchTextField.autocapitalizationType = UITextAutocapitalizationType.none
        locationSearchTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // searchResultsTableViewOutlet.isHidden = true
        // likely will want to setup an active firestore listener
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // likely will want to dismiss the active firestore listener
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameSearchTextField.delegate = self
        locationSearchTextField.delegate = self
        
        searchResultsTableViewOutlet.isHidden = true
        searchResultsTableViewOutlet.delegate = self
        searchResultsTableViewOutlet.dataSource = self
        
        nameSearchTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.academyNameSearch.rawValue, attributes: beltBuilder.avenirFont)
        locationSearchTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationSearch.rawValue, attributes: beltBuilder.avenirFont)
        
//         Firebase Firestore [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
//         [END setup]
        db = Firestore.firestore()
    }
    

    // MARK: Actions
    
    @IBAction func tapAnywhereTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        if isSearching == true {
            
            isSearching = false
            
            if nameSearchTextField.isFirstResponder {
                
                nameSearchTextField.resignFirstResponder()
                
            } else if locationSearchTextField.isFirstResponder {
                
                locationSearchTextField.resignFirstResponder()
            }
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
        
        return searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell") else {
            
            print("ERROR: nil value found for cell in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 120.")
            return UITableViewCell()
        }
        
        guard let location = searchResults?[indexPath.row] else {
            
            print("ERROR: nil value found for location in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 126.")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = location.locationName
        
        return cell
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension FindYourAcademyViewController: UITextFieldDelegate {
    
    // UITextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameSearchTextField {
            textField.resignFirstResponder()
            locationSearchTextField.becomeFirstResponder()
            print("Next button tapped")
            
        } else if textField == locationSearchTextField {
            textField.resignFirstResponder()
            print("Search button tapped")
            
            isSearching = false
            
            // keyboard search button fires off the firestore collcetion group query and returns the query search results
            
            guard let nameSearch = nameSearchTextField.text, let locationSearch = locationSearchTextField.text else {
                return true
            }
            
            db.collectionGroup("locations").whereField("locationName", isEqualTo: nameSearch).whereField("zipCode", isEqualTo: locationSearch).getDocuments { (snapshopt, error) in
                
                if let error = error {
                    print("ERROR: \(error.localizedDescription) - a nil value found for locations in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 185.")
                }
                
                print("there are \(snapshopt?.documents.count ?? 987654321) retrieved by the locations collection group query")
                for document in snapshopt?.documents ?? [] {
                    print("\(document.data())")
                }
            }
        }
        
        return true
    }
    
}


