//
//  PaymentProgramBillingDetailsViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PaymentProgramBillingDetailsViewController: UIViewController, BillingTypeDelegate, BillingDateDelegate, SignatureTypeDelegate {
    

    // MARK: - Properties
    
    var paymentProgramName: String?
    var active: Bool?
    var programDescription: String?
    var billingOptionsString = ""
    var billingTypeString = ""
    var signatureTypeString = ""
    var billingTypes: [Billing.BillingType]?
    var billingDates: [Billing.BillingDate]?
    var signatureTypes: [Billing.BillingSignature]?
    
    var inEditingMode: Bool?
    var paymentProgramToEdit: PaymentProgram?
    
    let beltBuilder = BeltBuilder()
    let billing = Billing()
    
    let uncheckedBox32 = UIImage(named: "unchecked_checkbox_32.png")
    let uncheckedBox50 = UIImage(named: "unchecked_checkbox_50.png")
    let checkedBox32 = UIImage(named: "checked_tickbox_32.png")
    let checkedBox50 = UIImage(named: "checked_tickbox_50.png")
    
    // welcome message outlets
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    // next button outlet
    @IBOutlet weak var nextButtonOutlet: DesignableButton!
    // collection views
    @IBOutlet weak var billingTypeCollectionView: UICollectionView!
    @IBOutlet weak var billingDateCollectionView: UICollectionView!
    @IBOutlet weak var signatureTypeCollectionView: UICollectionView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up collection views dataSources and delegates
        billingTypeCollectionView.dataSource = self
        billingTypeCollectionView.delegate = self
        
        billingDateCollectionView.dataSource = self
        billingDateCollectionView.delegate = self
        
        signatureTypeCollectionView.dataSource = self
        signatureTypeCollectionView.delegate = self
        
        //populateCompletedProfileInfo()
        guard let paymentProgramName = paymentProgramName, let active = active, let programDescription = programDescription else {
            print("no paymentProgramName, active, or programDescription passed to: PaymentProgramBillingDetailsVC -> viewDidLoad() - line 71")
            return
        }
        
        print("program name: \(paymentProgramName) \nactive: \(active) \ndescription: \(programDescription)")
    
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        guard let billingTypes = billingTypes, let billingDates = billingDates, let signatureTypes = signatureTypes else {
            print("ERROR: nil values for billingTypes, billingDates, and signatureTypes in PaymentProgramBillingDetailsVC -> saveButtonTapped() - line 89")
            return
        }
        
        // Location update profile info
        if billingTypes.count != 0 && billingDates.count != 0 && signatureTypes.count != 0 {
            
            updatePaymentProgramInfo()
            
            self.returnToPaymentProgramInfo()
            
            print("update payment program name: \(PaymentProgramModelController.shared.paymentPrograms[0].programName)")
        }
        inEditingMode = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing the segue
        
        print("to agreement segue")
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerPaymentProgramWorkflow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toPaymentProgramAgreement") as! PaymentProgramAgreementViewController
        
        // run check to see if billing details are properly selected/in place
        guard let billingTypes = billingTypes, let billingDates = billingDates, let signatureTypes = signatureTypes else {
            print("ERROR: nil values for billingTypes, billingDates, and signatureTypes in PaymentProgramBillingDetailsVC -> nextButtonTapped() - line 117")
            return
        }
        guard billingTypes.count != 0 && billingDates.count != 0 && signatureTypes.count != 0 else {
            
            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.paymentProgramName = paymentProgramName
        destViewController.active = active
        destViewController.programDescription = programDescription
        destViewController.billingDates = billingDates
        destViewController.billingTypes = billingTypes
        destViewController.signatureTypes = signatureTypes
        
        destViewController.inEditingMode = inEditingMode
        destViewController.paymentProgramToEdit = paymentProgramToEdit
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        // ****  implement this across the other VCs in onboarding
        updatePaymentProgramInfo()
    }
}


// MARK: - Editing Mode for Individual User case specific setup
extension PaymentProgramBillingDetailsViewController {
    // Update Function for case where want to update user info without a segue
    func updatePaymentProgramInfo() {
        guard let paymentProgram = paymentProgramToEdit else { return }
        
        guard let billingTypes = billingTypes, let billingDates = billingDates, let signatureTypes = signatureTypes else {
            print("ERROR: nil values for billingTypes, billingDates, and signatureTypes in PaymentProgramBillingDetailsVC -> updatePaymentProgramInfo() - line 160")
            return
        }
        // payment program update info
        if billingTypes.count != 0 && billingDates.count != 0 && signatureTypes.count != 0 {
            PaymentProgramModelController.shared.update(paymentProgram: paymentProgram, programName: nil, active: nil, paymentDescription: nil, billingTypes: billingTypes, billingDates: billingDates, signatureTypes: signatureTypes, paymentAgreement: nil)
            print("update payment program billingTypes: \(PaymentProgramModelController.shared.paymentPrograms[0].billingTypes)")
        }
    }
    func enterEditingMode(inEditingMode: Bool?) {
        guard let inEditingMode = inEditingMode else { return }
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            paymentProgramEditingSetup()
        }
        print("PaymentProgramNameAndDescriptionVC -> inEditingMode: \(inEditingMode)")
    }
    // owner setup for editing mode
    func paymentProgramEditingSetup() {
        guard let paymentProgramToEdit = paymentProgramToEdit else {
            return
        }
        welcomeMessageLabelOutlet.text = "Program: \(paymentProgramToEdit.programName)"
        
        welcomeInstructionsLabelOutlet.textColor = beltBuilder.redBeltRed
        welcomeInstructionsLabelOutlet.text = "you are in payment program editing mode"
        
        billingTypes = paymentProgramToEdit.billingTypes
        billingDates = paymentProgramToEdit.billingDates
        signatureTypes = paymentProgramToEdit.signatureTypes
        
        billingTypeCollectionView.reloadData()
        billingDateCollectionView.reloadData()
        signatureTypeCollectionView.reloadData()
        
        print("the VC's billing details have been set to the existing billing details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - UICollectionView Protocol Conformance & Methods
extension PaymentProgramBillingDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 5 {
            return billing.types.count
        } else if collectionView.tag == 10 {
            return billing.dates.count
        } else if collectionView.tag == 15 {
            return billing.signatures.count
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 5 {
            let cell = billingTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionCell", for: indexPath) as! TypeCollectionViewCell
            // set the BillingTypeDelegate for the TypeCollectionViewCell
            cell.delegate = self
            
            cell.billingType = billing.types[indexPath.row]
            cell.selectedBillingTypes = paymentProgramToEdit?.billingTypes
            
            return cell
            
        } else if collectionView.tag == 10 {
            
            let cell = billingDateCollectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionCell", for: indexPath) as! DateCollectionViewCell
            // set the BillingDateDelegate for the DateCollectionViewCell
            cell.delegate = self
            
            cell.billingDate = billing.dates[indexPath.row]
            cell.selectedBillingDates = paymentProgramToEdit?.billingDates
            
            return cell
            
        } else if collectionView.tag == 15 {
            
            let cell = signatureTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "SignatureCollectionCell", for: indexPath) as! SignatureCollectionViewCell
            // set the SignatureTypeDelegate for the SignatureCollectionViewCell
            cell.delegate = self
            
            cell.signatureType = billing.signatures[indexPath.row]
            cell.selectedSignatureTypes = paymentProgramToEdit?.signatureTypes
            
            return cell
        
        }
        return UICollectionViewCell()
    }
    
}
