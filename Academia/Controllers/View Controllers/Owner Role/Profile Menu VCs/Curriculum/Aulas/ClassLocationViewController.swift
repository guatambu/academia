//
//  ClassLocationViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/20/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit
import CoreData

class ClassLocationViewController: UIViewController {

    // MARK: - Properties
    
    // create a fetchedRequestController with predicate to grab the current LocationsCD objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsController: NSFetchedResultsController<LocationCD>!
    
    // MOCK DATA
    var locations = [MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation, MockData.myLocation]
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var time: String?
    var timeCode: Int?
    var location: Location?
    
    // to hold the compiled string for the classLocationLabelOutlet
    var locationString = ""
    
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // instances
    let beltBuilder = BeltBuilder()
    let classTimeComponents = ClassTimeComponents()
    
    @IBOutlet weak var addClassLabelOutlet: UILabel!
    @IBOutlet weak var classLocationLabelOutlet: UILabel!
    
    // class time UIPickerView
    @IBOutlet weak var classLocationPickerView: UIPickerView!
    
    // CoreData Properties
    var aulaCD: AulaCD?
    var aulaCDToEdit: AulaCD?
    
    var locationCD: LocationCD?
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create fetch request and initialize results
        initializeFetchedResultsController()
        
        classLocationPickerView.delegate = self
        classLocationPickerView.dataSource = self
        
        classLocationLabelOutlet.text = locations[classLocationPickerView.selectedRow(inComponent: 0)].locationName
        
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("ERROR: no aulaName, active, or aulaDescription passed to: ClassLocationVC -> viewDidLoad() - line 61")
            return
        }
        
        print("ClassLocationVC \naula name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        if classLocationLabelOutlet.text != "" {

            updateAulaInfo()

            self.returnToClassInfo()
            
            print("update aula location: \(String(describing: self.aulaToEdit?.location?.locationName))")
        }
        inEditingMode = false
    }
    
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // check for errors before performing segue, and if error, block navigation
        if locationCD != nil {
            
            return true
            
        } else {
            
            addClassLabelOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            return false
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // confirm appropriate segue via segue.identifier
        if segue.identifier == "toClassInstructors" {
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassInstructorsTableViewController else { return }
            
            // pass data to destViewController
            destViewController.location = location
            destViewController.time = time
            destViewController.timeCode = timeCode
            destViewController.daysOfTheWeek = daysOfTheWeek
            destViewController.aulaName = aulaName
            destViewController.active = active
            destViewController.aulaDescription = aulaDescription
            
            destViewController.locationCD = locationCD
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaToEdit = aulaToEdit
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
        
        // reset addlassLabelOutlet text to black
        addClassLabelOutlet.textColor = beltBuilder.blackBeltBlack
        
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassLocationViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        guard let aula = aulaToEdit else { return }
        
        // class update info
        
        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: nil, instructor: nil, ownerInstructor: nil, location: location, students: nil, time: nil, timeCode: nil, classGroups: nil)
        print("update class location: \(String(describing: AulaModelController.shared.aulas[0].location?.locationName))")
        
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            aulaEditingSetup()
        }
        
        print("ClassLocationAndTimeVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
        guard let aulaToEdit = aulaToEdit else {
            return
        }
        
        guard let locationToEdit = aulaToEdit.location else {
            print("ERROR: nil value found for aula property in  ClassLocationVC -> aulaEditingSetup() - line 177")
            return
        }
        
        addClassLabelOutlet.text = "\(aulaToEdit.aulaName)"
        
        daysOfTheWeek = aulaToEdit.daysOfTheWeek
        time = aulaToEdit.time ?? ""
        location = locationToEdit
        
        // in the classLocationPickerView datasource array, search for the locationToEdit value
        guard let indexPath = locations.firstIndex(of: locationToEdit) else {
            
            print("ERROR: nil value found for indexPath for aulaToeDit.location in  ClassLocationVC -> aulaEditingSetup() - line 193")
            return
        }
        classLocationPickerView.selectRow(indexPath, inComponent: 0, animated: true)
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - UIPickerView Protocol Conformance & Methods
extension ClassLocationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // locations component
        if component == 0 {
//            return locations.count
            
            guard let components = fetchedResultsController.sections else {
                fatalError("No sections in fetchedResultsController")
            }
            let componentInfo = components[component]
            return componentInfo.numberOfObjects
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // locations component
        if component == 0 {
            
            guard let components = fetchedResultsController.fetchedObjects else {
                fatalError("No sections in fetchedResultsController")
            }
            let componentInfo = components[component]
            if let name = componentInfo.locationName {
                
                return "\(name)"
            }
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let locationsCD = fetchedResultsController.fetchedObjects else {
            fatalError("No fetchedObjects in fetchedResultsController")
        }

//        let locationSelected = locations[pickerView.selectedRow(inComponent: 0)]
        let locationSelectedCD = locationsCD[pickerView.selectedRow(inComponent: 0)]
        
        if let name = locationSelectedCD.locationName {
            
            locationString = "\(name)"
        }
        
        classLocationLabelOutlet.text = locationString
        
        locationCD = locationSelectedCD
        
        guard let locationCD = locationCD else {
            print("nil found for location property in ClassLocationViewController.swift -> pickerView(pickerView: didSelectRow:) - line 280.")
            return
        }
        print("location name: \(String(describing: locationCD.locationName))")
        
    }
}


// MARK: - NSFetchedREsultsController initializer method
extension ClassLocationViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationCD")
        let locationNameSort = NSSortDescriptor(key: "locationName", ascending: true)
        
        request.sortDescriptors = [locationNameSort]
        
        let moc = CoreDataStack.context
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<LocationCD>
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}
