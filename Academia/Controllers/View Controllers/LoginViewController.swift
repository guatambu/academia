//
//  LoginViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/7/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    
    // string identifiers for programmatic segues
    let ownerBaseCampStoryboardString = "OwnerBaseCampFlow"
    let ownerTabBarControllerIdentifier = "toOwnerBaseCamp"
    let studentBaseCampStoryboardString = "StudentBaseCampFlow"
    let studentStoryboardIdentifier = "toStudentDashboard"
    
    // user message string(s)
    let welcomeInstructions = "please enter the following"
    let usernameNotFound = "username not found. please try again"
    let passwordIncorrect = "password incorrect. please try again"
    
    let beltBuilder = BeltBuilder()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsOutlet: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    // CoreData Properties
    var owner: OwnerCD?
    var studentAdult: StudentAdultCD?
    var studentKid: StudentKidCD?
    var uuid: UUID?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeToKeyboardNotifications()
        
        // turns off auto-correct in these UITextFields
        usernameTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        usernameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // turns on secure text entry in password and confirm password textFields
        passwordTextField.isSecureTextEntry = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeToKeyboardNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.avenirFont)
    }

    // MARK: - Actions
    
    @IBAction func tapAnywhereToDismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        // dismiss keyboard when leaving VC scene
        if usernameTextField.isFirstResponder {
            usernameTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: DesignableButton) {
        
        // dismiss keyboard when leaving VC scene
        if usernameTextField.isFirstResponder {
            usernameTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
        
        // check for required information being left blank by user
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            // warning to user where welcome instructions text changes to red
            welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
            
            // give user haptic feedback
            fireHapticFeedbackForError()
            
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
            
            // login not allowed, so we exit function
            return
        }
       
        // if username/password - login
        if let username = usernameTextField.text, let password = passwordTextField.text {
            
            // check the owners array for the owner.username to match user input
            for owner in OwnerCDModelController.shared.owners {
                print("existing owner password: \(owner.password ?? "")")
                print("current entered password: \(password)")
                // if username match, check password
                if owner.username == username {
                    // if password match...
                    if owner.password == password {
                        // login successful, perform segue to owner dashboard
                        performTabBarControllerSegue(storyboardString: ownerBaseCampStoryboardString, tabBarControllerIdentifier: ownerTabBarControllerIdentifier)
                        // reset viewController instructions
                        resetViewControllerLoginSuccessful()
                        // toggle owner.isLoggedOn
                        owner.isLoggedOn = true
                        // login successful, leave function
                        return
                        
                    // if password incorrect inform user login unsuccessful
                    } else {
                        // give user haptic feedback
                        fireHapticFeedbackForError()
                        // warning to user
                        displayWarning(warningMessage: passwordIncorrect)
                        // login unsuccessful, leave function
                        return
                    }
                }
            }
            // if no match then check StudentAdultCD array for match
            for studentAdult in StudentAdultCDModelController.shared.studentAdults {
                if studentAdult.username == username {
                    //if username match, check password
                    if studentAdult.password == password {
                        // login successful, perform segue to student dashboard
                        performTabBarControllerSegue(storyboardString: studentBaseCampStoryboardString, tabBarControllerIdentifier: studentStoryboardIdentifier)
                        // reset viewController instructions
                        resetViewControllerLoginSuccessful()
                        // toggle owner.isLoggedOn
                        studentAdult.isLoggedOn = true
                        // login successful, leave function
                        return
                        
                    // if password incorrect inform user login unsuccessful
                    } else {
                        // give user haptic feedback
                        fireHapticFeedbackForError()
                        // warning to user
                        displayWarning(warningMessage: passwordIncorrect)
                        // login unsuccessful, leave function
                        return
                    }
                }
            }
            // if no match then check StudentKidCD array for match
            for studentKid in StudentKidCDModelController.shared.studentKids {
                if studentKid.username == username {
                    //if username match, check password
                    if studentKid.password == password {
                        // login successful, perform segue to student dashboard
                        performTabBarControllerSegue(storyboardString: studentBaseCampStoryboardString, tabBarControllerIdentifier: studentStoryboardIdentifier)
                        // reset viewController instructions
                        resetViewControllerLoginSuccessful()
                        // toggle owner.isLoggedOn
                        studentKid.isLoggedOn = true
                        // login successful, leave function
                        return
                        
                    // if password incorrect inform user login unsuccessful
                    } else {
                        // give user haptic feedback
                        fireHapticFeedbackForError()
                        // warning to user
                        displayWarning(warningMessage: passwordIncorrect)
                        // login unsuccessful, leave function
                        return
                    }
                }
            }
            
            // USER ERROR: username finds no match in user records
            fireHapticFeedbackForError()
            // warn the user
            displayWarning(warningMessage: usernameNotFound)
            // login unsuccessful, leave function
            return
        }
    }
}


// MARK: - Helper Methods
extension LoginViewController {
    
    func resetViewControllerLoginSuccessful() {
        // reset textfield placeholder text color to gray upon succesful save
        usernameTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.username.rawValue, attributes: beltBuilder.avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: PlaceholderStrings.password.rawValue, attributes: beltBuilder.avenirFont)
        // reset welcome instructions upon succesful login
        resetWelcomeInstructions()
    }
    
    func resetWelcomeInstructions() {
        // reset color
        welcomeInstructionsOutlet.textColor = beltBuilder.blackBeltBlack
        // reset text String
        welcomeInstructionsOutlet.text = welcomeInstructions
    }
    
    func displayWarning(warningMessage: String) {
        // warning to user where welcome instructions text changes to red
        welcomeInstructionsOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsOutlet.text = warningMessage
    }
    
    
    func fireHapticFeedbackForError() {
        // fire haptic feedback for error
        hapticFeedbackGenerator = UINotificationFeedbackGenerator()
        hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
    }
    
    func performTabBarControllerSegue(storyboardString: String, tabBarControllerIdentifier: String) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: storyboardString, bundle: nil)
        
        // create the UITabBarController segue programmatically - MODAL
        if let tabBarDestViewController = (mainView.instantiateViewController(withIdentifier: tabBarControllerIdentifier) as? UITabBarController) {
            self.present(tabBarDestViewController, animated: true, completion: nil)
        }
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
}


// MARK: - UITextField Delegate methods and Keyboard handling
extension LoginViewController: UITextFieldDelegate {
    
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
            textField.resignFirstResponder()
            print("Done button tapped")
            
        }
        return true
    }
}
