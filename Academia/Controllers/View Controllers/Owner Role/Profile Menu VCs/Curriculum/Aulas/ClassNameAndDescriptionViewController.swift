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
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil

    let classDescriptionTextViewPlaceholderString = PlaceholderStrings.classDescription.rawValue
    
    // IBOutlets
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var classDescriptionTextView: UITextView!
    
    // CoreData properties
    var aulaCDToEdit: AulaCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.className.rawValue, attributes: beltBuilder.avenirFont)
        classDescriptionTextView.attributedText = NSAttributedString(string: PlaceholderStrings.classDescription.rawValue, attributes: beltBuilder.avenirFont)
        
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
        
        // dismiss keyboard when leaving VC scene
        if classNameTextField.isFirstResponder {
            classNameTextField.resignFirstResponder()
        } else if classDescriptionTextView.isFirstResponder {
            classDescriptionTextView.resignFirstResponder()
        }
    }
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if classNameTextField.isFirstResponder {
            classNameTextField.resignFirstResponder()
        } else if classDescriptionTextView.isFirstResponder {
            classDescriptionTextView.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if classNameTextField.text == "" {
            
            // warning to user where welcome instructions text changes to red
            welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            classNameTextField.textColor = beltBuilder.redBeltRed

            // save not allowed, so we exit function
            return
        }
        
        // reset textField placeholder text color to gray upon succesful save
        classNameTextField.textColor = beltBuilder.grayBeltGray
        // reset welcome instructions text color and message upon succesful save
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.blackBeltBlack
        welcomeInstructionsLabelOutlet.text = "please enter the following"
        
        // Location update profile info
        if classNameTextField.text != "" {
            
            updateAulaInfo()
            
            self.returnToClassInfo()
            
            print("update aula name: \(String(describing: self.aulaCDToEdit?.aulaName))")
        }
        inEditingMode = false
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        // check for required information being left blank by user
        if classNameTextField.text == "" {
            
            // warning to user where welcome instructions text changes to red
            welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            classNameTextField.textColor = beltBuilder.redBeltRed
            
            // save not allowed, so we exit function
            return false
            
        } else {
            
            return true
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // confirm appropriate segue via segue.identifier
        if segue.identifier == "toClassDayOfTheWeek" {
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassDayViewController else { return }
            
            // pass data to destViewController
            destViewController.aulaName = classNameTextField.text
            destViewController.active = active
            destViewController.aulaDescription = classDescriptionTextView.text
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaToEdit = aulaToEdit
            destViewController.aulaCDToEdit = aulaCDToEdit
            
            // dismiss keyboard when leaving VC scene
            if classNameTextField.isFirstResponder {
                classNameTextField.resignFirstResponder()
            } else if classDescriptionTextView.isFirstResponder {
                classDescriptionTextView.resignFirstResponder()
            }
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
        
        // reset textField placeholder text color to gray upon succesful save
        classNameTextField.textColor = beltBuilder.grayBeltGray
        // reset welcome instructions text color and message upon succesful save
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.blackBeltBlack
        welcomeInstructionsLabelOutlet.text = "please enter the following"
    }
}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassNameAndDescriptionViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        // group update info
        if classNameTextField.text != "" {
            
            // CoreData version
            guard let aulaCDToEdit = aulaCDToEdit else { return }
            AulaCDModelController.shared.update(aula: aulaCDToEdit, active: active, aulaName: classNameTextField.text, aulaDescription: classDescriptionTextView.text, dayOfTheWeek: nil, timeCode: nil, time: nil)
        }
        OwnerCDModelController.shared.saveToPersistentStorage()
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

        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else {
            return
        }
        
        welcomeMessageLabelOutlet.text = "\(aulaCDToEdit.aulaName ?? "")"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in class editing mode"
        
        classDescriptionTextView.text = "\(aulaCDToEdit.aulaDescription ?? "")"
        classNameTextField.text = "\(aulaCDToEdit.aulaName ?? "")"
        
        active = aulaCDToEdit.active
        
        if aulaCDToEdit.active {
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
        
        // notifications unique to keyboard itself
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // notifications unique to editing of classDescriptionTextView text
        NotificationCenter.default.addObserver(self, selector: #selector(texfViewWillEdit(notificaiton:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(texfViewWillEdit(notificaiton:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    // method to be called in viewWillDisappear() to unsubscribe from desired UIResponder keyboard notifications
    func unsubscribeToKeyboardNotifications() {
        
        // notifications unique to keyboard itself
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // notifications unique to editing of classDescriptionTextView text
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    // keyboardWillChange to handle Keyboard Notifications
    @objc func keyboardWillChange(notification: Notification) {
        
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
    
    // funciton to handle UITextView user editing
    @objc func texfViewWillEdit(notificaiton: Notification) {
        
        // check for start of editing with placeholder text in place
        if notificaiton.name == UITextView.textDidBeginEditingNotification && classDescriptionTextView.text == classDescriptionTextViewPlaceholderString {
            
            // change to input fontstyle and empty textView.text ready for user input
            classDescriptionTextView.font = UIFont(name: "Avenir-Light", size: 16)
            classDescriptionTextView.text = ""
            
            // check for end of editing and no user input
        } else if notificaiton.name == UITextView.textDidEndEditingNotification && classDescriptionTextView.text == "" {
            
            // reset to placeholder text
            classDescriptionTextView.attributedText = NSAttributedString(string: classDescriptionTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
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
