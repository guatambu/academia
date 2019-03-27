//
//  ClassDayViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/20/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.



// TODO: simplify the Aula object to remove the AulaDaysOfTheWeek Entity and make the necessary dayOfThWeek property a simple string value, NOT an Entity relationship


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
        
        editingModeButtonToggle(day: .Sunday)
        sundayButtonOutlet.isSelected = !sundayButtonOutlet.isSelected
        addDayofTheWeek(day: .Sunday)
    }
    
    @IBAction func mondayButtonTapped(_ sender: UIButton) {
        
        editingModeButtonToggle(day: .Monday)
        mondayButtonOutlet.isSelected = !mondayButtonOutlet.isSelected
        addDayofTheWeek(day: .Monday)
    }
    
    @IBAction func tuesdayButtonTapped(_ sender: UIButton) {
        
        editingModeButtonToggle(day: .Tuesday)
        tuesdayButtonOutlet.isSelected = !tuesdayButtonOutlet.isSelected
        addDayofTheWeek(day: .Tuesday)
    }
    
    @IBAction func wednesdayButtonTapped(_ sender: UIButton) {
        
        editingModeButtonToggle(day: .Wednesday)
        wednesdayButtonOutlet.isSelected = !wednesdayButtonOutlet.isSelected
        addDayofTheWeek(day: .Wednesday)
    }
    
    @IBAction func thursdayButtonTapped(_ sender: UIButton) {
        
        editingModeButtonToggle(day: .Thursday)
        thursdayButtonOutlet.isSelected = !thursdayButtonOutlet.isSelected
        addDayofTheWeek(day: .Thursday)
    }
    
    @IBAction func fridayButtonTapped(_ sender: UIButton) {
        
        editingModeButtonToggle(day: .Friday)
        fridayButtonOutlet.isSelected = !fridayButtonOutlet.isSelected
        addDayofTheWeek(day: .Friday)
    }
    
    @IBAction func saturdayButtonTapped(_ sender: UIButton) {
        
        editingModeButtonToggle(day: .Saturday)
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
        
        if let inEditingMode = inEditingMode {
            
            if inEditingMode {
                // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
                updateAulaInfo()
                
                // reset welcome instructions text color and message upon succesful save
                addClassDaysLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
        }
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassDayViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        AulaCDModelController.shared.update(aula: aulaCDToEdit, active: nil, aulaName: nil, aulaDescription: nil, dayOfTheWeek: daysOfTheWeek[0].rawValue, timeCode: nil, time: nil)
        // save the update
        OwnerCDModelController.shared.saveToPersistentStorage()
        
        print("******\naulaCDToEdit.daysOfTheWeek: \(aulaCDToEdit.dayOfTheWeek ?? "")")
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
        
        // make sure the daysOfTheWeek array is empty for editing setup
        daysOfTheWeek = []
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        // set the name of the class
        addClassDaysLabelOutlet.text = "\(aulaCDToEdit.aulaName ?? "")"
        
        // switch on the dayOfTheWeek String property to determine which boxes are to be displayed as checked and which day is to be added to the empty daysOfTheWeek array
        switch aulaCDToEdit.dayOfTheWeek {
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
            print("ERROR: somehow found a value outside of the days of the week in ClassDayViewController.swift -> aulaEditingSetup() - line 304.")
        }
       
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
    
    func editingModeButtonToggle(day: ClassTimeComponents.Weekdays) {
        
        if let inEditingMode = inEditingMode {
            // if in editing mode and there is already a day of the
            if inEditingMode {
                
                let buttons = [sundayButtonOutlet, mondayButtonOutlet, tuesdayButtonOutlet, wednesdayButtonOutlet, thursdayButtonOutlet, fridayButtonOutlet, saturdayButtonOutlet]
                // loop throught the buttons array to see which button isSelected and toggle it off
                
                for button in buttons {
                    if let button = button {
                        
                        if button.isSelected {
                            
                            button.isSelected = !button.isSelected
                            
                        }
                    }
                }
                daysOfTheWeek = []
            }
        }
    }
    
}
