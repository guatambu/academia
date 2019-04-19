//
//  SignUpLoginViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//


// TODO: - update this VC for editing mode.  follow the compiler errors

import UIKit
import CoreData

class SignUpLoginViewController: UIViewController, UITextInputTraits {
    
    // MARK: - Properties
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    var inEditingMode: Bool?
    var userCDToEdit: Any?
    
    var delegate: InitialStudentSegueDelegate!
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsOutlet: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    // CoreData Properties
    var owner: OwnerCD?
    var studentAdult: StudentAdultCD?
    var studentKid: StudentKidCD?
    var groupCD: GroupCD?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // turns off auto-correct in these UITextFields
        usernameTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        usernameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        confirmPasswordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // turns on secure text entry in password and confirm password textFields
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // establish Sign Up button text for new user
        signUpButtonOutlet.setTitle("Sign Up", for: UIControl.State.normal)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        guard let isOwner = isOwner else { return }
        
        if isOwner{
            welcomeMessageOutlet.text = "Welcome Owner"
        } else {
            welcomeMessageOutlet.text = "Welcome New Student"
        }
        
        confirmPasswordTextField.isEnabled = true
        confirmPasswordTextField.isHidden = false
        
        welcomeMessageOutlet.textColor = beltBuilder.blackBeltBlack
        
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.avenirFont)
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.confirmPassword.rawValue, attributes: beltBuilder.avenirFont)
        
        guard let _ = username, let _ = password else {
            
            if isOwner {
                welcomeMessageOutlet.text = "Welcome New Owner"
                welcomeInstructionsOutlet.text = "please create a username and password"
                signUpButtonOutlet.setTitle("Sign Up", for: UIControl.State.normal)
            } else {
                welcomeMessageOutlet.text = "Welcome New Student"
                welcomeInstructionsOutlet.text = "please create a username and password"
                signUpButtonOutlet.setTitle("Sign Up", for: UIControl.State.normal)
            }
            
            return
        }
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // dismiss keyboard when leaving VC scene
        if usernameTextField.isFirstResponder {
            usernameTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        } else if confirmPasswordTextField.isFirstResponder {
            confirmPasswordTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if usernameTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" {
            
            checkForEmptyTextFields()
            
            // save not allowed, so we exit function
            return
        }
        
        // check to see if there is a valid and matching password
        if self.passwordTextField.text == "" {
            welcomeInstructionsOutlet.text = "please create a password"
            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.errorAvenirFont)
            
            return
        } else if self.confirmPasswordTextField.text == "" {
            welcomeInstructionsOutlet.text = "please confirm your password"
            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.confirmPassword.rawValue, attributes: beltBuilder.errorAvenirFont)
            
            return
        } else if self.passwordTextField.text != self.confirmPasswordTextField.text {
            welcomeInstructionsOutlet.text = "your passwords do not match."
            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            return
        } else if self.passwordTextField.text == self.confirmPasswordTextField.text {
            // if valid password update profile and segue back to user's InfoDetailsVC
            if let isOwner = isOwner {
                
                if isOwner {
                    // Owner update profile info
                    updateOwnerInfo()
                    
                    self.returnToOwnerInfo()
                }
            }
            if let isKid = isKid {
                
                if isKid{
                    // kidStudent update profile info
                    updateKidStudentInfo()
                    
                    self.returnToStudentInfo()
                    
                } else {
                    // adultStudent update profile info
                    updateAdultStudentInfo()
                    
                    self.returnToStudentInfo()
                }
            }
            
            inEditingMode = false
            
            // reset textfield placeholder text color to gray upon succesful save
            usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.avenirFont)
            passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.avenirFont)
            
        }
    }
    
    @IBAction func tapAnywhereToDismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        // dismiss keyboard when leaving VC scene
        if usernameTextField.isFirstResponder {
            usernameTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        } else if confirmPasswordTextField.isFirstResponder {
            confirmPasswordTextField.resignFirstResponder()
        }
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        // dismiss keyboard when leaving VC scene
        if usernameTextField.isFirstResponder {
            usernameTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        } else if confirmPasswordTextField.isFirstResponder {
            confirmPasswordTextField.resignFirstResponder()
        }
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toTakeProfilePic") as! TakeProfilePicViewController
        
        // check for required information being left blank by user
        if usernameTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" {
            
            checkForEmptyTextFields()
            
            // save not allowed, so we exit function
            return
        }
        
        // run check to see is there is username/password
        guard let username = username, let password = password else {
            // if no username/password -
                // pass new username & confirmed password to destViewController
            // check to see if there is valid username
            guard let newUsername = self.usernameTextField.text, self.usernameTextField.text != "" else {
                // warning to user where welcome instructions text changes to red
                welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
                // fire haptic feedback for error
                hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                
                usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.errorAvenirFont)
                
                return
            }
            
            // check to see if there is a valid and matching password
            if self.passwordTextField.text == "" {
                welcomeInstructionsOutlet.text = "please create a password"
                welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
                // fire haptic feedback for error
                hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.errorAvenirFont)
                
                return
            } else if self.confirmPasswordTextField.text == "" {
                welcomeInstructionsOutlet.text = "please confirm your password"
                welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
                // fire haptic feedback for error
                hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                
                confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.confirmPassword.rawValue, attributes: beltBuilder.errorAvenirFont)
                
                return
            } else if self.passwordTextField.text != self.confirmPasswordTextField.text {
                welcomeInstructionsOutlet.text = "your passwords do not match."
                welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
                // fire haptic feedback for error
                hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                return
            } else if self.passwordTextField.text == self.confirmPasswordTextField.text {
                // if valid password, pass it to destViewController
                guard let newPassword = self.passwordTextField.text else { return }
                destViewController.password = newPassword
            }
            
            // create the segue programmatically to TakeProfilePicViewController
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
            destViewController.isOwner = isOwner
            destViewController.isKid = isKid
            destViewController.username = newUsername
            destViewController.isOwnerAddingStudent = isOwnerAddingStudent
            destViewController.group = group
            destViewController.inEditingMode = inEditingMode
            destViewController.userCDToEdit = userCDToEdit
            
            // pass CoreData Properties
            guard let newPassword = self.passwordTextField.text else { return }
            
            destViewController.groupCD = groupCD
            
            if let owner = owner {
                
                owner.username = newUsername
                owner.password = newPassword
                destViewController.ownerCD = owner
                
            } else if let studentAdult = studentAdult  {
                
                studentAdult.username = newUsername
                studentAdult.password = newPassword
                destViewController.studentAdultCD = studentAdult
                
            } else if let studentKid = studentKid  {
                
                studentKid.username = newUsername
                studentKid.password = newPassword
                destViewController.studentKidCD = studentKid
            }
            
            // reset welcome instructions text color and message upon succesful save
            welcomeInstructionsOutlet.textColor = beltBuilder.blackBeltBlack
            welcomeInstructionsOutlet.text = "please enter the following"

            return
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        if let isOwner = isOwner {
            if isOwner {
                updateOwnerInfo()
            }
        }
        if let isKid = isKid {
            if isKid {
                updateKidStudentInfo()
            } else {
                updateAdultStudentInfo()
            }
        }
        
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        destViewController.groupCD = groupCD
        
        // if usermame/password - login
        
        // create the segue programmatically to TakeProfilePicViewController
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // reset welcome instructions text color and message upon succesful save
        welcomeInstructionsOutlet.textColor = beltBuilder.blackBeltBlack
        welcomeInstructionsOutlet.text = "please enter the following"
        // reset textfield placeholder text color to gray upon succesful save
        usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.avenirFont)
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.confirmPassword.rawValue, attributes: beltBuilder.avenirFont)
        
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension SignUpLoginViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        
        // Owner update profile info
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            // CoreData Owner update profile info
            guard let ownerCD = userCDToEdit as? OwnerCD else { return }
            
            OwnerCDModelController.shared.update(owner: ownerCD, isInstructor: nil, birthdate: nil, mostRecentPromotion: nil, belt: nil, profilePic: nil, username: usernameTextField.text, password: passwordTextField.text, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
            
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
    }
    
    func updateKidStudentInfo() {
        
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            // CoreData Owner update profile info
            guard let studentKidCD = userCDToEdit as? StudentKidCD else { return }
            
                
            StudentKidCDModelController.shared.update(studentKid: studentKidCD, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: usernameTextField.text, password: passwordTextField.text, firstName: nil, lastName: nil, parentGuardian: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
            
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
    }
    
    func updateAdultStudentInfo() {
        
        // adultStudent update profile info
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            // CoreData Owner update profile info
            guard let studentAdultCD = userCDToEdit as? StudentAdultCD else { return }
                
            StudentAdultCDModelController.shared.update(studentAdult: studentAdultCD, isInstructor: nil, birthdate: nil, mostRecentPromotion: nil, studentStatus: nil, belt: nil, profilePic: nil, username: usernameTextField.text, password: passwordTextField.text, firstName: nil, lastName: nil, address: nil, phone: nil, mobile: nil, email: nil, emergencyContact: nil)
            
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            // add Save to right hand side of NavBar
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            // change text on the Sign Up Button to "Next" for existing user in editing mode
            signUpButtonOutlet.setTitle("Next", for: UIControl.State.normal)
            
            if let isOwner = isOwner {
                if isOwner {
                    ownerEditingSetup(userToEdit: userCDToEdit)
                }
            }
            if let isKid = isKid {
                if isKid {
                    kidStudentEditingSetup(userToEdit: userCDToEdit)
                } else {
                    adultStudentEditingSetup(userToEdit: userCDToEdit)
                }
            }
        }
        
        print("SignUpLoginVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerCDToEdit = userToEdit as? OwnerCD else {
            return
        }
        
        welcomeMessageOutlet.text = "Welcome \(ownerCDToEdit.firstName ?? "")"
        
        usernameTextField.text = ownerCDToEdit.username
        passwordTextField.text = ownerCDToEdit.password
        confirmPasswordTextField.text = ownerCDToEdit.password
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? StudentKidCD else {
            return
        }
        
        welcomeMessageOutlet.text = "Welcome \(kidToEdit.firstName ?? "")"
        
        usernameTextField.text = kidToEdit.username
        passwordTextField.text = kidToEdit.password
        confirmPasswordTextField.text = kidToEdit.password
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? StudentAdultCD else {
            return
        }
        
        welcomeMessageOutlet.text = "Welcome \(adultToEdit.firstName ?? "")"
        
        usernameTextField.text = adultToEdit.username
        passwordTextField.text = adultToEdit.password
        confirmPasswordTextField.text = adultToEdit.password
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension SignUpLoginViewController: UITextFieldDelegate {
    
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
                
                self.view.frame.origin.y = -(keyboardCGRectValue.height)
            }
        
        } else {
            
            self.view.frame.origin.y = 0
        }
        
    }
    
    // UITextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
            print("Next button tapped")

        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
            print("Next button tapped")

        } else if textField == confirmPasswordTextField {
            textField.resignFirstResponder()
            print("Done button tapped")
        }
        return true
    }
}


// MARK: - funcitons to check for user input error
extension SignUpLoginViewController {
    
    // empty textfield check
    func checkForEmptyTextFields() {
        // warning to user where welcome instructions text changes to red
        welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
        
        // fire haptic feedback for error
        hapticFeedbackGenerator = UINotificationFeedbackGenerator()
        hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
        
        // warnings for specific textfield being left blank by user
        if usernameTextField.text == "" {
            
            usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.errorAvenirFont)
            
        } else {
            
            usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.avenirFont)
            
        }
        
        if passwordTextField.text == "" {
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.errorAvenirFont)
            
        } else {
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.avenirFont)
            
        }
        
        if confirmPasswordTextField.text == "" {
            
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.confirmPassword.rawValue, attributes: beltBuilder.errorAvenirFont)
            
        } else {
            
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.confirmPassword.rawValue, attributes: beltBuilder.avenirFont)
            
        }
    }
    
    // passwords check
//    func passwordErrorCheck() {
//        // check to see if there is a valid and matching password
//        if self.passwordTextField.text == "" {
//            welcomeInstructionsOutlet.text = "please create a password"
//            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
//            // fire haptic feedback for error
//            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
//            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//
//            passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.errorAvenirFont)
//
//            return
//        } else if self.confirmPasswordTextField.text == "" {
//            welcomeInstructionsOutlet.text = "please confirm your password"
//            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
//            // fire haptic feedback for error
//            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
//            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//
//            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.confirmPassword.rawValue, attributes: beltBuilder.errorAvenirFont)
//
//            return
//        } else if self.passwordTextField.text != self.confirmPasswordTextField.text {
//            welcomeInstructionsOutlet.text = "your passwords do not match."
//            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
//            // fire haptic feedback for error
//            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
//            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            return
//        }
//    }
}
