//
//  NameAndBeltViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class NameAndBeltViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var academyChoice: String?
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var parentGuardian: String?
    var profilePic: UIImage?
    var birthdate: Date?
    var beltLevel: InternationalStandardBJJBelts = .adultWhiteBelt
    var numberOfStripes: Int = 0
    
    var inEditingMode: Bool?
    var userCDToEdit: Any?
    
    var isOwnerAddingStudent: Bool?
    var group: Group?
    
    let beltBuilder = BeltBuilder()

    @IBOutlet weak var chooseYourBeltLabelOutlet: UILabel!
    // view that holds belt to be instantiated and displayed
    @IBOutlet weak var beltHolderViewOutlet: UIView!
    // belt level pickerView
    @IBOutlet weak var beltLevelPickerView: UIPickerView!
    
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    
    // CoreData Properties
    var owner: OwnerCD?
    var studentAdult: StudentAdultCD?
    var studentKid: StudentKidCD?
    var groupCD: GroupCD?
    // Firebase Properties
    var birthdateTimestamp: Timestamp?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        // check to see if enter editing mode
        enterEditingMode(inEditingMode: inEditingMode)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        beltLevelPickerView.delegate = self
        beltLevelPickerView.dataSource = self
        
        guard let isKid = isKid else { return }
        
        // default belt to display upon user arrival
        if isKid {
            beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: .kidsWhiteBelt, numberOfStripes: 0)
            beltLevel = .kidsWhiteBelt
        } else {
            beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: .adultWhiteBelt, numberOfStripes: 0)
        }
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        if let isOwner = isOwner {
            if isOwner {
                // Owner update belt info
                updateOwnerInfo()
                self.returnToOwnerInfo()
            }
        }
        if let isKid = isKid {
            if isKid {
                // kidStudent update belt info
                updateKidStudentInfo()
                self.returnToStudentInfo()
                }
            } else {
                // adultStudent update belt info
                updateAdultStudentInfo()
                self.returnToStudentInfo()
            
            
        }
        
        inEditingMode = false
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
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.academyChoice = academyChoice
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = firstName
        destViewController.lastName = lastName
        destViewController.parentGuardian = parentGuardian
        destViewController.profilePic = profilePic
        destViewController.birthdate = birthdate
        destViewController.birthdateTimestamp = birthdateTimestamp
        
        destViewController.beltLevel = beltLevel
        destViewController.numberOfStripes = numberOfStripes
        
        destViewController.isOwnerAddingStudent = isOwnerAddingStudent
        destViewController.group = group
        destViewController.groupCD = groupCD
        
        destViewController.inEditingMode = inEditingMode
        destViewController.userCDToEdit = userCDToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        if let isOwner = isOwner {
            if isOwner {
                updateOwnerInfo()
            }
        }
        if let isKid = isKid {
            if isKid {
                updateKidStudentInfo()
            } else {
                updateAdultStudentInfo()
            }
        }
    }
}


// MARK: - PickerView Functionality
extension NameAndBeltViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
                print("OOOPS!  this belt is not currently represented in international standard. error: NameAndBeltVC.swift -> pickerView(pickerView: numberOfRowsInComponent:) - line 218.")
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
                
                if beltBuilder.kidsWhiteBeltStripes[row] == 0 {
                    return "\(beltBuilder.kidsWhiteBeltStripes[row]) stripes"
                } else if beltBuilder.kidsWhiteBeltStripes[row] == 1 {
                    return "\(beltBuilder.kidsWhiteBeltStripes[row]) stripe"
                }
                return "\(beltBuilder.kidsWhiteBeltStripes[row]) stripes"
            case .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
                
                if beltBuilder.allOtherKidsBeltStripes[row] == 0 {
                    return "\(beltBuilder.allOtherKidsBeltStripes[row]) stripes"
                } else if beltBuilder.allOtherKidsBeltStripes[row] == 1 {
                    return "\(beltBuilder.allOtherKidsBeltStripes[row]) stripe"
                }
                return "\(beltBuilder.allOtherKidsBeltStripes[row]) stripes"
            case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
                
                if beltBuilder.adultBasicBeltStripes[row] == 0 {
                    return "\(beltBuilder.adultBasicBeltStripes[row]) stripes"
                } else if beltBuilder.adultBasicBeltStripes[row] == 1 {
                    return "\(beltBuilder.adultBasicBeltStripes[row]) stripe"
                }
                return "\(beltBuilder.adultBasicBeltStripes[row]) stripes"
                
            case .adultBlackBelt:
                
                if beltBuilder.blackBeltDegrees[row] == 0 {
                    return "\(beltBuilder.blackBeltDegrees[row]) degrees"
                } else if beltBuilder.blackBeltDegrees[row] == 1 {
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
                print("OOOPS!  this belt is not currently represented in international standard. error: NameAndBeltVC.swift -> pickerView(pickerView: titleForRow: forComponent component:) - line 284.")
            }
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let isKid = isKid else {
            print("the isKid value is somehow nil in pickerView delegate method didSelectRow in NameAndBeltVC.swift - line: 294.")
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
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            
            beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: 0)
            
            if beltLevel == .adultRedBlackBelt {
                
                numberOfStripes = 7
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                
            } else if beltLevel == .adultRedWhiteBelt {
                
                numberOfStripes = 8
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                
            } else if beltLevel == .adultRedBelt {
                
                numberOfStripes = 9
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                beltBuilder.beltGraduationBar.removeFromSuperview()
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
            }
            
            pickerView.selectRow(0, inComponent: 1, animated: true)
            
        } else {
            
            switch beltLevel {
                
            case .kidsWhiteBelt:
                pickerView.reloadComponent(1)
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                
                numberOfStripes = beltBuilder.kidsWhiteBeltStripes[row]
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
            case .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
                
                pickerView.reloadComponent(1)
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }

                numberOfStripes = beltBuilder.allOtherKidsBeltStripes[row]
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                
            case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
                
                pickerView.reloadComponent(1)
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }

                numberOfStripes = beltBuilder.adultBasicBeltStripes[row]
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                
                
            case .adultBlackBelt:
                
                pickerView.reloadComponent(1)
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
               
                numberOfStripes = beltBuilder.blackBeltDegrees[row]
                
                beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                
                
            case .adultRedBlackBelt:
                
                pickerView.reloadComponent(1)
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
             
            case .adultRedWhiteBelt:
                
                pickerView.reloadComponent(1)
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                
            case .adultRedBelt:
                
                pickerView.reloadComponent(1)
                
                for view in beltBuilder.stripesStackView.arrangedSubviews {
                    beltBuilder.stripesStackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                
                numberOfStripes = beltBuilder.redBeltDegrees[row]
                
                if beltBuilder.redBeltDegrees[row] == 10 {
                    beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
                }
                
            default:
                print("OOOPS!  this belt is not currently represented in international standard. error:  NameAndBeltVC.swift -> pickerView(pickerView: didSelectRow: inComponent:) - line 441.")
            }
        }
    }
}


//MARK: Editing Mode set up functions
extension NameAndBeltViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateOwnerInfo() {
        
        // CoreData Belt property update
        guard let ownerCD = userCDToEdit as? OwnerCD else { return }
        guard let belt = ownerCD.belt else { return }
        let stripesInt16 = Int16(exactly: numberOfStripes)
        
        BeltCDModelController.shared.update(belt: belt, active: nil, elligibleForNextBelt: nil, beltLevel: beltLevel.rawValue, numberOfStripes: stripesInt16)
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateKidStudentInfo() {
        
        // CoreData Belt property update
        guard let studentKidCD = userCDToEdit as? StudentKidCD else { return }
        guard let belt = studentKidCD.belt else { return }
        let stripesInt16 = Int16(exactly: numberOfStripes)
        
        BeltCDModelController.shared.update(belt: belt, active: nil, elligibleForNextBelt: nil, beltLevel: beltLevel.rawValue, numberOfStripes: stripesInt16)
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func updateAdultStudentInfo() {
        
        // CoreData Belt property update
        guard let studentAdultCD = userCDToEdit as? StudentAdultCD else { return }
        guard let belt = studentAdultCD.belt else { return }
        let stripesInt16 = Int16(exactly: numberOfStripes)
        
        BeltCDModelController.shared.update(belt: belt, active: nil, elligibleForNextBelt: nil, beltLevel: beltLevel.rawValue, numberOfStripes: stripesInt16)
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            if let isOwner = isOwner {
                if isOwner {
                    ownerEditingSetup(userToEdit: userCDToEdit)
                }
            }
            if let isKid = isKid {
                if isKid {
                    kidStudentEditingSetup(userToEdit: userCDToEdit)
                } else {
                    adultStudentEditingSetup(userToEdit: userCDToEdit)
                }
            }
        }
        
        print("NameAndBeltVC -> inEditingMode = \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func ownerEditingSetup(userToEdit: Any?) {
        
        guard let ownerToEdit = userToEdit as? OwnerCD else { return }
        guard let belt = ownerToEdit.belt else { return }
        
        guard let numberOfStripesInt = Int(exactly: belt.numberOfStripes) else {
            print("ERROR: no value found for numberOfStripes in OwnerInfoDetailsViewController.swift -> ownerEditingSetup(userToEdit:) - line 517.")
            return
        }
        
        chooseYourBeltLabelOutlet.text = "Welcome \(ownerToEdit.firstName ?? "")"
        
        beltLevel = InternationalStandardBJJBelts(rawValue: belt.beltLevel!) ?? .adultWhiteBelt
        
        numberOfStripes = numberOfStripesInt
        
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
        
        setEditingModeForBeltPicker(beltLevel: beltLevel, numberOfStripes: numberOfStripes)
    }
    
    // kid student setu for editing mode
    func kidStudentEditingSetup(userToEdit: Any?) {
        
        guard let kidToEdit = userToEdit as? StudentKidCD else { return }
        guard let belt = kidToEdit.belt else { return }
        
        guard let numberOfStripesInt = Int(exactly: belt.numberOfStripes) else {
            print("ERROR: no value found for numberOfStripes in OwnerInfoDetailsViewController.swift -> kidStudentEditingSetup(userToEdit:) - line 539.")
            return
        }
        
        chooseYourBeltLabelOutlet.text = "Welcome \(kidToEdit.firstName ?? "")"
        
        beltLevel = InternationalStandardBJJBelts(rawValue: belt.beltLevel!) ?? .adultWhiteBelt
        
        numberOfStripes = numberOfStripesInt
        
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
        
        setEditingModeForBeltPicker(beltLevel: beltLevel, numberOfStripes: numberOfStripes)
    }
    
    // adult student setu for editing mode
    func adultStudentEditingSetup(userToEdit: Any?) {
        
        guard let adultToEdit = userToEdit as? StudentAdultCD else { return }
        guard let belt = adultToEdit.belt else { return }
        
        guard let numberOfStripesInt = Int(exactly: belt.numberOfStripes) else {
            print("ERROR: no value found for numberOfStripes in OwnerInfoDetailsViewController.swift -> adultStudentEditingSetup(userToEdit:) - line 561.")
            return
        }
        
        chooseYourBeltLabelOutlet.text = "Welcome \(adultToEdit.firstName ?? "")"
        
        beltLevel = InternationalStandardBJJBelts(rawValue: belt.beltLevel!) ?? .adultWhiteBelt
        
        numberOfStripes = numberOfStripesInt
        
        beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevel, numberOfStripes: numberOfStripes)
        
        setEditingModeForBeltPicker(beltLevel: beltLevel, numberOfStripes: numberOfStripes) 
    }
    
    
    func setEditingModeForBeltPicker(beltLevel: InternationalStandardBJJBelts?, numberOfStripes: Int?) {
        
        guard let beltLevel = beltLevel, let numberOfStripes = numberOfStripes else {
            print("no value for editing mode beltLevel or numberOfStripes or both in: NameAndBeltVC -> setEditingModeForBeltPicker(beltLevel: numberOfStripes:) - line 580.")
            return
        }
        
        switch beltLevel {
            
        case .kidsWhiteBelt:
            beltLevelPickerView.selectRow(0, inComponent: 0, animated: true)
        case .kidsGreyWhiteBelt:
            beltLevelPickerView.selectRow(1, inComponent: 0, animated: true)
        case .kidsGreyBelt:
            beltLevelPickerView.selectRow(2, inComponent: 0, animated: true)
        case .kidsGreyBlackBelt:
            beltLevelPickerView.selectRow(3, inComponent: 0, animated: true)
        case .kidsYellowWhiteBelt:
            beltLevelPickerView.selectRow(4, inComponent: 0, animated: true)
        case .kidsYellowBelt:
            beltLevelPickerView.selectRow(5, inComponent: 0, animated: true)
        case .kidsYellowBlackBelt:
            beltLevelPickerView.selectRow(6, inComponent: 0, animated: true)
        case .kidsOrangeWhiteBelt:
            beltLevelPickerView.selectRow(7, inComponent: 0, animated: true)
        case .kidsOrangeBelt:
            beltLevelPickerView.selectRow(8, inComponent: 0, animated: true)
        case .kidsOrangeBlackBelt:
            beltLevelPickerView.selectRow(9, inComponent: 0, animated: true)
        case .kidsGreenWhiteBelt:
            beltLevelPickerView.selectRow(10, inComponent: 0, animated: true)
        case .kidsGreenBelt:
            beltLevelPickerView.selectRow(11, inComponent: 0, animated: true)
        case .kidsGreenBlackBelt:
            beltLevelPickerView.selectRow(12, inComponent: 0, animated: true)
        case .adultWhiteBelt:
            beltLevelPickerView.selectRow(0, inComponent: 0, animated: true)
        case .adultBlueBelt:
            beltLevelPickerView.selectRow(1, inComponent: 0, animated: true)
        case .adultPurpleBelt:
            beltLevelPickerView.selectRow(2, inComponent: 0, animated: true)
        case .adultBrownBelt:
            beltLevelPickerView.selectRow(3, inComponent: 0, animated: true)
        case .adultBlackBelt:
            beltLevelPickerView.selectRow(4, inComponent: 0, animated: true)
        case .adultRedBlackBelt:
            beltLevelPickerView.selectRow(5, inComponent: 0, animated: true)
        case .adultRedWhiteBelt:
            beltLevelPickerView.selectRow(6, inComponent: 0, animated: true)
        case .adultRedBelt:
            beltLevelPickerView.selectRow(7, inComponent: 0, animated: true)
            
        default: print("that's NOT A BELT being used in: NameAndBeltVC -> setEditingModeForBeltPicker(beltLevel: numberOfStripes:) - line 629.")
        }
        
        switch numberOfStripes {
            
        case 0:
            beltLevelPickerView.selectRow(0, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 1:
            beltLevelPickerView.selectRow(1, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 2:
            beltLevelPickerView.selectRow(2, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 3:
            beltLevelPickerView.selectRow(3, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 4:
            beltLevelPickerView.selectRow(4, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 5:
            beltLevelPickerView.selectRow(5, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 6:
            beltLevelPickerView.selectRow(6, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 7:
            beltLevelPickerView.selectRow(7, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 8:
            beltLevelPickerView.selectRow(8, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 9:
            beltLevelPickerView.selectRow(9, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 10:
            beltLevelPickerView.selectRow(10, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
        case 11:
            beltLevelPickerView.selectRow(11, inComponent: 1, animated: true)
            print("numberOfStripes: \(numberOfStripes)")
            
        default: print("that's NOT A STRIPE being used in: NameAndBeltVC -> setEditingModeForBeltPicker(beltLevel: numberOfStripes:) - line 671.")
        }
    }
}
