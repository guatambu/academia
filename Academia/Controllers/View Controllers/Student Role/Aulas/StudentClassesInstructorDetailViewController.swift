//
//  StudentClassesInstructorDetailViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 4/19/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class StudentClassesInstructorDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var firstName: String?
    var lastName: String?
    var beltLevel: String?
    var numberOfStripes: Int16?
    var profilePicData: Data?
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var nameLabelOutlet: UILabel!
    // profile pic imageView
    @IBOutlet weak var profilePicImageView: UIImageView!
    // belt holder UIView
    @IBOutlet weak var beltHolderViewOutlet: UIView!
    

    // MARK: - ViewController Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Your Intructor"
        
        // populate activeOwner details to UI
        populateCompletedProfileInfo()

    }
}


// MARK: - set up the view
extension StudentClassesInstructorDetailViewController {
    
    func populateCompletedProfileInfo() {
        
        // populate UI elements in VC
        nameLabelOutlet.text = "\(firstName ?? "") \(lastName ?? "")"
        
        // profile pic imageView
        if let profilePicData = profilePicData {
            
            profilePicImageView.image = UIImage(data: profilePicData)
        }
        
        // belt holder UIView
        // convert numberOfStripes to Int from Int16 in CoreData
        let stripesInt = Int(numberOfStripes ?? 0)
        // get enum value from CoreData beltLevel String
        if let beltLevel = beltLevel {
            let beltLevelEnum = InternationalStandardBJJBelts(rawValue: beltLevel)
            // build the belt
            beltBuilder.buildABelt(view: beltHolderViewOutlet, belt: beltLevelEnum ?? .adultWhiteBelt, numberOfStripes: stripesInt)
        }
    }
}
