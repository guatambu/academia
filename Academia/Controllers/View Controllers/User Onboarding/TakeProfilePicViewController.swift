//
//  TakeProfilePicViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class TakeProfilePicViewController: UIViewController {

    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var profilePic: UIImage?
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var profilePicImageViewOutlet: UIImageView!
    @IBOutlet weak var firstNameLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabelOutlet: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // instantiate tapGestureRecognizer for the profilePicImageViewOutet
        let tapGestureRecognizer = UITapGestureRecognizer(target: profilePicImageViewOutlet, action: #selector(TakeProfilePicViewController.profilePicImageTapped))
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
    
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toInitialOwnerSignUp") as! NameAndBeltViewController
    
        // run check to see is there is firstName, lastName, and profilePic
        guard let firstName = firstNameTextField.text, firstNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let lastName = lastNameTextField.text, lastNameTextField.text != "" else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        guard let profilePic = profilePic else { return }
            
        
    
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
    
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = firstName
        destViewController.password = password
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.profilePic = profilePic
    }

    // MARK: - Helper Functions
    
    @objc func profilePicImageTapped() {
        
        // brings up the camera to snap a profile pic
        
    }
    
    func resizeProfilePic() {
        
        // reduces size and crops dimentsions of original camera image profile pic to smaller size for storage within app
        
    }


}
