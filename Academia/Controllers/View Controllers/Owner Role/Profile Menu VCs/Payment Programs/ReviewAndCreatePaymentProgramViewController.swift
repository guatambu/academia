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
        
        //populateCompletedProfileInfo()
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
        
        destViewController.programAgreement = programAgreement
    }
    
    @IBAction func createProgramButtonTapped(_ sender: DesignableButton) {
        createPaymentProgram()
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
        for date in paymentProgram.billingDates {
            if datesCounter == paymentProgram.billingDates.count - 1 {
                billingDatesString += "\(date)"
            } else {
                billingDatesString += "\(date), "
            }
            datesCounter += 1
        }
        billingTypesLabelOutlet.text = billingTypesString
        // billing options
        for type in paymentProgram.billingTypes {
           
            if typesCounter == paymentProgram.billingTypes.count - 1 {
                billingTypesString += "\(type)"
            } else {
                billingTypesString += "\(type), "
            }
            typesCounter += 1
        }
        billingDatesLabelOutlet.text = billingTypesString
        // signature type
        for type in paymentProgram.signatureTypes {
            if signatureCounter == paymentProgram.signatureTypes.count - 1 {
                signatureTypesString += "\(type)"
            } else {
                signatureTypesString += "\(type), "
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

