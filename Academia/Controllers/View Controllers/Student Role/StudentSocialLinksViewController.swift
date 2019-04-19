//
//  StudentSocialLinksViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 4/19/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class StudentSocialLinksViewController: UIViewController {
    
    // MARK: - Properties
    
    var socialLink1: String?
    var socialLink2: String?
    var socialLink3: String?
    
    var beltBuilder = BeltBuilder()
    
    @IBOutlet weak var socialLink1LabelOutlet: UILabel!
    @IBOutlet weak var socialLink2LabelOutlet: UILabel!
    @IBOutlet weak var socialLink3LabelOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // set up the view
        populateSocialLinksInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed

        // Do any additional setup after loading the view.
        title = "Follow Us!"
    }
}


// MARK: - function to set up the view
extension StudentSocialLinksViewController {
    
    func populateSocialLinksInfo()  {
        
        let locations = LocationCDModelController.shared.locations
        
        guard let firstSocialLinks = locations[0].socialLinks else {
            print("ERROR: nil value found for socialLinks value in StudentSocialLinksViewController.swift -> populateSocialLinksInfo() - line 56.")
            return
        }
        
        socialLink1LabelOutlet.text = "Instagram: \(firstSocialLinks.socialLink1 ?? "")"
        socialLink2LabelOutlet.text = "Facebook: \(firstSocialLinks.socialLink2 ?? "")"
        socialLink3LabelOutlet.text = "Twitter: \(firstSocialLinks.socialLink3 ?? "")"
    }
}


