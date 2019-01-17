//
//  ClassLocationAndTimeViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassLocationAndTimeViewController: UIViewController {

    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool = true
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var timeOfDay: String?
    var location: Location?
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var classTimeLabelOutlet: UILabel!
    @IBOutlet weak var classTimeDetailsLabelOutlet: UILabel!
    @IBOutlet weak var classLocationLabelOutlet: UILabel!
    @IBOutlet weak var classLocationDetailsLabelOutlet: UILabel!
    @IBOutlet weak var classLocationTimePickerView: UIPickerView!
    
    
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
        
        // run check to see is there is a paymentProgramName
        guard classLocationDetailsLabelOutlet.text != "", classTimeLabelOutlet.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        daysOfTheWeek = 
        timeOfDay =
        location =
        
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


// MARK: - PickerView Functionality
extension ClassLocationAndTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // PickerView DataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let isKid = isKid else { return 0 }
        
        if component == 0 {
            // LOATION
            switch {}
            
        } else if component == 1 {
            // WEEKDAGY
            switch {}
            
        } else if component == 2 {
            // Time OF DAY
            switch {}
        }
        
        return 0
    }
    
    // PickerView Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let isKid = isKid else { return nil }
        
        if component == 0 {
            // LOCATION
            switch {}
            
        } else if component == 1 {
            // WEEKDAY
            switch  {}
        
        } else if component == 2 {
            // TIME OF DAY
            switch {}
            
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if component == 0 {
            // LOCATION
            switch {}
            
        } else if component == 1 {
            // WEEKDAY
            switch {
                
            }
        } else if component == 2 {
            // TIME OF DAY
            switch {}
            
        }
    }
}
