//
//  PaymentProgramInfoDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgramInfoDetailsViewController: UIViewController {

    // MARK: - Properties
    
    var paymentProgramName: String?
    var active: Bool?
    var lastChanged: String?
    var programDescription: String?
    var billingOptions: String = ""
    var billingType: String = ""
    var signatureType: String = ""
    
    var inEditingMode: Bool?
    var paymentProgramToEdit: PaymentProgram?
    
    let beltBuilder = BeltBuilder()

    // payment program info outlets
    @IBOutlet weak var paymentProgramNameLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    // program description textView
    @IBOutlet weak var programDescriptionTextView: UITextView!
    // billing details outlets
    @IBOutlet weak var billingOptionsLabelOutlet: UILabel!
    @IBOutlet weak var billingTypeLabelOutlet: UILabel!
    @IBOutlet weak var signatureTypeLabelOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        populateCompletedProfileInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //populateCompletedProfileInfo()
    }
    
    // TODO: decide whether to create a new review your location details VC or tweak current one to work when creating location button not needed
    
    // MARK: - Actions
    
    @IBAction func reviewAgreementTextButtonTapped(_ sender: DesignableButton) {
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toViewPaymentProgramAgreement") as! ViewPaymentProgramAgreementViewController
        // create the segue programmatically - PUSH
    self.navigationController?.pushViewController(destViewController, animated: true)

        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass the current payment program name and agreeemnt to destVC
        guard let paymentProgram = PaymentProgramModelController.shared.paymentPrograms.first else { return }
        
        destViewController.paymentProgramName = paymentProgram.programName
        destViewController.programAgreement = paymentProgram.paymentAgreement
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toPaymentProgramNameAndDescription") as! PaymentProgramNameAndDescriptionViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // set properties on destinationVC
        destViewController.inEditingMode = true
        destViewController.paymentProgramToEdit = PaymentProgramModelController.shared.paymentPrograms[0]
        // TODO: set destinationVC properties to display user to be edited
        // in destintaionVC unrwrap userToEdit? as either Owner, AdultStudent, or KidStudent and us this to display info, and be passed around for updating in each update function
        // also need to build in programmatic segues for saveTapped to exit editing mode and return to OwnerProfileDetailsVC
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "are you sure you want to delete your account?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete account", style: UIAlertAction.Style.destructive) { (alert) in
            
            LocationModelController.shared.delete(location: LocationModelController.shared.locations[0])
            
            // programmatically performing the segue
            
            // instantiate the relevant storyboard
            let mainView: UIStoryboard = UIStoryboard(name: "OwnerLocationWorkFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = mainView.instantiateViewController(withIdentifier: "toOwnerLocationsList") as! MyLocationsTableViewController
            // add to Navigation stack
            let destVCNavigation = UINavigationController(rootViewController: destViewController)
            // perform the segure - present viewController of choice
            self.navigationController?.present(destVCNavigation, animated: true, completion: nil)
            
            // perform segue to specified viewController removing all others from Navigation Stack
            //            self.navigationController?.popToViewController(destVCNavigation, animated: true)
            // why can't i 'pop' to this VC?  if not the way to go, then, is navigation stack clean?
            
            self.navigationController?.navigationBar.tintColor = self.beltBuilder.redBeltRed
            
            print("how many location we got now: \(LocationModelController.shared.locations.count)")
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
}


extension PaymentProgramInfoDetailsViewController {
    
    func populateCompletedProfileInfo() {
        
        guard let paymentProgram = PaymentProgramModelController.shared.paymentPrograms.first else { return }
        // name outlet
        paymentProgramNameLabelOutlet.text = paymentProgram.programName
        // active outlet
        if paymentProgram.active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        lastChangedLabelOutlet.text = "\(paymentProgram.dateEdited)"
        // payment program description
        programDescriptionTextView.text = paymentProgram.paymentDescription
        // billing details outlets
        for option in paymentProgram.billingOptions {
            billingOptions += option
        }
        // billing options
        for type in paymentProgram.billingType {
//            guard let option = option else {
//                print("no billing options present in payment program billing options PaymentProgramInfoDetailsViewController -> populateCompletedProfileInfo() - line 146")
//                return
//            }
            billingType += type
        }
        billingOptionsLabelOutlet.text = billingOptions
        // signature type
        for type in paymentProgram.signatureType {
            signatureType += type
        }
        signatureTypeLabelOutlet.text = signatureType
    }
}


// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and location profileVC
extension UIViewController {
    
    func returnToPaymentProgramInfo() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is PaymentProgramInfoDetailsViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}
