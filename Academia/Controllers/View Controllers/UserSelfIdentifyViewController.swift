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
    
    
    // MARK: ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        confirmOwnerButtonOutlet.isHidden = true
        confirmStudentButtonOutlet.isHidden = true
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

    }
    
    @IBAction func confirmOwnerButtonTapped(_ sender: UIButton) {
        print(self.isOwner)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "studentSegue" {
            guard let destinationVC = segue.destination as? SignUpLoginViewController else {
                return
            }
            // Pass the selected object to the new view controller.
            destinationVC.isOwner = self.isOwner
            print("self: \(self.isOwner)")
            print("dest: \(String(describing: destinationVC.isOwner))")
        }
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "ownerSegue" {
            guard let destinationVC = segue.destination as? SignUpLoginViewController else {
                return
            }
            // Pass the selected object to the new view controller.
            destinationVC.isOwner = self.isOwner
            print("self: \(self.isOwner)")
            print("dest: \(String(describing: destinationVC.isOwner))")
        }

    }
}
