//
//  ContactInfoViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mobileLabelOutlet: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailOutlet: UILabel!
    @IBOutlet weak var emailTextField: UITextField!

    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}