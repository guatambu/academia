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
    var username: String?
    var password: String?
    var isKid: Bool = false
    
    @IBOutlet weak var firstProgressDotOutlet: DesignableView!
    
    var delegate: InitialStudentSegueDelegate!
    
    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsOutlet: UILabel!
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabelOutlet: UILabel!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // turns off auto-correct in these UITextFields
        usernameTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // turns off auto-capitalization in these UITextFields
        usernameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        confirmPasswordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // hide first progress dot for owner users
        guard let isOwner = isOwner else { return }
        
        if isOwner {
            firstProgressDotOutlet.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        username = "guatambu"
//        password = "1998Gwbic"
        
        confirmPasswordTextField.isEnabled = true
        confirmPasswordTextField.isHidden = false
        confirmPasswordLabelOutlet.isHidden = false
        
        welcomeMessageOutlet.textColor = UIColor.black
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-LightOblique", size: 16)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter username", attributes: avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter password", attributes: avenirFont)
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "tap to re-enter password", attributes: avenirFont)
        
        guard let isOwner = isOwner else { return }
        guard let username = username, let password = password else {
            
            if isOwner {
                welcomeMessageOutlet.text = "Welcome New Owner"
                welcomeInstructionsOutlet.text = "please create a username and password"
                passwordLabelOutlet.text = "create password"
                signUpButtonOutlet.setTitle("Sign Up", for: UIControl.State.normal)
            } else {
                welcomeMessageOutlet.text = "Welcome New Student"
                welcomeInstructionsOutlet.text = "please create a username and password"
                passwordLabelOutlet.text = "create password"
                signUpButtonOutlet.setTitle("Sign Up", for: UIControl.State.normal)
            }
            
            return
        }
        
        if isOwner {
            welcomeMessageOutlet.text = "Welcome Owner"
            welcomeInstructionsOutlet.text = "please login"
            passwordLabelOutlet.text = "password"
            confirmPasswordTextField.isEnabled = false
            confirmPasswordTextField.isHidden = true
            confirmPasswordLabelOutlet.isHidden = true
            signUpButtonOutlet.setTitle("Login", for: UIControl.State.normal)
            
        } else {
            welcomeMessageOutlet.text = "Welcome Student"
            welcomeInstructionsOutlet.text = "please login"
            passwordLabelOutlet.text = "password"
            confirmPasswordTextField.isEnabled = false
            confirmPasswordTextField.isHidden = true
            confirmPasswordLabelOutlet.isHidden = true
            signUpButtonOutlet.setTitle("Login", for: UIControl.State.normal)
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toTakeProfilePic") as! TakeProfilePicViewController
        
        // run check to see is there is username/password
        guard let username = username, let password = password else {
            // if no username/password -
                // pass new username & confirmed password to destViewController
            // check to see if there is valid username
            guard let newUsername = self.usernameTextField.text, self.usernameTextField.text != "" else {
                welcomeInstructionsOutlet.textColor = UIColor.red
                return
            }
            // check to see if there is a valid and matching password
            if self.passwordTextField.text == "" {
                welcomeInstructionsOutlet.text = "please create a password"
                welcomeInstructionsOutlet.textColor = UIColor.red
            } else if self.confirmPasswordTextField.text == "" {
                welcomeInstructionsOutlet.text = "please confirm your password"
                welcomeInstructionsOutlet.textColor = UIColor.red
            } else if self.passwordTextField.text != self.confirmPasswordTextField.text {
                welcomeInstructionsOutlet.text = "your password does not match your confirmed password. please try again."
                welcomeInstructionsOutlet.textColor = UIColor.red
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

            return
        }
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        // if usermame/password - login
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
}
