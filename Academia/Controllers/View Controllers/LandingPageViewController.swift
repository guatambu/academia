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
        
        var navIndex = 0
        for vc in self.navigationController?.viewControllers ?? [] {
            print("\(vc) at navStack index: \(navIndex)")
            navIndex += 1
        }
        
//        print("***** CoreData Persistence Check - begin - *****")
//        print("")
//        print("owners count: \(OwnerCDModelController.shared.owners.count)")
//        print("")
//
//        if !OwnerCDModelController.shared.owners.isEmpty {
//
//
//            for owner in OwnerCDModelController.shared.owners {
//
////                OwnerCDModelController.shared.remove(owner: owner)
//
//                print("owner.username = \(owner.username ?? "owner object present but has no first name :'{ ")")
//                print("owner.password = \(owner.password ?? "owner object present but has no first name :'{ ")")
//                print("")
//                print("owner.beltLevel = \(owner.belt?.beltLevel ?? "no belt level present")")
//                print("")
//                print("ownerCD isInstructor: \(owner.isInstructor)")
//                print("")
//
//            }
//
//            for adult in StudentAdultCDModelController.shared.studentAdults {
//
////                StudentAdultCDModelController.shared.remove(studentAdult: adult)
//
//                print("total objects in StudentAdultCDModelController.shared.studentAdults: \(StudentAdultCDModelController.shared.studentAdults.count)")
//                print("adult.username = \(adult.username ?? "owner object present but has no first name :'{ ")")
//                print("adult.password = \(adult.password ?? "owner object present but has no first name :'{ ")")
//                print("")
//                print("adult.beltLevel = \(adult.belt?.beltLevel ?? "no belt level present")")
//                print("")
//                print("adultCD isInstructor: \(adult.isInstructor)")
//                print("")
//
//            }
//
//            for kid in StudentKidCDModelController.shared.studentKids {
//
////                StudentKidCDModelController.shared.remove(studentKid: kid)
//
//                print("total objects in StudentKidCDModelController.shared.studentKids: \(StudentKidCDModelController.shared.studentKids.count)")
//                print("kid.username = \(kid.username ?? "owner object present but has no first name :'{ ")")
//                print("kid.password = \(kid.password ?? "owner object present but has no first name :'{ ")")
//                print("")
//                print("kid.beltLevel = \(kid.belt?.beltLevel ?? "no belt level present")")
//                print("")
//
//            }
//
//            if !LocationCDModelController.shared.locations.isEmpty {
//
//                for location in LocationCDModelController.shared.locations {
//
////                    LocationCDModelController.shared.remove(location: location)
//
//                    print("location.locationName = \(location.locationName ?? "location object present but has no location name :'{ ")")
//                    print("location.address.city = \(location.address?.city ?? "owner object present but has no first name :'{ ")")
//                    print("")
//
//                }
//            }else {
//                print("no locations in the source of truth")
//            }
//
//            if !PaymentProgramCDModelController.shared.paymentPrograms.isEmpty {
//
//                for paymentProgram in PaymentProgramCDModelController.shared.paymentPrograms {
//
////                    PaymentProgramCDModelController.shared.remove(paymentProgram: paymentProgram)
//
//                    print("paymentProgram.programName = \(paymentProgram.programName ?? "payment program object present but has no location name :'{ ")")
//                    print("paymentProgram.billingDates.count = \(paymentProgram.paymentBillingDate?.count ?? 3000)")
//                    print("")
//
//                }
//            }else {
//                print("no paymentPrograms in the source of truth")
//            }
//
//            if !GroupCDModelController.shared.groups.isEmpty {
//
//                for group in GroupCDModelController.shared.groups {
//
////                    GroupCDModelController.shared.remove(group: group)
//
//                    print("group.name = \(group.name ?? "no group name found")")
//                    print("")
//                    print("group.adultMembers = \(group.adultMembers?.count ?? 4000)")
//                    print("")
//                    print("group.active = \(group.active)")
//
//                }
//            }else {
//                print("no groups in the source of truth")
//            }
//
//            if !AulaCDModelController.shared.aulas.isEmpty {
//
//                for aula in AulaCDModelController.shared.aulas {
//
////                    AulaCDModelController.shared.remove(aula: aula)
//
//                    print("aula.aulaName = \(aula.aulaName ?? "no aulaName present")")
//                    print("")
//                    print("aula.timeCode = \(aula.timeCode)")
//                    print("")
//                    print("aula.daysOfTheWeek = \(aula.dayOfTheWeek ?? "whaaaaa???")")
//                    print("")
//                    print("aula.location.locationName: \(aula.location?.locationName ?? "")")
//                    print("")
//                }
//            } else {
//                print("no aulas in the source of truth")
//            }
//
//            print("")
//            print("***** CoreData Persistence Check - end - *****")
//
//        } else {
//            print("Nothing found in OwnerCDModelController.shared.owners... Persistence fail?")
//
//            print("")
//            print("***** CoreData Persistence Check - end - *****")
//        }
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
