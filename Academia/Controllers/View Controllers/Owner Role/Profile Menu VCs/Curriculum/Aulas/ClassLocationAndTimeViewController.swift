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
    var active: Bool = true
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var times: [String]?
    var locations: [Location]?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toClassInsructors") as! ClassInstructorsTableViewController
        
        // run check to see is there is a aula day of the week, time of day, and location
        guard classLocationDetailsLabelOutlet.text != "", daysOfTheWeekLabelOutlet.text != "" else {
            
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
        
        guard let daysOfTheWeek = daysOfTheWeek, let times = times, let locations = locations else {
            print("ERROR: nil values for daysOfTheWeek, timeOfDay, and location in ClassLocationAndTimeVC.swift -> updateAulaInfo() - line 100")
            return
        }

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
        times = aulaToEdit.times
        locations = aulaToEdit.locations
        
        daysOfTheWeekCollectionView.reloadData()
        timeOfDayCollectionView.reloadData()
        locationCollectionView.reloadData()
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - UICollectionView Protocol Conformance & Methods
extension ClassLocationAndTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 20 {
            return classTimeComponents.weekdaysArray.count
        } else if collectionView.tag == 30 {
            return classTimeComponents.hoursArray.count
        } else if collectionView.tag == 40 {
            return classTimeComponents.minutesArray.count
        }
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if collectionView.tag == 5 {
//            let cell = billingTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionCell", for: indexPath) as! TypeCollectionViewCell
//            // set the BillingTypeDelegate for the TypeCollectionViewCell
//            cell.delegate = self
//
//            cell.billingType = billing.types[indexPath.row]
//            cell.selectedBillingTypes = paymentProgramToEdit?.billingTypes
//
//            return cell
//
//        } else if collectionView.tag == 10 {
//
//            let cell = billingDateCollectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionCell", for: indexPath) as! DateCollectionViewCell
//            // set the BillingDateDelegate for the DateCollectionViewCell
//            cell.delegate = self
//
//            cell.billingDate = billing.dates[indexPath.row]
//            cell.selectedBillingDates = paymentProgramToEdit?.billingDates
//
//            return cell
//
//        } else if collectionView.tag == 15 {
//
//            let cell = signatureTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "SignatureCollectionCell", for: indexPath) as! SignatureCollectionViewCell
//            // set the SignatureTypeDelegate for the SignatureCollectionViewCell
//            cell.delegate = self
//
//            cell.signatureType = billing.signatures[indexPath.row]
//            cell.selectedSignatureTypes = paymentProgramToEdit?.signatureTypes
//
//            return cell
//
//        }
//        return UICollectionViewCell()
//    }
    
}



