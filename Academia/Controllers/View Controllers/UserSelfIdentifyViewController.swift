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

    @IBOutlet weak var confirmStudentButtonOutlet: UIButton!
    @IBOutlet weak var confirmOwnerButtonOutlet: UIButton!
    
    
    var isOwner = false
    
    
    // MARK: - Actions
    
    @IBAction func ownerButtonTapped(_ sender: UIButton) {
        confirmOwnerButtonOutlet.isHidden = false
        confirmOwnerButtonOutlet.isEnabled = true
        
        confirmStudentButtonOutlet.isHidden = true
        confirmStudentButtonOutlet.isEnabled = false
        
        isOwner = true
    }
    
    @IBAction func studentButtonTapped(_ sender: UIButton) {
        confirmStudentButtonOutlet.isHidden = false
        confirmStudentButtonOutlet.isEnabled = true
        
        confirmOwnerButtonOutlet.isHidden = true
        confirmOwnerButtonOutlet.isEnabled = false
        
        isOwner = false
    }
    
    @IBAction func confirmStudentButtonTapped(_ sender: UIButton) {
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            if segue.identifier == "studentSegue" {
                guard let destinationVC = segue.destination as? SignUpLoginViewController else {
                    return
                }
                // Pass the selected object to the new view controller.
                destinationVC.isOwner = self.isOwner
            }
        }
    }
    
    @IBAction func confirmOwnerButtonTapped(_ sender: UIButton) {
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            if segue.identifier == "ownerSegue" {
                guard let destinationVC = segue.destination as? SignUpLoginViewController else {
                    return
                }
                // Pass the selected object to the new view controller.
                self.isOwner = true
                destinationVC.isOwner = self.isOwner
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}
