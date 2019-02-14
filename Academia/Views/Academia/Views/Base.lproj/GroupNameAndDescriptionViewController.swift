//
//  GroupNameAndDescriptionViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class GroupNameAndDescriptionViewController: UIViewController {

    // MARK: - Properties
    
    var groupName: String?
    var active: Bool = true
    var groupDescription: String?
    
    var inEditingMode: Bool?
    var groupToEdit: Group?
    
    let beltBuilder = BeltBuilder()
    
    // welcome label outlets
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    // payment program info outlets
    @IBOutlet weak var groupNameLabelOutlet: UILabel!
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
        
        //populateCompletedProfileInfo()
    }
    
    
    // MARK: - Actions
    
    @IBAction func activeSwitchToggled(_ sender: UISwitch) {
        
        active = !active
        
        print("GroupNameAndDescriptionVC active property: \(active)")
    }
    
    @IBAction func tapAnywhereToDismissTapped(_ sender: Any) {
        view.endEditing(true)
        groupDescriptionTextView.resignFirstResponder()
    }
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if groupNameTextField.isFirstResponder {
            groupNameTextField.resignFirstResponder()
        } else if groupDescriptionTextView.isFirstResponder {
            groupDescriptionTextView.resignFirstResponder()
        }
        
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
        
        // programmatically performing the segue
      
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toAddStudentsToGroup") as! AddStudentsToGroupTableViewController
        
        // run check to see is there is a paymentProgramName
        guard groupNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        groupName = groupNameTextField.text
        groupDescription = groupDescriptionTextView.text
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
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
        
        if textField == groupNameTextField {
            groupNameTextField.resignFirstResponder()
            print("Next button tapped")
        }
        return true
    }
}
