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
    var academyChoice: String?  // academy Firestore UID
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    var isSearching: Bool = false
    var searchResults: [LocationFirestore] = []
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var nameSearchTextField: UITextField!
    @IBOutlet weak var locationSearchTextField: UITextField!
    @IBOutlet weak var pleaseFindAcademyLabelOutlet: UILabel!
    @IBOutlet weak var searchResultsTableViewOutlet: UITableView!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    // CoreData properties
    var groupCD: GroupCD?
    // Firebase properties
    var db: Firestore!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // turns off auto-correct in these UITextFields
        nameSearchTextField.autocorrectionType = UITextAutocorrectionType.no
        locationSearchTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        nameSearchTextField.autocapitalizationType = UITextAutocapitalizationType.none
        locationSearchTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        searchResultsTableViewOutlet.isHidden = true
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
        
        if academyChoice != nil {
            
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
            destViewController.academyChoice = academyChoice?.lowercased()
            destViewController.isOwnerAddingStudent = isOwnerAddingStudent
            destViewController.group = group
            destViewController.groupCD = groupCD
            
            // reset the pleaseFindAcademy Label to default messaging
            pleaseFindAcademyLabelOutlet.text = "please find your academy"
            pleaseFindAcademyLabelOutlet.textColor = beltBuilder.blackBeltBlack
            // reset the searchResults array to empty, reload the tableView data, and hide the tableView ready for the next search
            searchResults = []
            searchResultsTableViewOutlet.reloadData()
            searchResultsTableViewOutlet.isHidden = true
            
        } else {
            
            pleaseFindAcademyLabelOutlet.text = "please find your academy"
            pleaseFindAcademyLabelOutlet.textColor = beltBuilder.redBeltRed
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            nameSearchTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.academyNameSearch.rawValue, attributes: beltBuilder.errorAvenirFont)
            
            locationSearchTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationSearch.rawValue, attributes: beltBuilder.errorAvenirFont)
            
        }
    }
    
    // MARK: TableView DataSource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell") as? AcademySearchResultsTableViewCell else {
            
            print("ERROR: nil value found for cell in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 120.")
            return UITableViewCell()
        }
        
        let location = searchResults[indexPath.row]
        
        cell.locationFirestore = location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let location = searchResults[indexPath.row]
        
        academyChoice = location.locationName
        
        pleaseFindAcademyLabelOutlet.text = "your academy: \(academyChoice ?? "")"
        
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
            
            // reset the searchResults array to empty
            searchResults = []
            
            // keyboard search button fires off the firestore collcetion group query and returns the query search results
            
            guard let nameSearch = nameSearchTextField.text?.lowercased(), let locationSearch = locationSearchTextField.text?.lowercased() else {
                return true
            }
            
            if nameSearch != "" && locationSearch != "" {
                
                // 'ideal' search case scenario
                db.collectionGroup("locations").whereField("locationName", isEqualTo: nameSearch).whereField("city", isEqualTo: locationSearch).getDocuments { (snapshopt, error) in
                    
                    if let error = error {
                        print("ERROR: \(error.localizedDescription) - a nil value found for locations in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 185.")
                    }
                    
                    print("there are \(snapshopt?.documents.count ?? 987654321) retrieved by the locations collection group query")
                    for document in snapshopt?.documents ?? [] {
                        // print the document dictionary data
                        print("\(document.data())")
                        // create the location object formt the Firestore dictionary
                        guard let location = LocationFirestore.init(dictionary: document.data()) else {
                            
                            print("ERROR: a nil value found for location in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 221.")
                            
                            return
                        }
                        // append the location to the search results array
                        self.searchResults.append(location)
                        // reload the tableView dataSource
                        self.searchResultsTableViewOutlet.reloadData()
                        // show the table view with its results
                        self.searchResultsTableViewOutlet.isHidden = false
                        
                    }
                }
                
            } else if nameSearch != "" && locationSearch == "" {
                
                // it can be acceptable to search only by name
                db.collectionGroup("locations").whereField("locationName", isEqualTo: nameSearch).getDocuments { (snapshopt, error) in
                    
                    if let error = error {
                        print("ERROR: \(error.localizedDescription) - a nil value found for locations in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 185.")
                    }
                    
                    print("there are \(snapshopt?.documents.count ?? 987654321) retrieved by the locations collection group query")
                    for document in snapshopt?.documents ?? [] {
                        
                        print("\(document.data())")
                        
                        // create the location object formt the Firestore dictionary
                        guard let location = LocationFirestore.init(dictionary: document.data()) else {
                            
                            print("ERROR: a nil value found for location in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 221.")
                            
                            return
                        }
                        // append the location to the search results array
                        self.searchResults.append(location)
                        // reload the tableView dataSource
                        self.searchResultsTableViewOutlet.reloadData()
                        // show the table view with its results
                        self.searchResultsTableViewOutlet.isHidden = false
                        
                    }
                }
                
            } else if nameSearch == "" && locationSearch != "" {
                
                // it can be accptable to only search via location
                db.collectionGroup("locations").whereField("city", isEqualTo: locationSearch).getDocuments { (snapshopt, error) in
                    
                    if let error = error {
                        print("ERROR: \(error.localizedDescription) - a nil value found for locations in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 185.")
                    }
                    
                    print("there are \(snapshopt?.documents.count ?? 987654321) retrieved by the locations collection group query")
                    for document in snapshopt?.documents ?? [] {
                        
                        print("\(document.data())")
                        
                        // create the location object formt the Firestore dictionary
                        guard let location = LocationFirestore.init(dictionary: document.data()) else {
                            
                            print("ERROR: a nil value found for location in FindYourAcademyVC.swift -> tableView(tableView: cellForRowAt) - line 221.")
                            
                            return
                        }
                        // append the location to the search results array
                        self.searchResults.append(location)
                        // reload the tableView dataSource
                        self.searchResultsTableViewOutlet.reloadData()
                        // show the table view with its results
                        self.searchResultsTableViewOutlet.isHidden = false
                        
                    }
                }
                
            } else if nameSearch == "" && locationSearch == "" {
                
                // ERROR case
                pleaseFindAcademyLabelOutlet.text = "please find your academy"
                pleaseFindAcademyLabelOutlet.textColor = beltBuilder.redBeltRed
                // fire haptic feedback for error
                hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                
                nameSearchTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationName.rawValue, attributes: beltBuilder.errorAvenirFont)
                
                locationSearchTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.locationSearch.rawValue, attributes: beltBuilder.errorAvenirFont)
                
            }
        }
        
        return true
    }
}


