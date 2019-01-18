//
//  ClassLocationAndTimeViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassLocationAndTimeViewController: UIViewController, DaysOfTheWeekDelegate, TimeOfDayDelegate, AulaLocationDelegate  {

    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays] = []
    var times: [String] = []
    var locations: [Location] = []
    
    // mock data for locations' local surce of truth
    let mockLocations = [MockData.myLocation, MockData.myLocation]
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // instances
    let beltBuilder = BeltBuilder()
    let classTimeComponents = ClassTimeComponents()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var daysOfTheWeekLabelOutlet: UILabel!
    @IBOutlet weak var classTimeDetailsLabelOutlet: UILabel!
    @IBOutlet weak var classLocationLabelOutlet: UILabel!
    
    // collectionViews
    @IBOutlet weak var daysOfTheWeekCollectionView: UICollectionView!
    @IBOutlet weak var timeOfDayCollectionView: UICollectionView!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up collection views dataSources and delegates
        daysOfTheWeekCollectionView.dataSource = self
        daysOfTheWeekCollectionView.delegate = self
        
        timeOfDayCollectionView.dataSource = self
        timeOfDayCollectionView.delegate = self
        
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        
        //populateCompletedProfileInfo()
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("no aulaName, active, or aulaDescription passed to: ClassLocationAndTimeVC -> viewDidLoad() - line 73")
            return
        }
        
        print("program name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        guard daysOfTheWeek.isEmpty != true && times.isEmpty != true && locations.isEmpty != true else {
            
            print("ERROR: daysOfTheWeek, times, or locations isEmpty")
            
            return
        }
            
        updateAulaInfo()
        
        self.returnToPaymentProgramInfo()
        
        print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        
        inEditingMode = false
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toClassInsructors") as! ClassInstructorsTableViewController
        
        // run check to see is there is a aula day of the week, time of day, and location
        guard daysOfTheWeek.isEmpty != true, times.isEmpty != true, locations.isEmpty != true else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
//        daysOfTheWeek =
//        timeOfDay =
//        location =
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.aulaName = aulaName
        destViewController.active = active
        destViewController.aulaDescription = aulaDescription
        
        destViewController.inEditingMode = inEditingMode
        destViewController.aulaToEdit = aulaToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
    }

}


// MARK: - Editing Mode for Individual User case specific setup
extension ClassLocationAndTimeViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        guard let aula = aulaToEdit else { return }

        // class update info
       
        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: daysOfTheWeek, instructor: nil, ownerInstructor: nil, locations: locations, students: nil, times: times)
        print("update class day of the week: \(AulaModelController.shared.aulas[0].daysOfTheWeek)")
        
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
        
        welcomeMessageLabelOutlet.text = "Aula: \(aulaToEdit.aulaName)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        daysOfTheWeek = aulaToEdit.daysOfTheWeek
        times = aulaToEdit.times ?? []
        locations = aulaToEdit.locations ?? []
        
        daysOfTheWeekCollectionView.reloadData()
        timeOfDayCollectionView.reloadData()
        locationCollectionView.reloadData()
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - UICollectionView Protocol Conformance & Methods
extension ClassLocationAndTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // day of the week collecitonView
        if collectionView.tag == 20 {
            return classTimeComponents.weekdaysArray.count
        // time of day collectionView
        } else if collectionView.tag == 30 {
            return classTimeComponents.hoursArray.count
        // locations collectionView
        } else if collectionView.tag == 40 {
            return mockLocations.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // day of the week collecitonView
        if collectionView.tag == 20 {
            guard let cell = daysOfTheWeekCollectionView.dequeueReusableCell(withReuseIdentifier: "daysOfTheWeekCollectionCell", for: indexPath) as? DaysOfTheWeekCollectionViewCell else {
                print("ERROR: failure to create dayOfTheWeek collection cell")
                return UICollectionViewCell()
            }
            // set the DaysOfTheWeekDelegate for the DaysOfTheWeekCollectionViewCell
            cell.delegate = self

            cell.day = classTimeComponents.weekdaysArray[indexPath.row]
            cell.selectedDaysOfTheWeek = aulaToEdit?.daysOfTheWeek

            return cell

        // time of day collectionView
        } else if collectionView.tag == 30 {

            guard let cell = timeOfDayCollectionView.dequeueReusableCell(withReuseIdentifier: "timeOfDayCollectionCell", for: indexPath) as? TimeOfDayCollectionViewCell else {
                print("ERROR: failure to create timeOfDay collection cell")
                return UICollectionViewCell()
            }
            // set the TimeOfDayDelegate for the TimeOfDayCollectionViewCell
            cell.delegate = self

            cell.timeOfDay = classTimeComponents.hoursArray[indexPath.row]
            cell.selectedTimesOfDay = aulaToEdit?.times

            return cell

        // locations collectionView
        } else if collectionView.tag == 40 {

            guard let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "locationCollectionCell", for: indexPath) as? LocationCollectionViewCell else {
                print("ERROR: failure to create locations collection cell")
                return UICollectionViewCell()
            }
            // set the LocationDelegate for the LocationCollectionViewCell
            cell.delegate = self

            cell.location = mockLocations[indexPath.row]
            cell.selectedLocations = aulaToEdit?.locations

            return cell

        }
        return UICollectionViewCell()
    }
    
}



