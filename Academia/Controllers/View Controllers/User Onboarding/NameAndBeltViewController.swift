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
    var numberOfStripes = 0
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    
    // view that holds belt to be instantiated and displayed
    @IBOutlet weak var beltHolderViewOutlet: UIView!
    // belt level pickerView
    @IBOutlet weak var beltLevelPickerView: UIPickerView!
    // stripe number slider
    @IBOutlet weak var stripeNumberSlider: UISlider!
    
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        beltLevelPickerView.delegate = self
        beltLevelPickerView.dataSource = self
        
        stripeNumberSlider.tintColor = UIColor.red
        
        // default belt to display upon user arrival
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
        
    }
    
    
    // MARK: - Actions
    


    @IBAction func sliderValueChanged(_ sender: Any) {
        
        stripeNumberSlider.isContinuous = false
        let currentValue = Int(stripeNumberSlider.value)
        self.numberOfStripes = currentValue
        
        print(currentValue)
        
        self.beltBuilder.buildABelt(view: self.beltHolderViewOutlet, belt: self.beltLevel, numberOfStripes: self.numberOfStripes)
    }
    
    
    
  
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserAddress") as! AddressViewController
        
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
        destViewController.beltLevel = beltLevel
        destViewController.numberOfStripes = numberOfStripes
        
        return
    }
    
    
    // MARK: - Helper Methods
    
    

}


extension NameAndBeltViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // we have two pickerViews: 1 for belt level, 1 for number of stripes
    
    // PickerView DataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let isKid = isKid else { return 0 }
        
        if isKid {
            return beltBuilder.kidsBelts.count
        } else if !isKid {
            return beltBuilder.adultBelts.count
        }

        return 0
    }
    
    // PickerView Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        guard let isKid = isKid else { return nil }
        
        if isKid {
            return beltBuilder.kidsBelts[row].rawValue
        } else if !isKid {
            return beltBuilder.adultBelts[row].rawValue
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let isKid = isKid else {
            print("the isKid value is somehow nil in pickerView delegate method didSelectRow in NameAndBeltVC.swift - line 146")
            return
        }
        
        if isKid {
            self.beltLevel = beltBuilder.kidsBelts[row]
        } else {
            self.beltLevel = beltBuilder.adultBelts[row]
        }
        
        self.beltBuilder.buildABelt(view: self.beltHolderViewOutlet, belt: self.beltLevel, numberOfStripes: self.numberOfStripes)
    }
}



