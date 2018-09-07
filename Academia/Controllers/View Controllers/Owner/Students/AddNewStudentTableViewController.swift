//
//  AddNewStudentTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/27/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddNewStudentTableViewController: UITableViewController {

    // MARK: - Properties
    
    let cells: [MyCells] = [MyCells.profilePicCell, MyCells.beltCell, MyCells.statusCell, MyCells.isKidCell, MyCells.isInstructorCell, MyCells.usernameCell, MyCells.firstNameCell, MyCells.lastNameCell, MyCells.parentGuardianCell, MyCells.paymentProgramCell, MyCells.schoolGroupsCell, MyCells.streetAddressCell, MyCells.cityCell, MyCells.stateCell, MyCells.zipCodeCell, MyCells.phoneCell, MyCells.mobileCell, MyCells.emailCell, MyCells.emergencyContactCell, MyCells.emergencyContactPhoneCell, MyCells.emergencyContactRelationshipCell, MyCells.saveProfileButtonCell]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lastCell = cells.count - 1
        
        if indexPath.row == 0 {
            
            let nib = UINib(nibName: "ProfilePicCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "profilePicCell")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "profilePicCell", for: indexPath) as? ProfilePicTableViewCell {
                return cell
            }
        } else if indexPath.row == 1 {
            
            let nib = UINib(nibName: "AdultBasicBeltTemplate", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "adultBasicBeltTemplate")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "adultBasicBeltTemplate", for: indexPath) as? AdultBasicBeltTableViewCell {
                return cell
            }
        } else if indexPath.row == 2 {
            
            let nib = UINib(nibName: "StatusCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "statusCell")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as? StatusTableViewCell {
                return cell
            }
        } else if indexPath.row == 3 {
                
            let nib = UINib(nibName: "IsKidCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "isKidCell")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "isKidCell", for: indexPath) as? IsKidTableViewCell {
                return cell
            }
        } else if indexPath.row == 4 {
            
                let nib = UINib(nibName: "IsInstructorCell", bundle: nil)
                self.tableView.register(nib, forCellReuseIdentifier: "isInstructorCell")
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "isInstructorCell", for: indexPath) as? IsInstructorTableViewCell {
                    return cell
            }
        
        } else if indexPath.row == lastCell {
            
            let nib = UINib(nibName: "SaveProfileCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "saveProfileCell")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "saveProfileCell", for: indexPath) as? SaveProfileTableViewCell {
                return cell
            }
        } else {
            
            let nib = UINib(nibName: "ProfileTextFieldCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "profileTextFieldCell")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "profileTextFieldCell", for: indexPath) as? ProfileTextFieldTableViewCell {
                let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                                   NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
                
                let myCell = cells[indexPath.row]
                
                switch myCell {
                case .beltCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .birthdate: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .cityCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .emailCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .emergencyContactCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .emergencyContactPhoneCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .emergencyContactRelationshipCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .firstNameCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .isInstructorCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .isKidCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .lastNameCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .locationNameCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .mobileCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .parentGuardianCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .paymentProgramCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .phoneCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .profilePicCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .saveProfileButtonCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .schoolGroupsCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .socialNetworksCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .stateCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .statusCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .streetAddressCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .usernameCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .websiteCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                case .zipCodeCell: cell.textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                    
                }
                
                return cell
            }
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
