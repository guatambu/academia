//
//  SignUpLoginViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class SignUpLoginViewController: UIViewController {
    
    // MARK: - Properties
    var isOwner: Bool?
    var username: String?
    var password: String?
    
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
        print("viewWillAppear: isOwner = \(String(describing: isOwner))")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        username = "guatambu"
//        password = "1998Gwbic"
        
        confirmPasswordTextField.isEnabled = true
        confirmPasswordTextField.isHidden = false
        confirmPasswordLabelOutlet.isHidden = false
        
        welcomeMessageOutlet.textColor = UIColor.black
        
        guard let isOwner = isOwner else { return }
        print("signUpVC: \(isOwner)")
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-LightOblique", size: 16)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter username", attributes: avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "tap to enter password", attributes: avenirFont)
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "tap to re-enter password", attributes: avenirFont)
        
        
        guard let _ = username, let _ = password else {
            
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
        
        guard let isOwner = isOwner else { return }
        
        if isOwner == false {
            // programmatically performing the "student choice" segue
            
            // instantiate the relevant storyboard
            let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = mainView.instantiateViewController(withIdentifier: "toStudentChoiceVC") as! StudentChoiceViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
                    // pass the created username and confirmed password to next VC - where it will be on its way to be sorted to either adult or student
            
            // run check to see is there is username/password
            guard let username = username, let password = password else {
                // if no username/password -
                // pass created username and confirmed password to destViewController where rest of owner model creation will occur
                
                // check to see if there is valid username
                guard let newUsername = self.usernameTextField.text, self.usernameTextField.text != "" else {
                    
                    welcomeInstructionsOutlet.textColor = UIColor.red
                    return
                }
                // if valid username, pass it to destViewController
                destViewController.username = newUsername
                
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
                // pass the isOwner value to destViewController
                destViewController.isOwner = isOwner
                
                return
            }
            
            // if usermame/password -
                // login
        } else {
            // programmatically performing the owner segue
            
            // instantiate the relevant storyboard
            let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = mainView.instantiateViewController(withIdentifier: "toInitialOwnerSignUp") as! OwnerProfileInitialSetUpTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
            // run check to see is there is username/password
            guard let username = username, let password = password else {
                // if no username/password -
                    // pass created username and confirmed password to destViewController where rest of owner model creation will occur
                
                // check to see if there is valid username
                guard let newUsername = self.usernameTextField.text, self.usernameTextField.text != "" else {
                    
                    welcomeInstructionsOutlet.textColor = UIColor.red
                    return
                }
                // if valid username, pass it to destViewController
                destViewController.username = newUsername
                
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
                // pass the isOwner value to destViewController
                destViewController.isOwner = isOwner
                
                return
            }
            // if usermame/password -
                // login
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
