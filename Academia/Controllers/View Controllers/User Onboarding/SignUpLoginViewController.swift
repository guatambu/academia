//
//  SignUpLoginViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class SignUpLoginViewController: UIViewController, UITextInputTraits {
    
    // MARK: - Properties
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    var delegate: InitialStudentSegueDelegate!
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsOutlet: UILabel!
//    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
//    @IBOutlet weak var confirmPasswordLabelOutlet: UILabel!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        guard let isOwner = isOwner else { return }
        
        if isOwner{
            welcomeMessageOutlet.text = "Welcome Owner"
        } else {
            welcomeMessageOutlet.text = "Welcome New Student"
        }
        
//        username = "guatambu"
//        password = "1998Gwbic"
        
        confirmPasswordTextField.isEnabled = true
        confirmPasswordTextField.isHidden = false
//        confirmPasswordLabelOutlet.isHidden = false
        
        welcomeMessageOutlet.textColor = beltBuilder.blackBeltBlack
        
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.avenirFont
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter username", attributes: beltBuilder.avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter password", attributes: beltBuilder.avenirFont)
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "tap to re-enter password", attributes: beltBuilder.avenirFont)
        
        guard let _ = username, let _ = password else {
            
            if isOwner {
                welcomeMessageOutlet.text = "Welcome New Owner"
                welcomeInstructionsOutlet.text = "please create a username and password"
//                passwordLabelOutlet.text = "create password"
                signUpButtonOutlet.setTitle("Sign Up", for: UIControl.State.normal)
            } else {
                welcomeMessageOutlet.text = "Welcome New Student"
                welcomeInstructionsOutlet.text = "please create a username and password"
//                passwordLabelOutlet.text = "create password"
                signUpButtonOutlet.setTitle("Sign Up", for: UIControl.State.normal)
            }
            
            return
        }
        
        if isOwner {
            welcomeMessageOutlet.text = "Welcome Owner"
            welcomeInstructionsOutlet.text = "please login"
//            passwordLabelOutlet.text = "password"
            confirmPasswordTextField.isEnabled = false
            confirmPasswordTextField.isHidden = true
//            confirmPasswordLabelOutlet.isHidden = true
            signUpButtonOutlet.setTitle("Login", for: UIControl.State.normal)
            
        } else {
            welcomeMessageOutlet.text = "Welcome Student"
            welcomeInstructionsOutlet.text = "please login"
//            passwordLabelOutlet.text = "password"
            confirmPasswordTextField.isEnabled = false
            confirmPasswordTextField.isHidden = true
//            confirmPasswordLabelOutlet.isHidden = true
            signUpButtonOutlet.setTitle("Login", for: UIControl.State.normal)
        }
    }
    
    
    // MARK: - Actions
    
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
            
            // warning to user where welcome instructions text changes to red
            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            // warnings for specific textfield being left blank by user
            if usernameTextField.text == "" {
                
                usernameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter username", attributes: beltBuilder.errorAvenirFont)
                
                //                firstNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                usernameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter username", attributes: beltBuilder.avenirFont)
                
                //                firstNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if passwordTextField.text == "" {
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter password", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter password", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
            if confirmPasswordTextField.text == "" {
                
                confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "tap to confirm password", attributes: beltBuilder.errorAvenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.redBeltRed
            } else {
                
                confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "tap to confirm password", attributes: beltBuilder.avenirFont)
                
                //                lastNameLabelOutlet.textColor = beltBuilder.blackBeltBlack
            }
            
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
                
                usernameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter username", attributes: beltBuilder.errorAvenirFont)
                
                return
            }
            // check to see if there is a valid and matching password
            if self.passwordTextField.text == "" {
                welcomeInstructionsOutlet.text = "please create a password"
                welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
                // fire haptic feedback for error
                hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter password", attributes: beltBuilder.errorAvenirFont)
                
                return
            } else if self.confirmPasswordTextField.text == "" {
                welcomeInstructionsOutlet.text = "please confirm your password"
                welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
                // fire haptic feedback for error
                hapticFeedbackGenerator = UINotificationFeedbackGenerator()
                hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                
                confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "tap to re-enter password", attributes: beltBuilder.errorAvenirFont)
                
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
            
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
            // pass data to destViewController
            destViewController.isOwner = isOwner
            destViewController.isKid = isKid
            destViewController.username = newUsername
            destViewController.isOwnerAddingStudent = isOwnerAddingStudent
            destViewController.group = group
            
            // reset welcome instructions text color and message upon succesful save
            welcomeInstructionsOutlet.textColor = beltBuilder.blackBeltBlack
            welcomeInstructionsOutlet.text = "please enter the following"

            return
        }
        
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        // if usermame/password - login
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // reset welcome instructions text color and message upon succesful save
        welcomeInstructionsOutlet.textColor = beltBuilder.blackBeltBlack
        welcomeInstructionsOutlet.text = "please enter the following"
        // reset textfield placeholder text color to gray upon succesful save
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter username", attributes: beltBuilder.avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter password", attributes: beltBuilder.avenirFont)
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "tap to re-enter password", attributes: beltBuilder.avenirFont)
        
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
