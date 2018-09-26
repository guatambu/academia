//
//  StudentProfileDetailTableViewController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentProfileDetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var isKid: Bool?  // this needs to be passed through from the initial student onboarding and the student's individual object
    
    
    @IBOutlet weak var studentProfileMenuCell: UITableViewCell!
    @IBOutlet weak var beltSystemsMenuCell: UITableViewCell!
    @IBOutlet weak var studentPaymentDetailsMenuCell: UITableViewCell!
    @IBOutlet weak var socialNetworksMenuCell: UITableViewCell!
    @IBOutlet weak var tutorialsMenuCell: UITableViewCell!
    @IBOutlet weak var privacyInfoMenuCell: UITableViewCell!
    @IBOutlet weak var aboutAcademiaMenuCell: UITableViewCell!
    @IBOutlet weak var aboutAcademiaServicesMenuCell: UITableViewCell!
    
    
    //MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Actions
    
    @IBAction func myProfileButtonTapped(_ sender: UIButton) {
        
        isKid = true
        guard let isKid = isKid else { return }
        
        if isKid {
            // instantiate the relevant storyboard
            let studentProfileFlowView: UIStoryboard = UIStoryboard(name: "StudentProfileFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = studentProfileFlowView.instantiateViewController(withIdentifier: "toKidStudentDetails") as! KidStudentDetailsTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
            
        } else {
            
            // instantiate the relevant storyboard
            let studentProfileFlowView: UIStoryboard = UIStoryboard(name: "StudentProfileFlow", bundle: nil)
            // instantiate the desired TableViewController as ViewController on relevant storyboard
            let destViewController = studentProfileFlowView.instantiateViewController(withIdentifier: "toAdultStudentDetails") as! AdultStudentDetailsTableViewController
            // create the segue programmatically
            self.navigationController?.pushViewController(destViewController, animated: true)
            // set the desired properties of the destinationVC's navgation Item
            let backButtonItem = UIBarButtonItem()
            backButtonItem.title = " "
            navigationItem.backBarButtonItem = backButtonItem
        }
    }
    
    @IBAction func beltSystemsButtonTapped(_ sender: UIButton) {
        // instantiate the relevant storyboard
        let ownerBeltSystemFlowView: UIStoryboard = UIStoryboard(name: "OwnerBeltSystemFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerBeltSystemFlowView.instantiateViewController(withIdentifier: "UITableViewController-TZb-1N-cMc") as! BeltSystemsTableViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    @IBAction func studentPaymentDetailsButtonTapped(_ sender: UIButton) {
        // instantiate the relevant storyboard
        let studentProfileFlowView: UIStoryboard = UIStoryboard(name: "StudentProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = studentProfileFlowView.instantiateViewController(withIdentifier: "toStudentPayment") as! StudentPaymentTableViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    @IBAction func socialNetworksButtonTapped(_ sender: UIButton) {
        // instantiate the relevant storyboard
        let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toSocialNetworks") as! ProfileMenuSocialNetworksViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    @IBAction func tutorialsButtonTapped(_ sender: UIButton) {
        // instantiate the relevant storyboard
        let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toOwnerPaymentInfo") as! OwnerPaymentInfoTableViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    @IBAction func privacyInfoButtonTapped(_ sender: UIButton) {
        // instantiate the relevant storyboard
        let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toPrivacyPolicy") as! PrivacyPolicyViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    @IBAction func aboutAcademiaButtonTapped(_ sender: UIButton) {
        // instantiate the relevant storyboard
        let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toAboutAcademia") as! AboutAcademiaViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    @IBAction func aboutAcademiaServicesButtonTapped(_ sender: UIButton) {
        // instantiate the relevant storyboard
        let ownerProfileFlowView: UIStoryboard = UIStoryboard(name: "OwnerProfileFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = ownerProfileFlowView.instantiateViewController(withIdentifier: "toAcademiaServices") as! AboutAcademiaServicesViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
}
