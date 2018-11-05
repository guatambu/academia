//
//  OwnerProfileInitialSetUpTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/21/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class OwnerProfileInitialSetUpTableViewController: UITableViewController, SegueFromSaveProfileNibCellDelegate {

    // MARK: - Properties
    
    var isOwner: Bool?
    var username: String?
    var password: String?
    
    let cells: [MyCells] = [MyCells.profilePicCell, MyCells.beltCell, MyCells.usernameCell, MyCells.passwordCell, MyCells.firstNameCell, MyCells.lastNameCell, MyCells.streetAddressCell, MyCells.cityCell, MyCells.stateCell, MyCells.zipCodeCell, MyCells.phoneCell, MyCells.mobileCell, MyCells.emailCell, MyCells.saveProfileButtonCell]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("******** OwnerProfileInitialSetupTVC \n isOwner: \(isOwner) \n username: \(username) \n password: \(password)")
        
    }
    
    
    // MARK: - Save Profile Cell Delegate Method
    
    func callSegueFromNibCell(nibCellData dataobject: AnyObject) {
        self.performSegue(withIdentifier: "initialProfileSaveSegue", sender: dataobject)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        func nibRegistration(nibName: String, forCellReuseIdentifier: String) -> UINib {
//            let nib = UINib(nibName: nibName, bundle: nil)
//            self.tableView.register(nib, forCellReuseIdentifier: forCellReuseIdentifier)
//            return nib
//        }
        
        let myCell = cells[indexPath.row]
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-LightOblique", size: 16)! ]
        
        // register required cell nibs
        
        let nibProfilePic = UINib(nibName: "ProfilePicCell", bundle: nil)
        self.tableView.register(nibProfilePic, forCellReuseIdentifier: "profilePicCell")
        
        let nibAdultBasicBelt = UINib(nibName: "AdultBasicBeltTemplate", bundle: nil)
        self.tableView.register(nibAdultBasicBelt, forCellReuseIdentifier: "adultBasicBeltTemplate")
        
        let nibAdultBlackBelt = UINib(nibName: "AdultBlackBeltTemplate", bundle: nil)
        self.tableView.register(nibAdultBlackBelt, forCellReuseIdentifier: "adultBlackBeltTemplate")
        
        let nibUsername = UINib(nibName: "UsernameTextFieldCell", bundle: nil)
        self.tableView.register(nibUsername, forCellReuseIdentifier: "usernameTextFieldCell")
        
        let nibPassword = UINib(nibName: "PasswordTextFieldCell", bundle: nil)
        self.tableView.register(nibPassword, forCellReuseIdentifier: "passwordTextFieldCell")
        
        let nibConfirmPassword = UINib(nibName: "ConfirmPasswordTextFieldCell", bundle: nil)
        self.tableView.register(nibConfirmPassword, forCellReuseIdentifier: "confirmPasswordTextFieldCell")
        
        let nibFirstName = UINib(nibName: "FirstNameTextFieldCell", bundle: nil)
        self.tableView.register(nibFirstName, forCellReuseIdentifier: "firstNameTextFieldCell")
        
        let nibLastName = UINib(nibName: "LastNameTextFieldCell", bundle: nil)
        self.tableView.register(nibLastName, forCellReuseIdentifier: "lastNameTextFieldCell")
        
        let nibStreetAddress = UINib(nibName: "StreetAddressTextFieldCell", bundle: nil)
        self.tableView.register(nibStreetAddress, forCellReuseIdentifier: "streetAddressTextFieldCell")
        
        let nibCity = UINib(nibName: "CityTextFieldCell", bundle: nil)
        self.tableView.register(nibCity, forCellReuseIdentifier: "cityTextFieldCell")
        
        let nibState = UINib(nibName: "StateTextFieldCell", bundle: nil)
        self.tableView.register(nibState, forCellReuseIdentifier: "stateTextFieldCell")
        
        let nibZipCode = UINib(nibName: "ZipCodeTextFieldCell", bundle: nil)
        self.tableView.register(nibZipCode, forCellReuseIdentifier: "zipCodeTextFieldCell")
        
        let nibPhone = UINib(nibName: "PhoneTextFieldCell", bundle: nil)
        self.tableView.register(nibPhone, forCellReuseIdentifier: "phoneTextFieldCell")
        
        let nibMobile = UINib(nibName: "MobileTextFieldCell", bundle: nil)
        self.tableView.register(nibMobile, forCellReuseIdentifier: "mobileTextFieldCell")
        
        let nibEmail = UINib(nibName: "EmailTextFieldCell", bundle: nil)
        self.tableView.register(nibEmail, forCellReuseIdentifier: "emailTextFieldCell")
        
        let nibSaveProfile = UINib(nibName: "SaveProfileCell", bundle: nil)
        self.tableView.register(nibSaveProfile, forCellReuseIdentifier: "saveProfileCell")
        
        // switch on myCell to setup the tableView
        
        switch myCell {
            
        case .beltCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "adultBlackBeltTemplate", for: indexPath) as? AdultBlackBeltTableViewCell {
                tableView.estimatedRowHeight = 100
                tableView.rowHeight = 100
                return cell
            }
        case .cityCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cityTextFieldCell", for: indexPath) as? CityTextFieldTableViewCell {
                
                cell.cityTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .emailCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "emailTextFieldCell", for: indexPath) as? EmailTextFieldTableViewCell {
                
                cell.emailTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .firstNameCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "firstNameTextFieldCell", for: indexPath) as? FirstNameTextFieldTableViewCell {
                
                cell.firstNameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .isInstructorCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "isInstructorTextFieldCell", for: indexPath) as? IsInstructorTableViewCell {
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .lastNameCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "lastNameTextFieldCell", for: indexPath) as? LastNameTextFieldTableViewCell {
                
                cell.lastNameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .mobileCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mobileTextFieldCell", for: indexPath) as? MobileTextFieldTableViewCell {
                
                cell.mobileTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .passwordCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "passwordTextFieldCell", for: indexPath) as? PasswordTextFieldTableViewCell {
                
                cell.passwordTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .confirmPasswordCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "confirmPasswordTextFieldCell", for: indexPath) as? ConfirmPasswordTextFieldTableViewCell {
                
                cell.confirmPasswordTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .phoneCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "phoneTextFieldCell", for: indexPath) as? PhoneTextFieldTableViewCell {
                
                cell.phoneTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .profilePicCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "profilePicCell", for: indexPath) as? ProfilePicTableViewCell {
                tableView.estimatedRowHeight = 200
                tableView.rowHeight = 200
                return cell
            }
        case .saveProfileButtonCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "saveProfileCell", for: indexPath) as? SaveProfileTableViewCell {
                
                cell.delegate = self
                
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .stateCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "stateTextFieldCell", for: indexPath) as? StateTextFieldTableViewCell {
                
                cell.stateTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .streetAddressCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "streetAddressTextFieldCell", for: indexPath) as? StreetAddressTextFieldTableViewCell {
                
                cell.streetAddressTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .usernameCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "usernameTextFieldCell", for: indexPath) as? UsernameTextFieldTableViewCell {
                
                cell.usernameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .zipCodeCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "zipCodeTextFieldCell", for: indexPath) as? ZipCodeTextFieldTableViewCell {
                
                cell.zipCodeTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        default: print("\(myCell.rawValue) is not supposeed to be in the owner onboarding workflow, or if is valid, the switch statement in OwnerProfileInitialSetupTableViewController needs to be updated.")
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
