//
//  UserSelfIdentifyViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class UserSelfIdentifyViewController: UIViewController {
    
    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()

    @IBOutlet weak var iAmOwnerButtonOutlet: DesignableButton!
    @IBOutlet weak var iAmStudentButtonOutlet: DesignableButton!
    @IBOutlet weak var confirmStudentButtonOutlet: DesignableButton!
    @IBOutlet weak var confirmOwnerButtonOutlet: DesignableButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    
    var isOwner = false
    var isKid = false
    
    
    // MARK: ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set button titleColor values
        // iAmOwnerButton
        iAmOwnerButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        iAmOwnerButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        iAmOwnerButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.disabled)
        iAmOwnerButtonOutlet.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        // iAmStudent
        iAmStudentButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        iAmStudentButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        iAmStudentButtonOutlet.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        
        // hide and disable confirmation buttons
        confirmOwnerButtonOutlet.isEnabled = false
        confirmOwnerButtonOutlet.isHidden = true
        
        confirmStudentButtonOutlet.isEnabled = false
        confirmStudentButtonOutlet.isHidden = true
        
        // hide and disable cancel button
        cancelButtonOutlet.isEnabled = false
        cancelButtonOutlet.isHidden = true
    }
    
    
    // MARK: - Actions
    
    @IBAction func ownerButtonTapped(_ sender: DesignableButton) {
            
        confirmOwnerButtonOutlet.isHidden = false
        confirmOwnerButtonOutlet.isEnabled = true
        
        confirmStudentButtonOutlet.isHidden = true
        confirmStudentButtonOutlet.isEnabled = false
        
        // set color of button NOT selected border
        iAmStudentButtonOutlet.isEnabled = false
        iAmStudentButtonOutlet.borderColor = UIColor.lightGray
        
        isOwner = true
        
        print("UserSelfIdentifyVC -> ownerButtonTapped(sender:) - isOwner = \(self.isOwner)")
        
        // show and ensable cancel button
        cancelButtonOutlet.isEnabled = true
        cancelButtonOutlet.isHidden = false
    }
    
    @IBAction func studentButtonTapped(_ sender: DesignableButton) {
            
        confirmStudentButtonOutlet.isHidden = false
        confirmStudentButtonOutlet.isEnabled = true
        
        confirmOwnerButtonOutlet.isHidden = true
        confirmOwnerButtonOutlet.isEnabled = false
        
        // set color of button NOT selected
        iAmOwnerButtonOutlet.isEnabled = false
        iAmOwnerButtonOutlet.borderColor = UIColor.lightGray
        
        isOwner = false
        
        print("UserSelfIdentifyVC -> studentButtonTapped(sender:) - isOwner = \(self.isOwner)")
        
        // show and ensable cancel button
        cancelButtonOutlet.isEnabled = true
        cancelButtonOutlet.isHidden = false
    }
    
    @IBAction func confirmStudentButtonTapped(_ sender: DesignableButton) {
        print("UserSelfIdentifyVC isOwner = \(self.isOwner)")
        
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
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass desired data to relevant view controller
        destViewController.isOwner = self.isOwner
        destViewController.isKid = self.isKid

    }
    
    @IBAction func confirmOwnerButtonTapped(_ sender: DesignableButton) {
        print("UserSelfIdentifyVC isOwner = \(self.isOwner)")
        
        // programmatically performing the segue
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
        destViewController.isKid = self.isKid
        
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        print("cancel button fired")
        
        // enable self identify buttons
        iAmStudentButtonOutlet.isEnabled = true
        iAmOwnerButtonOutlet.isEnabled = true

        iAmStudentButtonOutlet.borderColor = beltBuilder.redBeltRed
        iAmOwnerButtonOutlet.borderColor = beltBuilder.redBeltRed

        // hide and disable confirmation buttons
        confirmOwnerButtonOutlet.isHidden = true
        confirmOwnerButtonOutlet.isEnabled = false

        confirmStudentButtonOutlet.isHidden = true
        confirmStudentButtonOutlet.isEnabled = false

        // reset isOwner to default
        isOwner = false

        // hide and disable cancel button
        cancelButtonOutlet.isEnabled = false
        cancelButtonOutlet.isHidden = true
    }
}
