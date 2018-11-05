//
//  StudentChoiceViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/19/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentChoiceViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var username: String?
    var password: String?
    
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
        
        print("********* StudentChoiceVC \n isOwner: \(isOwner) \n username: \(username) \n password: \(password)")
    }
    
    
    // MARK: - Actions
    
    @IBAction func kidsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = false
        confirmKidsProgramButtonOutlet.isEnabled = true
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
    }
    
    @IBAction func adultsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = true
        confirmKidsProgramButtonOutlet.isEnabled = false
        
        confirmAdultsProgramButtonOutlet.isHidden = false
        confirmAdultsProgramButtonOutlet.isEnabled = true
    }
    
    @IBAction func confirmKidsProgramButtonTapped(_ sender: UIButton) {
        
        // programmatically performing the Kid Student segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toInitialKidStudentSignUp") as! KidStudentInitialSetupTableViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        
         destViewController.cells = [MyCells.profilePicCell, MyCells.beltCell, MyCells.statusCell, MyCells.usernameCell, MyCells.passwordCell, MyCells.firstNameCell, MyCells.lastNameCell, MyCells.parentGuardianCell, MyCells.streetAddressCell, MyCells.cityCell, MyCells.stateCell, MyCells.zipCodeCell, MyCells.phoneCell, MyCells.mobileCell, MyCells.emailCell, MyCells.emergencyContactCell, MyCells.emergencyContactPhoneCell, MyCells.emergencyContactRelationshipCell, MyCells.saveProfileButtonCell]
        
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    @IBAction func confirmAdultsProgramButtonTapped(_ sender: UIButton) {
        
        // programmatically performing the adult student segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toInitialStudentSignUp") as! AdultStudentInitialSetupTableViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        
         destViewController.cells = [MyCells.profilePicCell, MyCells.beltCell, MyCells.statusCell, MyCells.isInstructorCell, MyCells.usernameCell, MyCells.passwordCell, MyCells.firstNameCell, MyCells.lastNameCell, MyCells.parentGuardianCell, MyCells.streetAddressCell, MyCells.cityCell, MyCells.stateCell, MyCells.zipCodeCell, MyCells.phoneCell, MyCells.mobileCell, MyCells.emailCell, MyCells.emergencyContactCell, MyCells.emergencyContactPhoneCell, MyCells.emergencyContactRelationshipCell, MyCells.saveProfileButtonCell]
        
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
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
