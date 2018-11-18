//
//  StudentChoiceViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentChoiceViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var username: String?
    var password: String?
    
    var isKid = false
    
    @IBOutlet weak var kidsProgramButtonOutlet: UIButton!
    @IBOutlet weak var adultsProgramButtonOutlet: UIButton!
    @IBOutlet weak var confirmKidsProgramButtonOutlet: UIButton!
    @IBOutlet weak var confirmAdultsProgramButtonOutlet: UIButton!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        confirmKidsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isHidden = true
        
        confirmAdultsProgramButtonOutlet.isEnabled = false
        confirmKidsProgramButtonOutlet.isEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let isOwner = isOwner, let username = username, let password = password else { return }
        
        print("isOwner: \(isOwner) \nusername: \(username) \npassword: \(password)")
    }
    
    
    // MARK: - Actions
    
    @IBAction func kidsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = false
        confirmKidsProgramButtonOutlet.isEnabled = true
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
        
        isKid = true
    }
    
    @IBAction func adultsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = true
        confirmKidsProgramButtonOutlet.isEnabled = false
        
        confirmAdultsProgramButtonOutlet.isHidden = false
        confirmAdultsProgramButtonOutlet.isEnabled = true
        
        isKid = false
    }
    
    @IBAction func confirmKidsProgramButtonTapped(_ sender: UIButton) {
        
        // programmatically performing the Kid Student segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUsernamePassword") as! SignUpLoginViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass desired data to relevant view controller
        destViewController.isOwner = self.isOwner
        destViewController.isKid = true
        
    }
    
    @IBAction func confirmAdultsProgramButtonTapped(_ sender: UIButton) {
        
        // programmatically performing the adult student segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUsernamePassword") as! SignUpLoginViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass desired data to relevant view controller
        destViewController.isOwner = self.isOwner
        destViewController.isKid = false
        
    }
}
