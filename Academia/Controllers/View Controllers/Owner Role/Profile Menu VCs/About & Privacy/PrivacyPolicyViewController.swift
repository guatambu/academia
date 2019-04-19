//
//  PrivacyPolicyViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    // MARK: - Properties
    let beltBuilder = BeltBuilder()
    
    
    // ViewCotnroller Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed

        // Do any additional setup after loading the view.
    }

}
