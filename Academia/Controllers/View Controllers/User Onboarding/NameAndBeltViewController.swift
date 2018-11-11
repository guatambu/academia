//
//  NameAndBeltViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class NameAndBeltViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName = ""
    var lastName = ""
    var beltLevel: InternationalStandardBJJBelts = .adultWhiteBelt
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var firstNameLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabelOutlet: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var beltHolderViewOutlet: UIView!
    
    @IBOutlet weak var credentialsStackViewOutlet: UIStackView!
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // successfully working... yay programtatic segues!
        print("viewWillAppear: isOwner = \(String(describing: isOwner))")
        print("viewWillAppear: isKid = \(String(describing: isKid))")
        print("viewWillAppear: username = \(String(describing: username))")
        print("viewWillAppear: password = \(String(describing: password))")

        
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: .kidsOrangeBlackBelt, numberOfStripes: 10)
    }
    
    
    // MARK: - Actions
    @IBAction func setBeltLevelButtonTapped(_ sender: DesignableButton) {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserAddress") as! AddressViewController
        
        guard let newFirstName = self.firstNameTextField.text,
            let newLastName = lastNameTextField.text,
            self.firstNameTextField.text != "",
            self.lastNameTextField.text != ""
            else {

            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
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
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = newFirstName
        destViewController.lastName = newLastName
        destViewController.beltLevel = beltLevel
        
        return
    }
    
    
    // MARK: - Helper Methods


}
