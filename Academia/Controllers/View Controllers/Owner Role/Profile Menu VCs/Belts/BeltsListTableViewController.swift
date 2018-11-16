//
//  BeltsListTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltsListTableViewController: UITableViewController {

    // MARK: - Properties
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var beltDisclaimerLabelOutlet: UILabel!
    @IBOutlet weak var beltDisclaimerViewOutlet: UIView!
    
    var beltSystem: InternationalStandardBJJBelts?
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 241.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        beltDisclaimerLabelOutlet.text = InternationalStandardBJJBelts.beltDisclaimer.rawValue
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = 120
        
        guard let beltSystem = beltSystem?.rawValue else { return }
        print(beltSystem)
        self.title = beltSystem
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let beltSystem = beltSystem else { return 0 }
        if beltSystem == .kidBelts {
            return beltBuilder.kidsBelts.count
        } else {
            return beltBuilder.adultBelts.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let beltSystem = beltSystem else { return UITableViewCell() }
        
        guard let numberOfKidsWhiteBeltStripes = beltBuilder.kidsWhiteBeltStripes.last,
              let allOtherKidsBeltStripes = beltBuilder.allOtherKidsBeltStripes.last,
              let adultBasicBeltStripes = beltBuilder.adultBasicBeltStripes.last,
              let blackBeltDegrees = beltBuilder.blackBeltDegrees.last,
              let redBlackBeltDegrees = beltBuilder.redBlackBeltDegrees.last,
              let redWhiteBeltDegrees = beltBuilder.redWhiteBeltDegrees.last,
              let redBeltDegrees = beltBuilder.redBeltDegrees.last
            else { return UITableViewCell() }
        
        if beltSystem == .kidBelts {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "beltListCell", for: indexPath) as? BeltTableViewCell {
                
                let myCell = beltBuilder.kidsBelts[indexPath.row]

                switch myCell {
                
                case .kidsWhiteBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsWhiteBelt, numberOfStripes: numberOfKidsWhiteBeltStripes)
                case .kidsGreyWhiteBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsGreyWhiteBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsGreyBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsGreyBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsGreyBlackBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsGreyBlackBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsYellowWhiteBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsYellowWhiteBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsYellowBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsYellowBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsYellowBlackBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsYellowBlackBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsOrangeWhiteBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsOrangeWhiteBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsOrangeBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsOrangeBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsOrangeBlackBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsOrangeBlackBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsGreenWhiteBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsGreenWhiteBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsGreenBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsGreenBelt, numberOfStripes: allOtherKidsBeltStripes)
                case .kidsGreenBlackBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .kidsGreyBlackBelt, numberOfStripes: allOtherKidsBeltStripes)
                default: print("that's not a currently active kids belt to display")
                }
                return cell
            }
            return UITableViewCell()
            
        } else if beltSystem == .adultBelts {
            
            // there must be a constraint issue significant enough in the programmatic belt builder to throw off the table view population
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "beltListCell", for: indexPath) as? BeltTableViewCell {
                
                let myCell = beltBuilder.adultBelts[indexPath.row]
                
                switch myCell {

                case .adultWhiteBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultWhiteBelt, numberOfStripes: adultBasicBeltStripes)
                case .adultBlueBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultBlueBelt, numberOfStripes: adultBasicBeltStripes)
                case .adultPurpleBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultPurpleBelt, numberOfStripes: adultBasicBeltStripes)
                case .adultBrownBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultBrownBelt, numberOfStripes: adultBasicBeltStripes)
                case .adultBlackBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultBlackBelt, numberOfStripes: blackBeltDegrees)
                case .adultRedBlackBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultRedBlackBelt, numberOfStripes: redBlackBeltDegrees)
                case .adultRedWhiteBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultRedWhiteBelt, numberOfStripes: redWhiteBeltDegrees)
                case .adultRedBelt:
                    beltBuilder.buildABelt(view: cell.beltHolderView, belt: .adultRedBelt, numberOfStripes: redBeltDegrees)
                default:
                    print("that's not a currently an active belt to display")

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

