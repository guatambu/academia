//
//  UserSelfIdentifyViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class UserSelfIdentifyViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var iAmOwnerButtonOutlet: UIButton!
    @IBOutlet weak var iAmStudentButtonOutlet: UIButton!
    @IBOutlet weak var confirmStudentButtonOutlet: UIButton!
    @IBOutlet weak var confirmOwnerButtonOutlet: UIButton!
    
    
    var isOwner = false
    var isKid = false
    
    
    // MARK: ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        confirmOwnerButtonOutlet.isHidden = true
        confirmStudentButtonOutlet.isHidden = true
        
        confirmOwnerButtonOutlet.isEnabled = false
        confirmStudentButtonOutlet.isEnabled = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func ownerButtonTapped(_ sender: UIButton) {
        confirmOwnerButtonOutlet.isHidden = false
        confirmOwnerButtonOutlet.isEnabled = true
        
        confirmStudentButtonOutlet.isHidden = true
        confirmStudentButtonOutlet.isEnabled = false
        
        isOwner = true
        print(isOwner)
    }
    
    @IBAction func studentButtonTapped(_ sender: UIButton) {
        confirmStudentButtonOutlet.isHidden = false
        confirmStudentButtonOutlet.isEnabled = true
        
        confirmOwnerButtonOutlet.isHidden = true
        confirmOwnerButtonOutlet.isEnabled = false
        
        isOwner = false
        print(isOwner)
    }
    
    @IBAction func confirmStudentButtonTapped(_ sender: UIButton) {
        print(self.isOwner)
        
        // programmatically performing the segue
        
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
        
        // pass desired data to relevant view controller
        destViewController.isOwner = self.isOwner
        destViewController.isKid = self.isKid

    }
    
    @IBAction func confirmOwnerButtonTapped(_ sender: UIButton) {
        print(self.isOwner)
        
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
        destViewController.isKid = self.isKid

    }

}
