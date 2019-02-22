//
//  ReviewAndCreatePaymentProgramViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class ReviewAndCreatePaymentProgramViewController: UIViewController {

    // MARK: - Properties
    
    var paymentProgramName: String?
    var active: Bool?
    var programDescription: String?
    var programAgreement: String?
    var billingTypes: [Billing.BillingType]?
    var billingDates: [Billing.BillingDate]?
    var signatureTypes: [Billing.BillingSignature]?
    
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
    @IBOutlet weak var billingTypesLabelOutlet: UILabel!
    @IBOutlet weak var billingDatesLabelOutlet: UILabel!
    @IBOutlet weak var signatureTypesLabelOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        populateCompletedPaymentProgramInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let paymentProgramName = paymentProgramName, let active = active, let programDescription = programDescription else {
            print("no paymentProgramName, active, or programDescription passed to: PaymentProgramBillingDetailsVC -> viewDidLoad() - line 56")
            return
        }
        print("program name: \(paymentProgramName) \nactive: \(active) \ndescription: \(programDescription)")
        
        guard let billingTypes = billingTypes, let billingDates = billingDates, let signatureTypes = signatureTypes else {
            print("no billingTypes, billingDates, or signatureTypes passed to: PaymentProgramAgreementVC -> viewDidLoad() - line 62")
            return
        }
        print(billingTypes)
        print(billingDates)
        print(signatureTypes)
        
        guard let programAgreement = programAgreement else {
            print("no programAgreement passed to: ReviewAndCreatePaymentProgramVC -> viewDidLoad() - line 70")
            return
        }
        print("agreement: \(programAgreement)")
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func reviewAgreementTextButtonTapped(_ sender: DesignableButton) {
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkflow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toViewPaymentProgramAgreement") as! ViewPaymentProgramAgreementViewController
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
        
        destViewController.programAgreement = programAgreement
    }
    
    @IBAction func createProgramButtonTapped(_ sender: DesignableButton) {
        
        // create the new location in the LocationModelController source of truth
        createPaymentProgram()
        
        // programmatic segue back to the MyLocations TVC to view the current locations
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is OwnerPaymentProgramsTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}


extension ReviewAndCreatePaymentProgramViewController {
    
    func populateCompletedPaymentProgramInfo() {
        
        var datesCounter = 0
        var typesCounter = 0
        var signatureCounter = 0
        
        var billingTypesString = ""
        var billingDatesString = ""
        var signatureTypesString = ""
        
        guard let paymentProgramName = paymentProgramName,
            let active = active,
            let paymentProgramDescription = programDescription,
            let billingTypes = billingTypes,
            let billingDates = billingDates,
            let signatureTypes = signatureTypes
            else {
                print("there was a nil value in the payment program details passed to ReviewAndCreatePaymentProgramVC -> populateCompletedPaymentProgramInfo() - line 124")
                return
        }
        // name outlet
        title = paymentProgramName
        // active outlet
        if active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        lastChangedLabelOutlet.text = "\(Date())"
        // payment program description
        programDescriptionTextView.text = "\(paymentProgramDescription)"
        // billing details outlets
        for date in billingDates {
            if datesCounter == billingDates.count - 1 {
                billingDatesString += "\(date.rawValue)"
            } else {
                billingDatesString += "\(date.rawValue), "
            }
            datesCounter += 1
        }
        billingDatesLabelOutlet.text = billingDatesString
        // billing options
        for type in billingTypes {
           
            if typesCounter == billingTypes.count - 1 {
                billingTypesString += "\(type.rawValue)"
            } else {
                billingTypesString += "\(type.rawValue), "
            }
            typesCounter += 1
        }
        billingTypesLabelOutlet.text = billingTypesString
        // signature type
        for type in signatureTypes {
            if signatureCounter == signatureTypes.count - 1 {
                signatureTypesString += "\(type.rawValue)"
            } else {
                signatureTypesString += "\(type.rawValue), "
            }
            signatureCounter += 1
        }
        signatureTypesLabelOutlet.text = signatureTypesString
    }
}


extension ReviewAndCreatePaymentProgramViewController {
    
    func createPaymentProgram() {
 
        guard let paymentProgramName = paymentProgramName else { print("fail paymentProgramName"); return }
        guard let active = active else { print("fail active"); return }
        guard let programDescription = programDescription else { print("fail programDescription"); return }
        guard let programAgreement = programAgreement else { print("fail programAgreement"); return }
        guard let billingDates = billingDates else { print("fail billingOptions"); return }
        guard let billingTypes = billingTypes else { print("fail billingType"); return }
        guard let signatureTypes = signatureTypes else { print("fail signatureType"); return }
        
        PaymentProgramModelController.shared.addNew(active: active, programName: paymentProgramName, billingTypes: billingTypes, billingDates: billingDates, signatureTypes: signatureTypes, paymentDescription: programDescription, paymentAgreement: programAgreement)
        
        
    }
}

