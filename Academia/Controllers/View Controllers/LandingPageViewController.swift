//
//  LandingPageViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class LandingPageViewController: UIViewController {
    
    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()
    
    
    // MARK: ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // need to get rid of that lil border line at the bottom of the navigation bar
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // following code allows tracking of howmany VCs are present in the current Navigaiton Stack in case have stray VCs out there at any point
        print("how many viewControllers we got at LandingPageVC: \(String(describing: self.navigationController?.viewControllers.count))")
        
        guard let navStack = self.navigationController?.viewControllers else {
            print("no VCs right now")
            return
        }
        var index = 0
        for vc in navStack {
            print("\(vc) at navStack index: \(index)")
            index += 1
        }
        
//        OwnerCDModelController.shared.remove(owner: OwnerCDModelController.shared.owners[0])
        
        print("***** CoreData Persistence Check - begin - *****")
        print("")
        if !OwnerCDModelController.shared.owners.isEmpty {
            for owner in OwnerCDModelController.shared.owners {
                print("")
                print("owner.firstName = \(owner.firstName ?? "owner object present but has no first name :'{ ")")
                print("")
                print("owner.address.addressLine1 = \(owner.address?.addressLine1 ?? "owner address object present but has no addressLine1 :'{ ")")
                print("")
                print("owner.belt.beltLevel = \(owner.belt?.beltLevel ?? "owner belt object present but has no beltLevel :'{ ")")
            }
        } else {
            print("Nothing found in OwnerCDModelController.shared.owners... Persistence fail?")
        }
        print("")
        print("***** CoreData Persistence Check - end - *****")
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
