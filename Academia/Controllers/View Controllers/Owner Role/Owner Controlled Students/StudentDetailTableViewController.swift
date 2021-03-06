//
//  StudentDetailTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/27/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentDetailTableViewController: UITableViewController, SegueFromSaveProfileNibCellDelegate {

    // MARK: - Properties
    
    var adultStudent: AdultStudent?
    
    var kidStudent: KidStudent?
    
    var kidStudentCells = [
        MyCells.profilePicCell,
        MyCells.beltCell,
        MyCells.statusCell,
        MyCells.usernameCell,
        MyCells.firstNameCell,
        MyCells.lastNameCell,
        MyCells.parentGuardianCell,
        MyCells.streetAddressCell,
        MyCells.cityCell,
        MyCells.stateCell,
        MyCells.zipCodeCell,
        MyCells.phoneCell,
        MyCells.mobileCell,
        MyCells.emailCell,
        MyCells.emergencyContactCell,
        MyCells.emergencyContactPhoneCell,
        MyCells.emergencyContactRelationshipCell,
        MyCells.saveProfileButtonCell
    ]

    var adultStudentCells = [
        MyCells.profilePicCell,
        MyCells.beltCell,
        MyCells.statusCell,
        MyCells.isInstructorCell,
        MyCells.usernameCell,
        MyCells.firstNameCell,
        MyCells.lastNameCell,
        MyCells.parentGuardianCell,
        MyCells.streetAddressCell,
        MyCells.cityCell,
        MyCells.stateCell,
        MyCells.zipCodeCell,
        MyCells.phoneCell,
        MyCells.mobileCell,
        MyCells.emailCell,
        MyCells.emergencyContactCell,
        MyCells.emergencyContactPhoneCell,
        MyCells.emergencyContactRelationshipCell,
        MyCells.saveProfileButtonCell
    ]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - SegueFromSaveProfileNibCellDelegate protocol method
    
    func callSegueFromNibCell(nibCellData dataobject: AnyObject) {
        self.performSegue(withIdentifier: "initialAdultStudentSegue", sender: dataobject)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if adultStudent != nil {
            return adultStudentCells.count
        } else if kidStudent != nil {
            return kidStudentCells.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        //        func nibRegistration(nibName: String, forCellReuseIdentifier: String) -> UINib {
        //            let nib = UINib(nibName: nibName, bundle: nil)
        //            self.tableView.register(nib, forCellReuseIdentifier: forCellReuseIdentifier)
        //            return nib
        //        }
        
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        // register required cell nibs
        
        let nibProfilePic = UINib(nibName: "ProfilePicCell", bundle: nil)
        self.tableView.register(nibProfilePic, forCellReuseIdentifier: "profilePicCell")
        
        let nibAdultBasicBelt = UINib(nibName: "AdultBasicBeltTemplate", bundle: nil)
        self.tableView.register(nibAdultBasicBelt, forCellReuseIdentifier: "adultBasicBeltTemplate")
        
        let nibAdultBlackBelt = UINib(nibName: "AdultBlackBeltTemplate", bundle: nil)
        self.tableView.register(nibAdultBlackBelt, forCellReuseIdentifier: "adultBlackBeltTemplate")
        
        let nibKidsBelt = UINib(nibName: "KidsBeltTemplate", bundle: nil)
        self.tableView.register(nibKidsBelt, forCellReuseIdentifier: "kidsBeltTemplate")
        
        let nibStatus = UINib(nibName: "StatusCell", bundle: nil)
        self.tableView.register(nibStatus, forCellReuseIdentifier: "statusCell")
        
        let nibIsInstructor = UINib(nibName: "IsInstructorCell", bundle: nil)
        self.tableView.register(nibIsInstructor, forCellReuseIdentifier: "isInstructorCell")
        
        let nibUsername = UINib(nibName: "UsernameTextFieldCell", bundle: nil)
        self.tableView.register(nibUsername, forCellReuseIdentifier: "usernameTextFieldCell")
        
        let nibFirstName = UINib(nibName: "FirstNameTextFieldCell", bundle: nil)
        self.tableView.register(nibFirstName, forCellReuseIdentifier: "firstNameTextFieldCell")
        
        let nibLastName = UINib(nibName: "LastNameTextFieldCell", bundle: nil)
        self.tableView.register(nibLastName, forCellReuseIdentifier: "lastNameTextFieldCell")
        
        let nibParentGuardian = UINib(nibName: "ParentGuardianTextFieldCell", bundle: nil)
        self.tableView.register(nibParentGuardian, forCellReuseIdentifier: "parentGuardianTextFieldCell")
        
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
        
        let nibEmergencyContact = UINib(nibName: "EmergencyContactTextFieldCell", bundle: nil)
        self.tableView.register(nibEmergencyContact, forCellReuseIdentifier: "emergencyContactTextFieldCell")
        
        let nibEmergencyContactPhone = UINib(nibName: "EmergencyContactPhoneTextFieldCell", bundle: nil)
        self.tableView.register(nibEmergencyContactPhone, forCellReuseIdentifier: "emergencyContactPhoneTextFieldCell")
        
        let nibEmergencyContactRelationship = UINib(nibName: "EmergencyContactRelationshipTextFieldCell", bundle: nil)
        self.tableView.register(nibEmergencyContactRelationship, forCellReuseIdentifier: "emergencyContactRelationshipTextFieldCell")
        
        let nibSaveProfile = UINib(nibName: "SaveProfileCell", bundle: nil)
        self.tableView.register(nibSaveProfile, forCellReuseIdentifier: "saveProfileCell")
        
        // determine which type of cell is "myCell"
        
        var myCell: MyCells = .usernameCell
        
        if adultStudent != nil {
            myCell = adultStudentCells[indexPath.row]
        } else if kidStudent != nil {
            myCell = kidStudentCells[indexPath.row]
        }
            
        // switch on myCell to setup the tableView
        switch myCell {
            
            // use "where" clause to determine distinction between between adult and kid students?
            
        case .beltCell:
            if adultStudent != nil {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "adultBasicBeltTemplate", for: indexPath) as? AdultBasicBeltTableViewCell {
                    tableView.estimatedRowHeight = 100
                    tableView.rowHeight = 100
                    return cell
                }
            } else if kidStudent != nil {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "kidsBeltTemplate", for: indexPath) as? KidsBeltTableViewCell {
                    tableView.estimatedRowHeight = 100
                    tableView.rowHeight = 100
                    return cell
                }
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
        case .emergencyContactCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "emergencyContactTextFieldCell", for: indexPath) as? EmergencyContactTextFieldTableViewCell {
                
                cell.emergencyContactTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .emergencyContactPhoneCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "emergencyContactPhoneTextFieldCell", for: indexPath) as? EmergencyContactPhoneTextFieldTableViewCell {
                
                cell.emergencyContactPhoneTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                tableView.estimatedRowHeight = 80
                tableView.rowHeight = 80
                
                return cell
            }
        case .emergencyContactRelationshipCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "emergencyContactRelationshipTextFieldCell", for: indexPath) as? EmergencyContactRelationshipTextFieldTableViewCell {
                
                cell.emergencyContactRelationshipTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "isInstructorCell", for: indexPath) as? IsInstructorTableViewCell {
                
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
        case .parentGuardianCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "parentGuardianTextFieldCell", for: indexPath) as? ParentGuardianTextFieldTableViewCell {
                
                cell.parentGuardianTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
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
        case .statusCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as? StatusTableViewCell {
                
                cell.detailLabelOutlet.text = "PAID - 06/15/2018"  // eventually will be date of last successful payment from payment program object
                
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
        default: print("\(myCell.rawValue) is not supposeed to be in the owner onboarding workflow, or if is valid, the switch statement in OwnerProfileDetailsTableViewController needs to be updated.")
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
