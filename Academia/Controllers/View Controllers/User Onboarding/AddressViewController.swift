//
//  AddressViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var profilePic: UIImage?
    var beltLevel: InternationalStandardBJJBelts?
    var numberOfStripes: Int?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var addressLine1LabelOutlet: UILabel!
    @IBOutlet weak var addressLine1TextField: UITextField!
    @IBOutlet weak var addressLine2LabelOutlet: UILabel!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var cityLabelOutlet: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateLabelOutlet: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeLabelOutlet: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let isOwner = isOwner, let isKid = isKid, let username = username, let password = password, let firstName = firstName, let lastName = lastName, let beltLevel = beltLevel, let numberOfStripes = numberOfStripes else { return }
        
        print("isOwner: \(isOwner) \nisKid: \(isKid) \nusername: \(username) \npassword: \(password) \nfirstName: \(firstName) \nlastName: \(lastName) \nbeltLevel: \(beltLevel.rawValue) \nnumberOfStripes: \(numberOfStripes)")
        
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
