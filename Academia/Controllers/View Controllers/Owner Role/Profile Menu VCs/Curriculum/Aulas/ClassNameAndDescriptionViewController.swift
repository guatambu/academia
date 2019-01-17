//
//  ClassNameAndDescriptionViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassNameAndDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool = true
    var aulaDescription: String?
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?

    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var classNameLabelOutlet: UILabel!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var classDescriptionLabelOutlet: UILabel!
    @IBOutlet weak var classDescriptionTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //populateCompletedProfileInfo()
    }
    
    
    // MARK: - Actions
    
    @IBAction func activeSwitchToggled(_ sender: UISwitch) {
        
        active = !active
        
        print("GroupNameAndDescriptionVC active property: \(active)")
    }
    
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        if classNameTextField.text != "" {
            
            updateGroupInfo()
            
            self.returnToClassInfo()
            
            print("update group name: \(String(describing: self.aulaToEdit?.aulaName))")
        }
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toClassLocationAndTime") as! ClassLocationAndTimeViewController
        
        // run check to see is there is a paymentProgramName
        guard classNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        aulaName = classNameTextField.text
        aulaDescription = classDescriptionTextView.text
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
        updateGroupInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension ClassNameAndDescriptionViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateGroupInfo() {
        guard let aula = aulaToEdit else { return }
        // group update info
        if classNameTextField.text != "" {
            AulaModelController.shared.update(aula: aula, active: active, kidAttendees: nil, adultAttendees: nil, aulaDescription: classDescriptionTextView.text, aulaName: classNameTextField.text, daysOfTheWeek: nil, instructor: nil, ownerInstructor: nil, location: nil, students: nil, timeOfDay: nil)
            print("update group name: \(GroupModelController.shared.groups[0].name)")
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            aulaEditingSetup()
        }
        
        print("GroupNameAndDescriptionVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
        guard let aulaToEdit = aulaToEdit else {
            return
        }
        
        welcomeMessageLabelOutlet.text = "Aula: \(aulaToEdit.aulaName)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        classDescriptionTextView.text = aulaToEdit.aulaDescription
        classNameTextField.text = aulaToEdit.aulaName
    }
}
