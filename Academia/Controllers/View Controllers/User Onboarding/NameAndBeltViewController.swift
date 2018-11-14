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
    
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        beltLevelPickerView.delegate = self
        beltLevelPickerView.dataSource = self
        
        // default belt to display upon user arrival
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
        
    }
    
    
    // MARK: - Actions
    
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
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let isKid = isKid else { return 0 }
        
        if component == 0 {
            
            if isKid {
                return beltBuilder.kidsBelts.count
            } else if !isKid {
                return beltBuilder.adultBelts.count
            }
        } else {
            
            switch beltLevel {
                
            case .kidsWhiteBelt:
                return beltBuilder.kidsWhiteBeltStripes.count
            case .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
                
                return beltBuilder.allOtherKidsBeltStripes.count
            case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
                
                return beltBuilder.adultBasicBeltStripes.count
                
            case .adultBlackBelt:
                
                return beltBuilder.blackBeltDegrees.count
                
            case .adultRedBlackBelt:
                
                return beltBuilder.redBlackBeltDegrees.count
            case .adultRedWhiteBelt:
                
                return beltBuilder.redWhiteBeltDegrees.count
            case .adultRedBelt:
                
                return beltBuilder.redBeltDegrees.count
            default:
                print("OOOPS!  this belt is not currently represented in international standard. error: NameAndBeltVC - function sliderVlaueChanged, line 88 ")
            }
            
        }
        return 0
    }
    
    // PickerView Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        guard let isKid = isKid else { return nil }
        
        if component == 0 {
            
            if isKid {
                return beltBuilder.kidsBelts[row].rawValue
            } else if !isKid {
                return beltBuilder.adultBelts[row].rawValue
            }
        } else {
            switch beltLevel {
                
            case .kidsWhiteBelt:
                
                if beltBuilder.kidsWhiteBeltStripes[row] == 1 {
                    return "\(beltBuilder.kidsWhiteBeltStripes[row]) stripe"
                }
                return "\(beltBuilder.kidsWhiteBeltStripes[row]) stripes"
            case .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
                
                if beltBuilder.allOtherKidsBeltStripes[row] == 1 {
                    return "\(beltBuilder.allOtherKidsBeltStripes[row]) stripe"
                }
                return "\(beltBuilder.allOtherKidsBeltStripes[row]) stripes"
            case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
                
                if beltBuilder.adultBasicBeltStripes[row] == 1 {
                    return "\(beltBuilder.adultBasicBeltStripes[row]) stripe"
                }
                return "\(beltBuilder.adultBasicBeltStripes[row]) stripes"
                
            case .adultBlackBelt:
                
                if beltBuilder.blackBeltDegrees[row] == 1 {
                    return "\(beltBuilder.blackBeltDegrees[row]) degree"
                }
                return "\(beltBuilder.blackBeltDegrees[row]) degrees"
                
            case .adultRedBlackBelt:
                
                return "\(beltBuilder.redBlackBeltDegrees[row]) degrees"
            case .adultRedWhiteBelt:
                
                return "\(beltBuilder.redWhiteBeltDegrees[row]) degrees"
            case .adultRedBelt:
        
                return "\(beltBuilder.redBeltDegrees[row]) degrees"
            default:
                print("OOOPS!  this belt is not currently represented in international standard. error: NameAndBeltVC - function sliderVlaueChanged, line 88 ")
            }
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let isKid = isKid else {
            print("the isKid value is somehow nil in pickerView delegate method didSelectRow in NameAndBeltVC.swift - line 146")
            return
        }
        
        if component == 0 {
            if isKid {
                beltLevel = beltBuilder.kidsBelts[row]
                pickerView.reloadComponent(1)
            } else {
                beltLevel = beltBuilder.adultBelts[row]
                pickerView.reloadComponent(1)
            }
            
            if beltLevel == .adultRedBlackBelt {
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: 7)
            } else if beltLevel == .adultRedWhiteBelt {
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: 8)
            } else if beltLevel == .adultRedBelt {
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: 9)
            }
            
            beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: 0)
        } else {
            
            switch beltLevel {
                
            case .kidsWhiteBelt:
                pickerView.reloadComponent(1)
                
                numberOfStripes = beltBuilder.kidsWhiteBeltStripes[row]
    
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
            case .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
                
                pickerView.reloadComponent(1)

                numberOfStripes = beltBuilder.allOtherKidsBeltStripes[row]
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                
            case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
                
                pickerView.reloadComponent(1)

                numberOfStripes = beltBuilder.adultBasicBeltStripes[row]
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: 1)
                
                
            case .adultBlackBelt:
                
                pickerView.reloadComponent(1)
               
                numberOfStripes = beltBuilder.blackBeltDegrees[row]
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                
                
            case .adultRedBlackBelt:
                
                pickerView.reloadComponent(1)
                
                numberOfStripes = beltBuilder.redBlackBeltDegrees[row]
                
            case .adultRedWhiteBelt:
                
                pickerView.reloadComponent(1)
                
                numberOfStripes = beltBuilder.redWhiteBeltDegrees[row]
                
            case .adultRedBelt:
                
                pickerView.reloadComponent(1)
                
                numberOfStripes = beltBuilder.redBeltDegrees[row]
                
                if beltBuilder.redBeltDegrees[row] == 10 {
                    beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: 10)
                }
                
            default:
                print("OOOPS!  this belt is not currently represented in international standard. error: NameAndBeltVC - function pickerView didSelectRow, line 316 ")
            }
        }
    }
}



