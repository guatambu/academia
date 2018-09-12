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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear: isOwner = \(isOwner)")
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
