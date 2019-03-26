//
//  ClassDayViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/20/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassDayViewController: UIViewController {

    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays] = []
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    let classTimeComponents = ClassTimeComponents()
    let beltBuilder = BeltBuilder()
    let dateFormatter = DateFormatter()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    // IBOutlets
    @IBOutlet weak var addClassDaysLabelOutlet: UILabel!
    // day of the week labels
    @IBOutlet weak var sundayLabelOutlet: UILabel!
    @IBOutlet weak var mondayLabelOutlet: UILabel!
    @IBOutlet weak var tuesdayLabelOutlet: UILabel!
    @IBOutlet weak var wednesdayLabelOutlet: UILabel!
    @IBOutlet weak var thursdayLabelOutlet: UILabel!
    @IBOutlet weak var fridayLabelOutlet: UILabel!
    @IBOutlet weak var saturdayLabelOutlet: UILabel!
    // day of the week buttons
    @IBOutlet weak var sundayButtonOutlet: UIButton!
    @IBOutlet weak var mondayButtonOutlet: UIButton!
    @IBOutlet weak var tuesdayButtonOutlet: UIButton!
    @IBOutlet weak var wednesdayButtonOutlet: UIButton!
    @IBOutlet weak var thursdayButtonOutlet: UIButton!
    @IBOutlet weak var fridayButtonOutlet: UIButton!
    @IBOutlet weak var saturdayButtonOutlet: UIButton!
    
    // CoreData Properties
    var aulaCDToEdit: AulaCD?
    var daysOfTheWeekStrings: [String] = []
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("no aulaName, active, or aulaDescription passed to: ClassDayVC -> viewDidLoad() - line 80")
            return
        }
        
        print("ClassDayVC \naula name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
        //populateCompletedProfileInfo()
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // check for required information being left blank by user
        if daysOfTheWeek.isEmpty {
            
            // warning to user where welcome instructions text changes to red
            addClassDaysLabelOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
        } else {
            
            updateAulaInfo()
            
            self.returnToClassInfo()
            
            print("update group name: \(String(describing: self.aulaToEdit?.aulaName))")
            
            inEditingMode = false
            
            // reset welcome instructions text color and message upon succesful save
            addClassDaysLabelOutlet.textColor = beltBuilder.blackBeltBlack
        }
    }
    
    @IBAction func sundayButtonTapped(_ sender: UIButton) {
        
        sundayButtonOutlet.isSelected = !sundayButtonOutlet.isSelected
        addDayofTheWeek(day: .Sunday)
    }
    
    @IBAction func mondayButtonTapped(_ sender: UIButton) {
        
        mondayButtonOutlet.isSelected = !mondayButtonOutlet.isSelected
        addDayofTheWeek(day: .Monday)
    }
    
    @IBAction func tuesdayButtonTapped(_ sender: UIButton) {
        
        tuesdayButtonOutlet.isSelected = !tuesdayButtonOutlet.isSelected
        addDayofTheWeek(day: .Tuesday)
    }
    
    @IBAction func wednesdayButtonTapped(_ sender: UIButton) {
        
        wednesdayButtonOutlet.isSelected = !wednesdayButtonOutlet.isSelected
        addDayofTheWeek(day: .Wednesday)
    }
    
    @IBAction func thursdayButtonTapped(_ sender: UIButton) {
        
        thursdayButtonOutlet.isSelected = !thursdayButtonOutlet.isSelected
        addDayofTheWeek(day: .Thursday)
    }
    
    @IBAction func fridayButtonTapped(_ sender: UIButton) {
        
        fridayButtonOutlet.isSelected = !fridayButtonOutlet.isSelected
        addDayofTheWeek(day: .Friday)
    }
    
    @IBAction func saturdayButtonTapped(_ sender: UIButton) {
        
        saturdayButtonOutlet.isSelected = !saturdayButtonOutlet.isSelected
        addDayofTheWeek(day: .Saturday)
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // check for errors before performing segue, and if error, block navigation
        if daysOfTheWeek.isEmpty {
            
            // warning to user where welcome instructions text changes to red
            addClassDaysLabelOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            return false
            
        } else {
            
            return true
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        // confirm appropriate segue via segue.identifier
        if segue.identifier == "toClassTime" {
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassTimeViewController else { return }
            
            // pass data to destViewController
            destViewController.daysOfTheWeek = daysOfTheWeek
            destViewController.aulaName = aulaName
            destViewController.active = active
            destViewController.aulaDescription = aulaDescription
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaToEdit = aulaToEdit
            destViewController.aulaCDToEdit = aulaCDToEdit
            
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
        
        // reset welcome instructions text color and message upon succesful save
        addClassDaysLabelOutlet.textColor = beltBuilder.blackBeltBlack
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassDayViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        guard let aula = aulaToEdit else { return }
        // group update info
        if daysOfTheWeek.isEmpty != true {
            AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: daysOfTheWeek, instructor: nil, ownerInstructor: nil, location: nil, students: nil, time: nil, timeCode: nil, classGroups: nil)
            print("update class day: \(AulaModelController.shared.aulas[0].daysOfTheWeek)")
        }
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        // here we want to loop through the daysOfTheWeek array and check the existing corresponding daysOfTheWeekExistingCD NSSet to see if it contains the current iterated member object and if it does NOT, then add that iterated member object to the daysOfTheWeekExistingCD NSSet
        for day in daysOfTheWeek {
            
            // check the aulaCDToEdit.daysOfTheWeek NSSet to see if the daysOfTheWeek array contents are present in the NSSet version
            if let daysOfTheWeekExistingCD = aulaCDToEdit.daysOfTheWeek {
                let predicate = NSPredicate(format: "day == %@", "\(day.rawValue)")
                // using the predicate, return the filtered result to a new NSSet
                let confirmedPresentDaysOfTheWeekNSet = daysOfTheWeekExistingCD.filtered(using: predicate) as NSSet
                
                // if the resulting confirmedPresentDaysOfTheWeekNSet does not have a day in it, then the current iteration of day is not present in the daysOfTheWeekExistingCD NSSet
                if confirmedPresentDaysOfTheWeekNSet.count == 0 {
                    // create a new AulaDaysOfTheWeekCD object from the day iteration
                    let newAulaDayToAddToCD = AulaDaysOfTheWeekCD(day: day.rawValue)
                    // add the newAulaDayToAddToCD to the existing aulaToEdit.daysOfTheWeek property
                    aulaCDToEdit.addToDaysOfTheWeek(newAulaDayToAddToCD)
                }
            }
            // save the update
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            aulaEditingSetup()
        }
        
        print("ClassDayVC -> inEditingMode: \(inEditingMode)")
    }
    
    
    // TODO: - correct data sources for the CoreData versin of the Editing setup here and in entire aula workflow, check the other major data points for the app for this update as well
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
//        guard let aulaToEdit = aulaToEdit else {
//            return
//        }

//        addClassDaysLabelOutlet.text = "\(aulaToEdit.aulaName)"

//        for day in aulaToEdit.daysOfTheWeek {
//
//            switch day {
//            case .Sunday :
//                sundayButtonOutlet.isSelected = true
//                daysOfTheWeek = [.Sunday]
//            case .Monday:
//                mondayButtonOutlet.isSelected = true
//                daysOfTheWeek = [.Monday]
//            case .Tuesday:
//                tuesdayButtonOutlet.isSelected = true
//                daysOfTheWeek = [.Tuesday]
//            case .Wednesday:
//                wednesdayButtonOutlet.isSelected = true
//                daysOfTheWeek = [.Wednesday]
//            case .Thursday:
//                thursdayButtonOutlet.isSelected = true
//                daysOfTheWeek = [.Thursday]
//            case .Friday:
//                fridayButtonOutlet.isSelected = true
//                daysOfTheWeek = [.Friday]
//            case .Saturday:
//                saturdayButtonOutlet.isSelected = true
//                daysOfTheWeek = [.Saturday]
//            }
//        }
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        addClassDaysLabelOutlet.text = "\(aulaCDToEdit.aulaName ?? "")"
        
        // check the aulaCDToEdit.daysOfTheWeek NSSet to see which days are present in its contents
        guard let daysOfTheWeekExistingCD = aulaCDToEdit.daysOfTheWeek else { return }
        // creaete a sort descriptor to then convert the NSSet to a sorted array
        let daySort = NSSortDescriptor(key: "day", ascending: true)
        // sort the NSSet to an array and cast it to an array of AulaDaysOfTheWeekCD type as these are the type of the objects returned by CoreData in the NSSet
        let daysExistingCDArray = daysOfTheWeekExistingCD.sortedArray(using: [daySort]) as! [AulaDaysOfTheWeekCD]
        // loop through the sorted array
        for day in daysExistingCDArray {
            // switching on the AulaDaysOfTheWeekCD.day String property
            switch day.day {
                // wherever a match, append the matched day to the daysOfTheWeek array as enum ClassComponents.Weekdays type to minimize String errors
            case ClassTimeComponents.Weekdays.Sunday.rawValue:
                    sundayButtonOutlet.isSelected = true
                    daysOfTheWeek.append(ClassTimeComponents.Weekdays.Sunday)
            
            case ClassTimeComponents.Weekdays.Monday.rawValue:
                mondayButtonOutlet.isSelected = true
                daysOfTheWeek.append(ClassTimeComponents.Weekdays.Monday)
                
            case ClassTimeComponents.Weekdays.Tuesday.rawValue:
                tuesdayButtonOutlet.isSelected = true
                daysOfTheWeek.append(ClassTimeComponents.Weekdays.Tuesday)
                
            case ClassTimeComponents.Weekdays.Wednesday.rawValue:
                wednesdayButtonOutlet.isSelected = true
                daysOfTheWeek.append(ClassTimeComponents.Weekdays.Wednesday)
                
            case ClassTimeComponents.Weekdays.Thursday.rawValue:
                thursdayButtonOutlet.isSelected = true
                daysOfTheWeek.append(ClassTimeComponents.Weekdays.Thursday)
                
            case ClassTimeComponents.Weekdays.Friday.rawValue:
                fridayButtonOutlet.isSelected = true
                daysOfTheWeek.append(ClassTimeComponents.Weekdays.Friday)
                
            case ClassTimeComponents.Weekdays.Saturday.rawValue:
                saturdayButtonOutlet.isSelected = true
                daysOfTheWeek.append(ClassTimeComponents.Weekdays.Saturday)
                
            default:
                print("ERROR: somehow found a value outside of the days of the week in ClassDayViewController.swift -> aulaEditingSetup() - line 345.")
            }
        }
        
        // create a dictionary to store the weekdays with an ordered corresponding Int vlaue for sorting
        var daysDictionary: [ClassTimeComponents.Weekdays: Int] = [:]
        // loop through a range of 7 Int values that correspond to the 7 day week
        for i in 0...6 {
            daysDictionary[classTimeComponents.weekdaysArray[i]] = i
        }
        // sort the daysOfTheWeek enum type array [ClassTimeComponents.Weekday] according to the numeric values established in the daysDictionary
        daysOfTheWeek.sort { (daysDictionary[$0] ?? 7) < (daysDictionary[$1] ?? 7) }
        // check result in console
        print("sorted days of the week results: \(daysOfTheWeek.map {$0.rawValue})")
    }
}


// MARK: - Helper Functions
extension ClassDayViewController {
    
    func setUpButtons() {
        let normalImage = UIImage(named: "unchecked_box_100.png")
        let selectedImage = UIImage(named: "checked_box_100.png")
        
        sundayButtonOutlet.setImage(normalImage, for: .normal)
        sundayButtonOutlet.setImage(selectedImage, for: .selected)
        
        mondayButtonOutlet.setImage(normalImage, for: .normal)
        mondayButtonOutlet.setImage(selectedImage, for: .selected)
        
        tuesdayButtonOutlet.setImage(normalImage, for: .normal)
        tuesdayButtonOutlet.setImage(selectedImage, for: .selected)
        
        wednesdayButtonOutlet.setImage(normalImage, for: .normal)
        wednesdayButtonOutlet.setImage(selectedImage, for: .selected)
        
        thursdayButtonOutlet.setImage(normalImage, for: .normal)
        thursdayButtonOutlet.setImage(selectedImage, for: .selected)
        
        fridayButtonOutlet.setImage(normalImage, for: .normal)
        fridayButtonOutlet.setImage(selectedImage, for: .selected)
        
        saturdayButtonOutlet.setImage(normalImage, for: .normal)
        saturdayButtonOutlet.setImage(selectedImage, for: .selected)
    }
    
    func addDayofTheWeek(day: ClassTimeComponents.Weekdays) {
        
        if daysOfTheWeek.contains(day) {
            
            daysOfTheWeek = daysOfTheWeek.filter({ $0 != day })
            
            print(daysOfTheWeek)
            
        } else {
            
            daysOfTheWeek.append(day)
            
            print(daysOfTheWeek)
        }
    }
}
