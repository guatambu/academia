//
//  KidsBeltTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class KidsBeltTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // belt constructor Views
    @IBOutlet weak var beltViewOutlet: UIView!
    @IBOutlet weak var beltCenterRibbonViewOutlet: UIView!
    @IBOutlet weak var blackBarViewOutlet: UIView!
    @IBOutlet weak var firstWhiteStripeViewOutlet: UIView!
    @IBOutlet weak var secondWhiteStripeViewOutlet: UIView!
    @IBOutlet weak var thirdWhiteStripeViewOutlet: UIView!
    @IBOutlet weak var fourthWhiteStripeViewOutlet: UIView!
    @IBOutlet weak var firstRedStripeViewOutlet: UIView!
    @IBOutlet weak var secondRedStripeViewOutlet: UIView!
    @IBOutlet weak var thirdRedStripeViewOutlet: UIView!
    @IBOutlet weak var fourthRedStripeViewOutlet: UIView!
    @IBOutlet weak var firstBlackStripeViewOutlet: UIView!
    @IBOutlet weak var secondBlackStripeViewOutlet: UIView!
    @IBOutlet weak var thirdBlackStripeViewOutlet: UIView!
    
    // Labels
    @IBOutlet weak var beltTimeLabelOutlet: UILabel!
    @IBOutlet weak var labelFirstWhiteStripeOutlet: UILabel!
    @IBOutlet weak var labelSecondWhiteStripeOutlet: UILabel!
    @IBOutlet weak var labelThirdWhiteStripeOutlet: UILabel!
    @IBOutlet weak var labelFourthWhiteStripeOutlet: UILabel!
    @IBOutlet weak var labelFirstRedStripeOutlet: UILabel!
    @IBOutlet weak var labelSecondRedStripeOutlet: UILabel!
    @IBOutlet weak var labelThirdRedStripeOutlet: UILabel!
    @IBOutlet weak var labelFourthRedStripeOutlet: UILabel!
    @IBOutlet weak var labelFirstBlackStripeOutlet: UILabel!
    @IBOutlet weak var labelSecondBlackStripeOutlet: UILabel!
    @IBOutlet weak var labelThirdBlackStripeOutlet: UILabel!
    
    // details arrow
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    
    // MARK: - KidsBelt Display Function
    
    func displayKidsBeltWith(provided kidsBelt: KidsBelt) {
        if kidsBelt.active {
            // set kids belt color
            beltViewOutlet.backgroundColor = kidsBelt.belt
            
            
            // set center ribbon color if present
            if let beltCenterRibbonColor = kidsBelt.beltCenterRibbonView {
                beltCenterRibbonViewOutlet.backgroundColor = beltCenterRibbonColor
            }
            
            // set graduation bar color
            blackBarViewOutlet.backgroundColor = kidsBelt.blackBar
            
            
            // display promotion stripes that are present
            
            // white stripes
            if kidsBelt.firstWhiteStripe {
                firstWhiteStripeViewOutlet.isHidden = false
            } else {
                firstWhiteStripeViewOutlet.isHidden = true
            }
            if kidsBelt.secondWhiteStripe {
                secondWhiteStripeViewOutlet.isHidden = false
            } else {
                secondWhiteStripeViewOutlet.isHidden = true
            }
            if kidsBelt.thirdWhiteStripe {
                thirdWhiteStripeViewOutlet.isHidden = false
            } else {
                thirdWhiteStripeViewOutlet.isHidden = true
            }
            if kidsBelt.fourthWhiteStripe {
                fourthWhiteStripeViewOutlet.isHidden = false
            } else {
                fourthWhiteStripeViewOutlet.isHidden = true
            }
            
            // red stripes
            if kidsBelt.firstRedStripe {
                firstRedStripeViewOutlet.isHidden = false
            } else {
                firstRedStripeViewOutlet.isHidden = true
            }
            if kidsBelt.secondRedStripe {
                secondRedStripeViewOutlet.isHidden = false
            } else {
                secondRedStripeViewOutlet.isHidden = true
            }
            if kidsBelt.thirdRedStripe {
                thirdRedStripeViewOutlet.isHidden = false
            } else {
                thirdRedStripeViewOutlet.isHidden = true
            }
            if kidsBelt.fourthRedStripe {
                fourthRedStripeViewOutlet.isHidden = false
            } else {
                fourthRedStripeViewOutlet.isHidden = true
            }
            
            // black stripes
            if kidsBelt.firstBlackStripe {
                firstBlackStripeViewOutlet.isHidden = false
            } else {
                firstBlackStripeViewOutlet.isHidden = true
            }
            if kidsBelt.secondRedStripe {
                secondBlackStripeViewOutlet.isHidden = false
            } else {
                secondBlackStripeViewOutlet.isHidden = true
            }
            if kidsBelt.thirdBlackStripe {
                thirdBlackStripeViewOutlet.isHidden = false
                kidsBelt.elligibleForNextBelt = true
            } else {
                thirdBlackStripeViewOutlet.isHidden = true
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



