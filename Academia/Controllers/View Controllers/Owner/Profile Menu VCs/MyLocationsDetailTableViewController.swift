//
//  MyLocationsDetailTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class MyLocationsDetailTableViewController: UITableViewController, SegueFromSaveProfileNibCellDelegate {

    // MARK: - Properties
    
    let cells: [MyCells] = [MyCells.profilePicCell, MyCells.locationNameCell, MyCells.streetAddressCell, MyCells.cityCell, MyCells.stateCell, MyCells.zipCodeCell, MyCells.phoneCell, MyCells.websiteCell, MyCells.emailCell, MyCells.socialNetworksCell, MyCells.saveProfileButtonCell]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Save Profile Cell Delegate Method
    
    func callSegueFromNibCell(nibCellData dataobject: AnyObject) {
        self.performSegue(withIdentifier: "toOwnerProfileFromAddLocation", sender: dataobject)
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = cells[indexPath.row]
        
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        // register required cell nibs
        
        let nibProfilePic = UINib(nibName: "ProfilePicCell", bundle: nil)
        self.tableView.register(nibProfilePic, forCellReuseIdentifier: "profilePicCell")
        
        let nibLocationName = UINib(nibName: "LocationNameTextFieldCell", bundle: nil)
        self.tableView.register(nibLocationName, forCellReuseIdentifier: "locationNameTextFieldCell")
        
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
        
        let nibWebsite = UINib(nibName: "WebsiteTextFieldCell", bundle: nil)
        self.tableView.register(nibWebsite, forCellReuseIdentifier: "websiteTextFieldCell")
        
        let nibEmail = UINib(nibName: "EmailTextFieldCell", bundle: nil)
        self.tableView.register(nibEmail, forCellReuseIdentifier: "emailTextFieldCell")
        
        let nibSocialNetworks = UINib(nibName: "SocialNetworksTextFieldCell", bundle: nil)
        self.tableView.register(nibSocialNetworks, forCellReuseIdentifier: "socialNetworksTextFieldCell")
        
        let nibSaveProfile = UINib(nibName: "SaveProfileCell", bundle: nil)
        self.tableView.register(nibSaveProfile, forCellReuseIdentifier: "saveProfileCell")
        
                
        // switch on myCell to setup the tableView
        
        switch myCell {
            
        case .cityCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cityTextFieldCell", for: indexPath) as? CityTextFieldTableViewCell {
                
                cell.cityTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                return cell
            }
        case .emailCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "emailTextFieldCell", for: indexPath) as? EmailTextFieldTableViewCell {
                
                cell.emailTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                return cell
            }
        case .locationNameCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "locationNameTextFieldCell", for: indexPath) as? LocationNameTextFieldTableViewCell {
                
                cell.locationNameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                return cell
            }
        case .phoneCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "phoneTextFieldCell", for: indexPath) as? PhoneTextFieldTableViewCell {
                
                cell.phoneTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                return cell
            }
        case .profilePicCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "profilePicCell", for: indexPath) as? ProfilePicTableViewCell {
                return cell
            }
        case .saveProfileButtonCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "saveProfileCell", for: indexPath) as? SaveProfileTableViewCell {
                cell.delegate = self
                return cell
            }
        case .stateCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "stateTextFieldCell", for: indexPath) as? StateTextFieldTableViewCell {
                
                cell.stateTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                return cell
            }
        case .streetAddressCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "streetAddressTextFieldCell", for: indexPath) as? StreetAddressTextFieldTableViewCell {
                
                cell.streetAddressTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                return cell
            }
        case .websiteCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "websiteTextFieldCell", for: indexPath) as? WebsiteTextFieldTableViewCell {
                
                cell.websiteTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
                return cell
            }
        case .zipCodeCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "zipCodeTextFieldCell", for: indexPath) as? ZipCodeTextFieldTableViewCell {
                
                cell.zipCodeTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "\(myCell.rawValue)", attributes: avenirFont)
                
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
