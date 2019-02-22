//
//  LandingPageViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

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
