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
    var billingTypes: String = ""
    var billingDates: String = ""
    var signatureTypes: String = ""
    
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
    @IBOutlet weak var billingTypeLabelOutlet: UILabel!
    @IBOutlet weak var billingDateLabelOutlet: UILabel!
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
        
        let rightEditButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.editButtonTapped))
        self.navigationItem.rightBarButtonItem = rightEditButton
        
        //populateCompletedProfileInfo()
    }

    
    // MARK: - Actions
    
    @IBAction func reviewAgreementTextButtonTapped(_ sender: DesignableButton) {
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkflow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toViewAgreement") as! ViewAgreementViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)

        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass the current payment program name and agreeemnt to destVC
        guard let paymentProgram = PaymentProgramModelController.shared.paymentPrograms.first else { return }
        
        destViewController.paymentProgramName = paymentProgram.programName
        destViewController.agreement = paymentProgram.paymentAgreement
    }
    
    
    @IBAction func deletePaymentProgramButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Payment Program", message: "are you sure you want to delete this Payment Program?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive) { (alert) in
            
            PaymentProgramModelController.shared.delete(paymentProgram: PaymentProgramModelController.shared.paymentPrograms[0])
            
            // programmatically performing the segue
            guard let viewControllers = self.navigationController?.viewControllers else { return }
            
            for viewController in viewControllers {
                
                if viewController is OwnerPaymentProgramsTableViewController{
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
            
            print("how many payment programs we got now: \(PaymentProgramModelController.shared.paymentPrograms.count)")
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
    
    // MARK: - editButtonTapped()
    @objc func editButtonTapped() {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkflow", bundle: nil)
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
        
    }
    
}


extension PaymentProgramInfoDetailsViewController {
    
    func populateCompletedProfileInfo() {
        
        
        
        guard let paymentProgram = PaymentProgramModelController.shared.paymentPrograms.first else { return }
        // name outlet
        title = paymentProgram.programName
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
        
        billingTypes = ""
        billingDates = ""
        signatureTypes = ""
        
        // billingTypes
        for type in paymentProgram.billingTypes {
            
            if billingTypes == "" {
                
                billingTypes += type.rawValue
                
            } else {
                
                billingTypes += ", \(type.rawValue)"
            }
        }
        billingTypeLabelOutlet.text = billingTypes
        
        //billingDates
        for date in paymentProgram.billingDates {
            
            if billingDates == "" {
                
                billingDates += date.rawValue
                
            } else {
                
                billingDates += ", \(date.rawValue)"
            }
        }
        billingDateLabelOutlet.text = billingDates
        
        // signatureTypes
        for type in paymentProgram.signatureTypes {
            
            if signatureTypes == "" {
                
                signatureTypes += type.rawValue
                
            } else {
                
                signatureTypes += ", \(type.rawValue)"
            }
            
        }
        signatureTypeLabelOutlet.text = signatureTypes
    }
}


// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and payment program profileVC
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
