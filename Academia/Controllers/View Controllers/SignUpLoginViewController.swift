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
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear: isOwner = \(String(describing: isOwner))")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let isOwner = isOwner else { return }
        print("signUpVC: \(isOwner)")
        
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: avenirFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: avenirFont)
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "confirm password", attributes: avenirFont)
        
        
        guard let username = username, let password = password else {
            
            if isOwner {
                welcomeMessageOutlet.text = "Welcome New Owner"
                welcomeInstructionsOutlet.text = "please create a username and password"
            } else {
                welcomeMessageOutlet.text = "Welcome New Student"
                welcomeInstructionsOutlet.text = "please create a username and password"
            }
            
            return
        }
        
        if isOwner {
            welcomeMessageOutlet.text = "Welcome Owner"
            welcomeInstructionsOutlet.text = "please login"
        } else {
            welcomeMessageOutlet.text = "Welcome Student"
            welcomeInstructionsOutlet.text = "please login"
        }
        

    }
    
    
    // MARK: - Actions
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if isOwner == false {
            // programmatically performing the owner segue
            
            // instantiate the relevant storyboard
            let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = mainView.instantiateViewController(withIdentifier: "toInitialStudentSignUp") as! AddNewStudentTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
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
