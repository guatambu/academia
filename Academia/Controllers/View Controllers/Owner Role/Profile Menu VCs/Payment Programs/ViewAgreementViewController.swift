//
//  ViewAgreementViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/14/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ViewAgreementViewController: UIViewController {

    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()
    
    
    var paymentProgramName: String?
    var agreement: String?
    
    // program agreement textView
    @IBOutlet weak var agreementTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        guard let agreement = agreement else {
            
            print("programAgreement has a nil value in ViewPaymentProgramAgreementVC -> viewDidLoad() - line 37")
            return
        }
        agreementTextView.text = "\(agreement)"
        
        
    }
}
