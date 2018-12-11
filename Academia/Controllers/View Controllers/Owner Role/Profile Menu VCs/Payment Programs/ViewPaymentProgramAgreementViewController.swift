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
    
    var paymentProgramName: String?
    var programAgreement: String?
    
    // program agreement textView
    @IBOutlet weak var programAgreementTextView: UITextView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let programAgreement = programAgreement else {
            
            print("programAgreement has a nil value in ViewPaymentProgramAgreementVC -> viewDidLoad() - line 37")
            return
        }
        programAgreementTextView.text = "\(programAgreement)"
    }
}



