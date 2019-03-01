//
//  GroupNameAndDescriptionViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class GroupNameAndDescriptionViewController: UIViewController, UITextInputTraits  {

    // MARK: - Properties
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    let groupDescriptionTextViewPlaceholderString = PlaceholderStrings.groupDescription.rawValue
    
    // welcome label outlets
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    // payment program info outlets
    @IBOutlet weak var groupNameTextField: UITextField!
    // active switch + details
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    // program description textView
    @IBOutlet weak var groupDescriptionTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // turns off auto-correct in these UITextFields
        groupNameTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        groupNameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
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
        
        groupNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.groupName.rawValue, attributes: beltBuilder.avenirFont)
        groupDescriptionTextView.attributedText = NSAttributedString(string: groupDescriptionTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        
        groupNameTextField.delegate = self
        groupDescriptionTextView.delegate = self
        
        //populateCompletedProfileInfo()
    }
    
    
    // MARK: - Actions
    
    @IBAction func activeSwitchToggled(_ sender: UISwitch) {
        
        active = !active
        
        print("GroupNameAndDescriptionVC active property: \(active)")
    }
    
    @IBAction func tapAnywhereToDismissTapped(_ sender: Any) {
        view.endEditing(true)
        // dismiss keyboard when leaving VC scene
        if groupNameTextField.isFirstResponder {
            groupNameTextField.resignFirstResponder()
        } else if groupDescriptionTextView.isFirstResponder {
            groupDescriptionTextView.resignFirstResponder()
        }
    }
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if groupNameTextField.isFirstResponder {
            groupNameTextField.resignFirstResponder()
        } else if groupDescriptionTextView.isFirstResponder {
            groupDescriptionTextView.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if groupNameTextField.text == "" {
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            groupNameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.groupName.rawValue, attributes: beltBuilder.errorAvenirFont)
            
            // save not allowed, so we exit function
            return
        }
        
        // reset textField placeholder text color to gray upon succesful save
        groupNameTextField.attributedPlaceholder = NSAttributedString(string: groupDescriptionTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        
        // Location update profile info
        if groupNameTextField.text != "" {
            
            updateGroupInfo()
            
            self.returnToGroupInfo()
            
            print("update group name: \(String(describing: self.groupToEdit?.name))")
        }
        inEditingMode = false
    }

    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if groupNameTextField.isFirstResponder {
            groupNameTextField.resignFirstResponder()
        } else if groupDescriptionTextView.isFirstResponder {
            groupDescriptionTextView.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if groupNameTextField.text == "" {
            
            // warning to user where welcome instructions text changes to red
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            groupNameTextField.attributedPlaceholder = NSAttributedString(string: groupDescriptionTextViewPlaceholderString, attributes: beltBuilder.errorAvenirFont)
            
            // save not allowed, so we exit function
            return
        }
        
        // reset textField placeholder text color to gray upon succesful save
        groupNameTextField.attributedPlaceholder = NSAttributedString(string: groupDescriptionTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        
        // programmatically performing the segue
      
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toAddStudentsToGroup") as! AddStudentsToGroupTableViewController
        
        // required field
        let groupName = groupNameTextField.text
        // not a required field
        let groupDescription = groupDescriptionTextView.text
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass data to destViewController
        destViewController.groupName = groupName
        destViewController.active = active
        destViewController.groupDescription = groupDescription
        
        destViewController.inEditingMode = inEditingMode
        destViewController.groupToEdit = groupToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateGroupInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension GroupNameAndDescriptionViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateGroupInfo() {
        guard let group = groupToEdit else { return }
        // group update info
        if groupNameTextField.text != "" {
            GroupModelController.shared.update(group: group, active: active, name: groupNameTextField.text, description: groupDescriptionTextView.text, kidMembers: nil, adultMembers: nil, kidStudent: nil, adultStudent: nil)
            print("update group name: \(GroupModelController.shared.groups[0].name)")
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            groupEditingSetup()
        }
        
        print("GroupNameAndDescriptionVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func groupEditingSetup() {
        
        guard let groupToEdit = groupToEdit else {
            return
        }
        
        welcomeLabelOutlet.text = "Group: \(groupToEdit.name)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in group editing mode"
        
        groupDescriptionTextView.text = groupToEdit.description
        groupNameTextField.text = groupToEdit.name
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension GroupNameAndDescriptionViewController: UITextFieldDelegate, UITextViewDelegate {
    
    // method to call in viewWillAppear() to subscribe to desired UIResponder keyboard notifications
    func subscribeToKeyboardNotifications() {
        
        // notifications unique to keyboard itself
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // notifications unique to editing of programDescriptionTextView text
        NotificationCenter.default.addObserver(self, selector: #selector(texfViewWillEdit(notificaiton:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(texfViewWillEdit(notificaiton:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    // method to be called in viewWillDisappear() to unsubscribe from desired UIResponder keyboard notifications
    func unsubscribeToKeyboardNotifications() {
        
        // notifications unique to keyboard itself
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // notifications unique to editing of programDescriptionTextView text
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: nil)
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
    
    // funciton to handle UITextView user editing
    @objc func texfViewWillEdit(notificaiton: Notification) {
        
        // check for start of editing with placeholder text in place
        if notificaiton.name == UITextView.textDidBeginEditingNotification && groupDescriptionTextView.text == groupDescriptionTextViewPlaceholderString {
            
            // change to input fontstyle and empty textView.text ready for user input
            groupDescriptionTextView.font = UIFont(name: "Avenir-Light", size: 16)
            groupDescriptionTextView.text = ""
            
            // check for end of editing and no user input
        } else if notificaiton.name == UITextView.textDidEndEditingNotification && groupDescriptionTextView.text == "" {
            
            // reset to placeholder text
            groupDescriptionTextView.attributedText = NSAttributedString(string: groupDescriptionTextViewPlaceholderString, attributes: beltBuilder.avenirFont)
        }
    }
    
    // UITextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == groupNameTextField {
            groupNameTextField.resignFirstResponder()
            print("Next button tapped")
        }
        return true
    }
}
