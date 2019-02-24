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
    
    let beltBuilder = BeltBuilder()

    @IBOutlet weak var iAmOwnerButtonOutlet: DesignableButton!
    @IBOutlet weak var iAmStudentButtonOutlet: DesignableButton!
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
        
        // set button titleColor values
        
        // iAmOwnerButton
        iAmOwnerButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        iAmOwnerButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        iAmOwnerButtonOutlet.setTitleColor(beltBuilder.grayBeltGray, for: UIControl.State.disabled)
        
        // iAmStudent
        iAmStudentButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.selected)
        iAmStudentButtonOutlet.setTitleColor(beltBuilder.redBeltRed, for: UIControl.State.normal)
        iAmStudentButtonOutlet.setTitleColor(beltBuilder.grayBeltGray, for: UIControl.State.disabled)
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func ownerButtonTapped(_ sender: UIButton) {
        
        if !iAmStudentButtonOutlet.isEnabled {
            
            iAmStudentButtonOutlet.isEnabled = true
            
            confirmOwnerButtonOutlet.isHidden = true
            confirmOwnerButtonOutlet.isEnabled = false
            
            confirmStudentButtonOutlet.isHidden = true
            confirmStudentButtonOutlet.isEnabled = false
            
            iAmStudentButtonOutlet.borderColor = beltBuilder.redBeltRed
            
            isOwner = false
            
        } else {
            
            confirmOwnerButtonOutlet.isHidden = false
            confirmOwnerButtonOutlet.isEnabled = true
            
            confirmStudentButtonOutlet.isHidden = true
            confirmStudentButtonOutlet.isEnabled = false
            
            // set color of selected button border
            iAmOwnerButtonOutlet.borderColor = beltBuilder.redBeltRed
            
            // set color of button NOT selected border
            iAmStudentButtonOutlet.isEnabled = false
            iAmStudentButtonOutlet.borderColor = beltBuilder.grayBeltGray
            
            isOwner = true
        }
        
        print("UserSelfIdentifyVC -> ownerButtonTapped(sender:) - isOwner = \(self.isOwner)")
    }
    
    @IBAction func studentButtonTapped(_ sender: UIButton) {
        
        if !iAmOwnerButtonOutlet.isEnabled {
            
            iAmOwnerButtonOutlet.isEnabled = true
            
            confirmOwnerButtonOutlet.isHidden = true
            confirmOwnerButtonOutlet.isEnabled = false
            
            confirmStudentButtonOutlet.isHidden = true
            confirmStudentButtonOutlet.isEnabled = false
            
            iAmOwnerButtonOutlet.borderColor = beltBuilder.redBeltRed
            
            isOwner = false
            
        } else {
            
            confirmStudentButtonOutlet.isHidden = false
            confirmStudentButtonOutlet.isEnabled = true
            
            confirmOwnerButtonOutlet.isHidden = true
            confirmOwnerButtonOutlet.isEnabled = false
            
            // set color of selected button
            iAmStudentButtonOutlet.borderColor = beltBuilder.redBeltRed
            
            // set color of button NOT selected
            iAmOwnerButtonOutlet.isEnabled = false
            iAmOwnerButtonOutlet.borderColor = beltBuilder.grayBeltGray
            
            isOwner = false
        }
        
        print("UserSelfIdentifyVC -> studentButtonTapped(sender:) - isOwner = \(self.isOwner)")
    }
    
    @IBAction func confirmStudentButtonTapped(_ sender: UIButton) {
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
        
//        // reset color of buttons
//        iAmStudentButtonOutlet.tintColor = beltBuilder.redBeltRed
//        iAmStudentButtonOutlet.borderColor = beltBuilder.redBeltRed
//        iAmOwnerButtonOutlet.tintColor = beltBuilder.redBeltRed
//        iAmOwnerButtonOutlet.borderColor = beltBuilder.redBeltRed

    }
    
    @IBAction func confirmOwnerButtonTapped(_ sender: UIButton) {
        print("UserSelfIdentifyVC isOwner = \(self.isOwner)")
        
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
        
        //        // reset color of buttons
        //        iAmStudentButtonOutlet.tintColor = beltBuilder.redBeltRed
        //        iAmStudentButtonOutlet.borderColor = beltBuilder.redBeltRed
        //        iAmOwnerButtonOutlet.tintColor = beltBuilder.redBeltRed
        //        iAmOwnerButtonOutlet.borderColor = beltBuilder.redBeltRed

    }

}
