//
//  ClassNameAndDescriptionViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

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
        
        subscribeToKeyboardNotifications()
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classNameTextField.delegate = self
        classDescriptionTextView.delegate = self
        
        // populate lastChangedLabelOutlet with formatted current date and time at time of aula creation
        let currentDateAndTime = Date()
        formatLastChanged(lastChanged: currentDateAndTime)
    }
    
    
    // MARK: - Actions
    
    @IBAction func activeSwitchToggled(_ sender: UISwitch) {
        
        active = !active
        
        print("GroupNameAndDescriptionVC active property: \(active)")
    }
    
    @IBAction func tapAnywhereToDismissTapped(_ sender: Any) {
        view.endEditing(true)
        classDescriptionTextView.resignFirstResponder()
    }
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if classNameTextField.isFirstResponder {
            classNameTextField.resignFirstResponder()
        } else if classDescriptionTextView.isFirstResponder {
            classDescriptionTextView.resignFirstResponder()
        }
        
        // Location update profile info
        if classNameTextField.text != "" {
            
            updateAulaInfo()
            
            self.returnToClassInfo()
            
            print("update aula name: \(String(describing: self.aulaToEdit?.aulaName))")
        }
        inEditingMode = false
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // check for errors before performing segue, and if error, block navigation
        if classNameTextField.text == "" {
            
            welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
            
            return false
            
        } else {
            
            return true
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // confirm appropriate segue via segue.identifier
        if segue.identifier == "toClassDayOfTheWeek" {
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassDayViewController else { return }
            
            // pass data to destViewController
            destViewController.aulaName = classNameTextField.text
            destViewController.active = active
            destViewController.aulaDescription = classDescriptionTextView.text
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaToEdit = aulaToEdit
            
            // dismiss keyboard when leaving VC scene
            if classNameTextField.isFirstResponder {
                classNameTextField.resignFirstResponder()
            } else if classDescriptionTextView.isFirstResponder {
                classDescriptionTextView.resignFirstResponder()
            }
        }
        
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassNameAndDescriptionViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        guard let aula = aulaToEdit else { return }
        // group update info
        if classNameTextField.text != "" {
            AulaModelController.shared.update(aula: aula, active: active, kidAttendees: nil, adultAttendees: nil, aulaDescription: classDescriptionTextView.text, aulaName: classNameTextField.text, daysOfTheWeek: nil, instructor: nil, ownerInstructor: nil, location: nil, students: nil, time: nil, timeCode: nil, classGroups: nil)
            print("update aula name: \(AulaModelController.shared.aulas[0].aulaName)")
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            aulaEditingSetup()
        }
        
        print("ClassNameAndDescriptionVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
        guard let aulaToEdit = aulaToEdit else {
            return
        }
        
        welcomeMessageLabelOutlet.text = "\(aulaToEdit.aulaName)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in class editing mode"
        
        classDescriptionTextView.text = aulaToEdit.aulaDescription
        classNameTextField.text = aulaToEdit.aulaName
        
        active = aulaToEdit.active
        
        if aulaToEdit.active {
            activeSwitch.isOn = true
        } else {
            activeSwitch.isOn = false
        }
    }
}


// MARK: - date formatter setup for lastChanged display
extension ClassNameAndDescriptionViewController {
    
    func formatLastChanged(lastChanged: Date) {
        
        // set up date format
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let lastChangedString = dateFormatter.string(from: lastChanged)
        
        print(lastChangedString)
        
        self.lastChangedLabelOutlet.text = "last change: " + lastChangedString
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension ClassNameAndDescriptionViewController: UITextFieldDelegate, UITextViewDelegate {
    
    // method to call in viewWillAppear() to subscribe to desired UIResponder keyboard notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // method to be called in viewWillDisappear() to unsubscribe from desired UIResponder keyboard notifications
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // keyboardWillChange to handle Keyboard Notifications
    @objc func keyboardWillChange(notification: Notification) {
        
        // uncomment for print statement ensuring this method is properly called
        // print("Keyboard will change: \(notification.name.rawValue) - \(notification.description)")
        
        // get the size of the keyboard
        guard let keyboardCGRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            print("ERROR: nil value for notification.userInfo[UIKeyboardFrameEndUserInfoKey] in SignUpLoginViewController.swift -> keyboardWillChange(notification:) - line 225")
            return
        }
        
        // move view up the height of keyboard and back down to original position
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            // check to see if physical screen includes iPhoneX__ form factor
            if #available(iOS 11.0, *) {
                let bottomPadding = view.safeAreaInsets.bottom
                
                self.view.frame.origin.y = -(keyboardCGRectValue.height - bottomPadding)
                
            } else {
                
                self.view.frame.origin.y = -keyboardCGRectValue.height
            }
            
        } else {
            
            self.view.frame.origin.y = 0
        }
    }
    
    // UITextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == classNameTextField {
            classNameTextField.resignFirstResponder()
            print("Next button tapped")
        }
        return true
    }
}
