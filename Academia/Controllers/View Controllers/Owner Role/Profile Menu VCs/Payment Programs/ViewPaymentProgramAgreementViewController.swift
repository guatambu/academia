//
//  ViewPaymentProgramAgreementViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ViewPaymentProgramAgreementViewController: UIViewController {

    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()
    
    var paymentProgramName: String?
    var programAgreement: String?
    
    // program agreement textView
    @IBOutlet weak var programAgreementTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        guard let programAgreement = programAgreement else {
            
            print("programAgreement has a nil value in ViewPaymentProgramAgreementVC -> viewDidLoad() - line 37")
            return
        }
        programAgreementTextView.text = "\(programAgreement)"
    }
}



