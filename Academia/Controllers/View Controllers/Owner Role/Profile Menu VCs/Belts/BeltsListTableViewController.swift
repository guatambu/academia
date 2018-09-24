//
//  BeltsListTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltsListTableViewController: UITableViewController {

    // MARK: - Properties
    
    var kidsBelts: [InternationalStandardBJJBelts] = [.spacer, .kidsWhiteBelt, .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt]
    
    var adultBelts: [InternationalStandardBJJBelts] = [.spacer, .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt, .adultBlackBelt, .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt]
    
    var isKidsBelts: InternationalStandardBJJBelts?
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let isKidsBelts = isKidsBelts?.rawValue else { return }
        print(isKidsBelts)
        self.title = isKidsBelts
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let isKidsBelts = isKidsBelts else { return 0 }
        if isKidsBelts == .kidBelts {
            return kidsBelts.count
        } else {
            return adultBelts.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let isKidsBelts = isKidsBelts else { return UITableViewCell() }
        
        if isKidsBelts == .kidBelts {
            let nib = UINib(nibName: "KidsBeltTemplate", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "kidsBeltTemplate")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "kidsBeltTemplate", for: indexPath) as? KidsBeltTableViewCell {
                
                let myCell = kidsBelts[indexPath.row]

                switch myCell {
                case .spacer: cell.timeLabelsStackViewOutlet.isHidden = true
                    cell.beltViewOutlet.isHidden = true
                    cell.beltTimeLabelOutlet.text = myCell.rawValue
                // what setting allows this to dynamic - something to do with storyboard layout constriants
                case .kidsWhiteBelt: cell.displayKidsBeltWith(provided: kidsWhiteBelt)
                case .kidsGreyWhiteBelt: cell.displayKidsBeltWith(provided: grayWhiteBelt)
                case .kidsGreyBelt: cell.displayKidsBeltWith(provided: grayBelt)
                case .kidsGreyBlackBelt: cell.displayKidsBeltWith(provided: grayBlackBelt)
                case .kidsYellowWhiteBelt: cell.displayKidsBeltWith(provided: yellowWhiteBelt)
                case .kidsYellowBelt: cell.displayKidsBeltWith(provided: yellowBelt)
                case .kidsYellowBlackBelt: cell.displayKidsBeltWith(provided: yellowBlackBelt)
                case .kidsOrangeWhiteBelt: cell.displayKidsBeltWith(provided: orangeWhiteBelt)
                case .kidsOrangeBelt: cell.displayKidsBeltWith(provided: orangeBelt)
                case .kidsOrangeBlackBelt: cell.displayKidsBeltWith(provided: orangeBlackBelt)
                case .kidsGreenWhiteBelt: cell.displayKidsBeltWith(provided: greenWhiteBelt)
                case .kidsGreenBelt: cell.displayKidsBeltWith(provided: greenBelt)
                case .kidsGreenBlackBelt: cell.displayKidsBeltWith(provided: greenBlackBelt)
                default: print("that's not a currently active kids belt to display")
                }
                return cell
            }
            return UITableViewCell()
            
        } else if isKidsBelts == .adultBelts {
            let nib = UINib(nibName: "AdultBasicBeltTemplate", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "adultBasicBeltTemplate")
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "adultBasicBeltTemplate", for: indexPath) as? AdultBasicBeltTableViewCell {
                
                let myCell = adultBelts[indexPath.row]
                
                switch myCell {
                case .spacer: cell.beltViewOutlet.isHidden = true
                    cell.stripesStackViewOutlet.isHidden = true
                    cell.beltTimeOutlet.text = "Belt progression comes through time and dedication. Timing of promotion is your teacher's decision."
                    // what setting allows this to dynamic - something to do with storyboard layout constriants
                case .adultWhiteBelt: cell.displayAdultBasicBeltWith(provided: whiteBelt)
                case .adultBlueBelt: cell.displayAdultBasicBeltWith(provided: blueBelt)
                case .adultPurpleBelt: cell.displayAdultBasicBeltWith(provided: purpleBelt)
                case .adultBrownBelt: cell.displayAdultBasicBeltWith(provided: brownBelt)
                
                default:
                    let nib = UINib(nibName: "AdultBlackBeltTemplate", bundle: nil)
                    self.tableView.register(nib, forCellReuseIdentifier: "adultBlackBeltTemplate")
                    
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "adultBlackBeltTemplate", for: indexPath) as? AdultBlackBeltTableViewCell {
                        
                        let myBlackBeltCell = myCell
                        
                        switch myBlackBeltCell {
                        case .adultBlackBelt: cell.displayAdultBlackBeltWith(provided: blackBelt)
                        case .adultRedBlackBelt: cell.displayAdultBlackBeltWith(provided: redBlackBelt)
                        case .adultRedWhiteBelt: cell.displayAdultBlackBeltWith(provided: redWhiteBelt)
                        case .adultRedBelt: cell.displayAdultBlackBeltWith(provided: redBelt)
                        default: print("that's not a currently active adult black belt to display")
                        }
                        return cell
                    }
                }
                return cell
            }
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

