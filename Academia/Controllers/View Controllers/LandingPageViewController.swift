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
    
    @IBOutlet weak var letsGoButtonOutlet: DesignableButton!
    
    
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
        
        
        print("***** CoreData Persistence Check - begin - *****")
        print("")
        print("owners count: \(OwnerCDModelController.shared.owners.count)")
        print("")
        
        if !OwnerCDModelController.shared.owners.isEmpty {
            
            
            for owner in OwnerCDModelController.shared.owners {
                
                OwnerCDModelController.shared.remove(owner: owner)
                
                print("owner.username = \(owner.username ?? "owner object present but has no first name :'{ ")")
                print("owner.password = \(owner.password ?? "owner object present but has no first name :'{ ")")
                print("")
                print("owner.firstName = \(owner.firstName ?? "owner object present but has no first name :'{ ")")
                print("")
                print("owner.address.addressLine1 = \(owner.address?.addressLine1 ?? "owner address object present but has no addressLine1 :'{ ")")
                print("")
                print("owner.belt.beltLevel = \(owner.belt?.beltLevel ?? "owner belt object present but has no beltLevel :'{ ")")
                
                print("")
                print("***** CoreData Persistence Check - end - *****")
                
            }
            
        } else {
            print("Nothing found in OwnerCDModelController.shared.owners... Persistence fail?")
            
            print("")
            print("***** CoreData Persistence Check - end - *****")
        }
    }


    // MARK: - Actions
    
    @IBAction func letsGoButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
    
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toNewUserLogin") as! NewUserLoginViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    

}
