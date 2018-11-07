//
//  AdultBasicBeltTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultBasicBeltTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // belt constructor Views
    @IBOutlet weak var beltViewOutlet: UIView!
    @IBOutlet weak var blackBarViewOutlet: UIView!
    @IBOutlet weak var fourthWhiteStripeOutlet: UIView!
    @IBOutlet weak var thirdWhiteStripeOutlet: UIView!
    @IBOutlet weak var secondWhiteStripeOutlet: UIView!
    @IBOutlet weak var firstWhiteStripeOutlet: UIView!
    
    @IBOutlet weak var stripesStackViewOutlet: UIStackView!
    
    
    // Labels
    @IBOutlet weak var beltTimeOutlet: UILabel!
    @IBOutlet weak var fourthStripeTimeOutlet: UILabel!
    @IBOutlet weak var thirdStripeTimeOutlet: UILabel!
    @IBOutlet weak var secondStripeTimeOutlet: UILabel!
    @IBOutlet weak var firstStripeTimeOutlet: UILabel!
    
    // details arrow 
    @IBOutlet weak var redArrowImageOutlet: UIImageView!
    
    
    // MARK: - display Adult Basic Belt
    
    func displayAdultBasicBeltWith(provided adultBasicBelt: AdultBasicBelt) {
        if adultBasicBelt.active {
            // set adult belt color
            beltViewOutlet.backgroundColor = adultBasicBelt.belt
            
            // set graduation bar color
            blackBarViewOutlet.backgroundColor = adultBasicBelt.blackBar
            
            
            // display promotion stripes that are present
            
            // white stripes
            if adultBasicBelt.firstWhiteStripe {
                firstWhiteStripeOutlet.isHidden = false
            } else {
                firstWhiteStripeOutlet.isHidden = true
            }
            if adultBasicBelt.secondWhiteStripe {
                secondWhiteStripeOutlet.isHidden = false
            } else {
                secondWhiteStripeOutlet.isHidden = true
            }
            if adultBasicBelt.thirdWhiteStripe {
                thirdWhiteStripeOutlet.isHidden = false
            } else {
                thirdWhiteStripeOutlet.isHidden = true
            }
            if adultBasicBelt.fourthWhiteStripe {
                fourthWhiteStripeOutlet.isHidden = false
                adultBasicBelt.elligibleForNextBelt = true
            } else {
                fourthWhiteStripeOutlet.isHidden = true
            }
        } else {
            let errorMessage = "This is belt is not currently active and available for use in your belt system."
            print(errorMessage)
            return
        }
    }

    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

