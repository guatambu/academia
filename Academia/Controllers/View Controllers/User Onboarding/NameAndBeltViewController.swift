//
//  NameAndBeltViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class NameAndBeltViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName = ""
    var lastName = ""
    var beltLevel: InternationalStandardBJJBelts = .adultWhiteBelt
    var numberOfStripes = 1
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var firstNameLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabelOutlet: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // view that holds belt to be instantiated and displayed
    @IBOutlet weak var beltHolderViewOutlet: UIView!
    // stack view holding user gather information in this ViewController
    @IBOutlet weak var credentialsStackViewOutlet: UIStackView!
    
    // UIPickerView called when user is setting belt level
    @IBOutlet weak var beltLevelPickerView: UIPickerView!
    // UIPickerView called when user is setting belt stripe number
    @IBOutlet weak var stripeNumberPickerView: UIPickerView!
    
    @IBOutlet weak var setBeltLevelButtonOutlet: DesignableButton!
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pickerView requirements
        beltLevelPickerView.delegate = self
        beltLevelPickerView.dataSource = self
        
        // buttons to display at user arrival
        setBeltLevelButtonOutlet.isHidden = false
        nextButtonOutlet.isHidden = false
        
        // successfully working... yay programtatic segues!
        print("viewWillAppear: isOwner = \(String(describing: isOwner))")
        print("viewWillAppear: isKid = \(String(describing: isKid))")
        print("viewWillAppear: username = \(String(describing: username))")
        print("viewWillAppear: password = \(String(describing: password))")
        
        beltLevelPickerView.isHidden = true
        stripeNumberPickerView.isHidden = true
        
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: .adultBlackBelt, numberOfStripes: 3)
    }
    
    
    // MARK: - Actions
    
    @IBAction func setBeltLevelButtonTapped(_ sender: DesignableButton) {
        
        let setBeltLevel = "set belt level"
        let setNumberOfStripes = "set number of stripes"
        
        
        if self.setBeltLevelButtonOutlet.titleLabel?.text == setBeltLevel {
            
            setBeltLevelButtonOutlet.isHidden = true
            nextButtonOutlet.isHidden = true
            stripeNumberPickerView.isHidden = true
            beltLevelPickerView.isHidden = false
            self.setBeltLevelButtonOutlet.titleLabel?.text = setNumberOfStripes
            
        } else if self.setBeltLevelButtonOutlet.titleLabel?.text == setNumberOfStripes {
            
            setBeltLevelButtonOutlet.isHidden = true
            nextButtonOutlet.isHidden = true
            stripeNumberPickerView.isHidden = false
            beltLevelPickerView.isHidden = true
            self.setBeltLevelButtonOutlet.titleLabel?.text = setBeltLevel
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserAddress") as! AddressViewController
        
        guard let newFirstName = self.firstNameTextField.text,
            let newLastName = lastNameTextField.text,
            self.firstNameTextField.text != "",
            self.lastNameTextField.text != ""
            else {

            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = newFirstName
        destViewController.lastName = newLastName
        destViewController.beltLevel = beltLevel
        destViewController.numberOfStripes = numberOfStripes
        
        return
    }
    
    
    // MARK: - Helper Methods


}


extension NameAndBeltViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // we are going to have two pickerViews
    
    // PickerView DataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == beltLevelPickerView {
            guard let isKid = isKid else { return 0 }
            
            if isKid {
                return beltBuilder.kidsBelts.count
            } else if !isKid {
                return beltBuilder.adultBelts.count
            }
        } else if pickerView == stripeNumberPickerView {
            
            let stripesArray = beltBuilder.howManyStripes(belt: self.beltLevel)
            return stripesArray.count
        }
        
        return 0
    }
    
    // PickerView Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == beltLevelPickerView {
            
            guard let isKid = isKid else { return nil }
            
            if isKid {
                return beltBuilder.kidsBelts[row].rawValue
            } else if !isKid {
                return beltBuilder.adultBelts[row].rawValue
            }
        } else if pickerView == stripeNumberPickerView {
            
            let stripesArray = beltBuilder.howManyStripes(belt: self.beltLevel)
            return "\(stripesArray[row])"
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let isKid = isKid else {
            print("the isKid value is somehow nil in pickerView delegate method didSelectRow in NameAndBeltVC.swift - line 146")
            return
        }
        
        if pickerView == beltLevelPickerView {
            
            if isKid {
                self.beltLevel = beltBuilder.kidsBelts[row]
            } else {
                self.beltLevel = beltBuilder.adultBelts[row]
            }
            
        } else if pickerView == stripeNumberPickerView {
            
            let stripesArray = beltBuilder.howManyStripes(belt: self.beltLevel)
            
            self.numberOfStripes = stripesArray[row]
        }
    }
}
