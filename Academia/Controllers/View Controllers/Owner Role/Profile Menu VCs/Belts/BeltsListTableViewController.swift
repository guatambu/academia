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
    @IBOutlet weak var beltDisclaimerLabelOutlet: UILabel!
    @IBOutlet weak var beltDisclaimerViewOutlet: UIView!
    
    var kidsBelts: [InternationalStandardBJJBelts] = [.kidsWhiteBelt, .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt]
    
    var adultBelts: [InternationalStandardBJJBelts] = [.adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt, .adultBlackBelt, .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt]
    
    var isKidsBelts: InternationalStandardBJJBelts?
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        beltDisclaimerLabelOutlet.text = InternationalStandardBJJBelts.beltDisclaimer.rawValue
        
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
                
                case .kidsWhiteBelt: cell.displayKidsBeltWith(provided: MockData.kidsWhiteBelt)
                case .kidsGreyWhiteBelt: cell.displayKidsBeltWith(provided: MockData.grayWhiteBelt)
                case .kidsGreyBelt: cell.displayKidsBeltWith(provided: MockData.grayBelt)
                case .kidsGreyBlackBelt: cell.displayKidsBeltWith(provided: MockData.grayBlackBelt)
                case .kidsYellowWhiteBelt: cell.displayKidsBeltWith(provided: MockData.yellowWhiteBelt)
                case .kidsYellowBelt: cell.displayKidsBeltWith(provided: MockData.yellowBelt)
                case .kidsYellowBlackBelt: cell.displayKidsBeltWith(provided: MockData.yellowBlackBelt)
                case .kidsOrangeWhiteBelt: cell.displayKidsBeltWith(provided: MockData.orangeWhiteBelt)
                case .kidsOrangeBelt: cell.displayKidsBeltWith(provided: MockData.orangeBelt)
                case .kidsOrangeBlackBelt: cell.displayKidsBeltWith(provided: MockData.orangeBlackBelt)
                case .kidsGreenWhiteBelt: cell.displayKidsBeltWith(provided: MockData.greenWhiteBelt)
                case .kidsGreenBelt: cell.displayKidsBeltWith(provided: MockData.greenBelt)
                case .kidsGreenBlackBelt: cell.displayKidsBeltWith(provided: MockData.greenBlackBelt)
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
                
                case .adultWhiteBelt: cell.displayAdultBasicBeltWith(provided: MockData.whiteBelt)
                case .adultBlueBelt: cell.displayAdultBasicBeltWith(provided: MockData.blueBelt)
                case .adultPurpleBelt: cell.displayAdultBasicBeltWith(provided: MockData.purpleBelt)
                case .adultBrownBelt: cell.displayAdultBasicBeltWith(provided: MockData.brownBelt)
                
                default:
                    let nib = UINib(nibName: "AdultBlackBeltTemplate", bundle: nil)
                    self.tableView.register(nib, forCellReuseIdentifier: "adultBlackBeltTemplate")
                    
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "adultBlackBeltTemplate", for: indexPath) as? AdultBlackBeltTableViewCell {
                        
                        let myBlackBeltCell = myCell
                        
                        switch myBlackBeltCell {
                        case .adultBlackBelt: cell.displayAdultBlackBeltWith(provided: MockData.blackBelt)
                        case .adultRedBlackBelt: cell.displayAdultBlackBeltWith(provided: MockData.redBlackBelt)
                        case .adultRedWhiteBelt: cell.displayAdultBlackBeltWith(provided: MockData.redWhiteBelt)
                        case .adultRedBelt: cell.displayAdultBlackBeltWith(provided: MockData.redBelt)
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

