//
//  ClassDayViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/20/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class ClassDayViewController: UIViewController {

    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool = true
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays] = []
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
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
        
        //populateCompletedProfileInfo()
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // TODO: - run desired checks for the days of the week selected
        
        if daysOfTheWeek.isEmpty {
            
            welcomeMessageLabelOutlet.textColor = beltBuilder.redBeltRed
            
        } else {
            
            updateAulaInfo()
            
            self.returnToClassInfo()
            
            print("update group name: \(String(describing: self.aulaToEdit?.aulaName))")
            
            inEditingMode = false
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
            
            welcomeMessageLabelOutlet.textColor = beltBuilder.redBeltRed
            
            return false
            
        } else {
            
            return true
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        // confirm appropriate segue via segue.identifier
        if segue.identifier == "toAulaTime" {
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassTimeViewController else { return }
            
            // pass data to destViewController
            destViewController.daysOfTheWeek = daysOfTheWeek
            destViewController.aulaName = aulaName
            destViewController.active = active
            destViewController.aulaDescription = aulaDescription
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaToEdit = aulaToEdit
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
        
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension ClassDayViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        guard let aula = aulaToEdit else { return }
        // group update info
        if daysOfTheWeek.isEmpty != true {
            AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: daysOfTheWeek, instructor: nil, ownerInstructor: nil, location: nil, students: nil, time: nil)
            print("update group name: \(AulaModelController.shared.aulas[0].aulaName)")
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
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
        guard let aulaToEdit = aulaToEdit else {
            return
        }
        
        welcomeMessageLabelOutlet.text = "Aula: \(aulaToEdit.aulaName)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        
        // TODO: build a switch statement to check the weekday, and set the day of the week button to checked if the corresponding day of the week

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
