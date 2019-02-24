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
    var isKid = false
    var username: String?
    var password: String?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var kidsProgramButtonOutlet: DesignableButton!
    @IBOutlet weak var adultsProgramButtonOutlet: DesignableButton!
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
        
        // set button titleColor values
        
        // iAmOwnerButton
        kidsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        kidsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        kidsProgramButtonOutlet.setTitleColor(beltBuilder.grayBeltGray, for: UIControl.State.disabled)
        
        // iAmStudent
        adultsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        adultsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        adultsProgramButtonOutlet.setTitleColor(beltBuilder.grayBeltGray, for: UIControl.State.disabled)
    }
    
    
    // MARK: - Actions
    
    @IBAction func kidsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = false
        confirmKidsProgramButtonOutlet.isEnabled = true
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
        
        // set color of selected button
        kidsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
        
        // set color of button NOT selected
        adultsProgramButtonOutlet.borderColor = beltBuilder.grayBeltGray
        
        isKid = true
    }
    
    @IBAction func adultsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = true
        confirmKidsProgramButtonOutlet.isEnabled = false
        
        confirmAdultsProgramButtonOutlet.isHidden = false
        confirmAdultsProgramButtonOutlet.isEnabled = true
        
        // set color of selected button
        adultsProgramButtonOutlet.tintColor = beltBuilder.redBeltRed
        adultsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
        
        // set color of button NOT selected
        kidsProgramButtonOutlet.tintColor = beltBuilder.grayBeltGray
        kidsProgramButtonOutlet.borderColor = beltBuilder.grayBeltGray
        
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
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass desired data to relevant view controller
        destViewController.isOwner = self.isOwner
        destViewController.isKid = true
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        
//        // reset color of buttons
//        adultsProgramButtonOutlet.tintColor = beltBuilder.redBeltRed
//        adultsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
//        kidsProgramButtonOutlet.tintColor = beltBuilder.redBeltRed
//        kidsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
        
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
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass desired data to relevant view controller
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        
//        // reset color of buttons
//        adultsProgramButtonOutlet.tintColor = beltBuilder.redBeltRed
//        adultsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
//        kidsProgramButtonOutlet.tintColor = beltBuilder.redBeltRed
//        kidsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
    }
}
