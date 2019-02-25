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
    @IBOutlet weak var confirmKidsProgramButtonOutlet: DesignableButton!
    @IBOutlet weak var confirmAdultsProgramButtonOutlet: DesignableButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide and disable confirmation buttons
        confirmKidsProgramButtonOutlet.isHidden = true
        confirmKidsProgramButtonOutlet.isEnabled = false
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
        
        // hide and disable cancel button
        cancelButtonOutlet.isHidden = true
        cancelButtonOutlet.isEnabled = false
        
        // set button titleColor values
        // kidsProgramButton
        kidsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        kidsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        kidsProgramButtonOutlet.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        // adultsProgramButton
        adultsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        adultsProgramButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        adultsProgramButtonOutlet.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        
        // properties check
        guard let isOwner = isOwner, let username = username, let password = password else { return }
        
        print("isOwner: \(isOwner) \nusername: \(username) \npassword: \(password)")
    }
    
    
    // MARK: - Actions
    
    @IBAction func kidsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = false
        confirmKidsProgramButtonOutlet.isEnabled = true
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
        
        // set color of button NOT selected
        adultsProgramButtonOutlet.isEnabled = false
        adultsProgramButtonOutlet.borderColor = UIColor.lightGray
        
        isKid = true
        
        // show and enable cancel button
        cancelButtonOutlet.isHidden = false
        cancelButtonOutlet.isEnabled = true
    }
    
    @IBAction func adultsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = true
        confirmKidsProgramButtonOutlet.isEnabled = false
        
        confirmAdultsProgramButtonOutlet.isHidden = false
        confirmAdultsProgramButtonOutlet.isEnabled = true
        
        // set color of button NOT selected
        kidsProgramButtonOutlet.isEnabled = false
        kidsProgramButtonOutlet.borderColor = UIColor.lightGray
        
        isKid = false
        
        // show and enable cancel button
        cancelButtonOutlet.isHidden = false
        cancelButtonOutlet.isEnabled = true
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
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass desired data to relevant view controller
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        print("cancel button fired")
        
        // enable self identify buttons
        kidsProgramButtonOutlet.isEnabled = true
        adultsProgramButtonOutlet.isEnabled = true
        
        kidsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
        adultsProgramButtonOutlet.borderColor = beltBuilder.redBeltRed
        
        // hide and disable confirmation buttons
        confirmKidsProgramButtonOutlet.isHidden = true
        confirmKidsProgramButtonOutlet.isEnabled = false
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
        
        // hide and disable cancel button
        cancelButtonOutlet.isEnabled = false
        cancelButtonOutlet.isHidden = true
        
        // reset isKid to default
        isKid = false
    }
    
}
