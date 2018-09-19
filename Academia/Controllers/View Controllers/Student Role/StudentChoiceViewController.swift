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

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions
    
    @IBAction func kidsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = false
        confirmKidsProgramButtonOutlet.isEnabled = true
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
    }
    
    @IBAction func adultsProgramButtonTapped(_ sender: UIButton) {
        
        confirmKidsProgramButtonOutlet.isHidden = false
        confirmKidsProgramButtonOutlet.isEnabled = true
        
        confirmAdultsProgramButtonOutlet.isHidden = true
        confirmAdultsProgramButtonOutlet.isEnabled = false
    }
    
    @IBAction func confirmKidsProgramButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func confirmAdultsProgramButtonTapped(_ sender: UIButton) {
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
     
     destViewController.cells = [MyCells.profilePicCell, MyCells.beltCell, MyCells.statusCell, MyCells.isKidCell, MyCells.isInstructorCell, MyCells.usernameCell, MyCells.firstNameCell, MyCells.lastNameCell, MyCells.parentGuardianCell, MyCells.streetAddressCell, MyCells.cityCell, MyCells.stateCell, MyCells.zipCodeCell, MyCells.phoneCell, MyCells.mobileCell, MyCells.emailCell, MyCells.emergencyContactCell, MyCells.emergencyContactPhoneCell, MyCells.emergencyContactRelationshipCell, MyCells.saveProfileButtonCell]
     
     
    }
    */

}
