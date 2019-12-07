//
//  PrivacyLastPageViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 4/17/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class PrivacyLastPageViewController: UIViewController {

    // MARK: - Properties
    let beltBuilder = BeltBuilder()
    
    
    // AMRK: - Actions
    
    @IBAction func backToProfileMenuButtonTapped(_ sender: UIButton) {
        
        returnToOwnerProfile()
    }
    
    // ViewCotnroller Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        // Do any additional setup after loading the view.
    }

}


// MARK: - returnToOwnerProfile() function to bring us back to the owner profile menu TVC
extension UIViewController {
    
    func returnToOwnerProfile() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is OwnerProfileTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            } else if viewController is StudentProfileDetailTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
            
        }
    }
}
