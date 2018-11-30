//
//  BeltTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/16/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var belt: InternationalStandardBJJBelts?
    
    let beltBuilder = BeltBuilder()
    
    // belt holder UIView
    @IBOutlet weak var beltHolderView: UIView!
    // UILabels
    @IBOutlet weak var beltLabelOutlet: UILabel!
    @IBOutlet weak var ageRequirementLabelOutlet: UILabel!
    @IBOutlet weak var stripeALabelOutlet: UILabel!
    @IBOutlet weak var stripeBLabelOutlet: UILabel!
    @IBOutlet weak var stripeCLabelOutlet: UILabel!
    @IBOutlet weak var stripeDLabelOutlet: UILabel!
    @IBOutlet weak var stripeELabelOutlet: UILabel!
    @IBOutlet weak var stripeFLabelOutlet: UILabel!
    
    
    // MARK: - awakeFromNib()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let numberOfKidsWhiteBeltStripes = beltBuilder.kidsWhiteBeltStripes.last,
            let allOtherKidsBeltStripes = beltBuilder.allOtherKidsBeltStripes.last,
            let adultBasicBeltStripes = beltBuilder.adultBasicBeltStripes.last,
            let blackBeltDegrees = beltBuilder.blackBeltDegrees.last,
            let redBlackBeltDegrees = beltBuilder.redBlackBeltDegrees.last,
            let redWhiteBeltDegrees = beltBuilder.redWhiteBeltDegrees.last,
            let redBeltDegrees = beltBuilder.redBeltDegrees.last
            else { return }
        
        guard let belt = belt else { return }
        
        // set individual belt promotion specifications labels text
        setBeltPromotionGuidelines(belt: belt)
        
        // build the belt views
        switch belt {
            
        case .kidsWhiteBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: numberOfKidsWhiteBeltStripes)
            beltBuilder.kidsCenterRibbon.isHidden = true
            
        case .kidsGreyWhiteBelt, .kidsGreyBelt,
             .kidsGreyBlackBelt, .kidsYellowWhiteBelt,
             .kidsYellowBelt, .kidsYellowBlackBelt,
             .kidsOrangeWhiteBelt, .kidsOrangeBelt,
             .kidsOrangeBlackBelt, .kidsGreenWhiteBelt,
             .kidsGreenBelt, .kidsGreenBlackBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: allOtherKidsBeltStripes)
            
        case .adultWhiteBelt, .adultBlueBelt,
             .adultPurpleBelt, .adultBrownBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: adultBasicBeltStripes)
            
        case .adultBlackBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: blackBeltDegrees)
            
        case .adultRedBlackBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: redBlackBeltDegrees)
            
        case .adultRedWhiteBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: redWhiteBeltDegrees)
            
        case .adultRedBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: redBeltDegrees)
            
        default:
            print("that's no belt of ours")
        }
    }
    
    
    // MARK: - Helper Methods
    
    func setBeltPromotionGuidelines(belt: InternationalStandardBJJBelts) {
        
        switch belt {
        
        case .kidsWhiteBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.kidsWhiteBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.kidsWhiteBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "White Stripes: \(MockData.kidsWhiteBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "Red Stripes: \(MockData.kidsWhiteBelt.vStripe ?? "")"
            stripeCLabelOutlet.text = " "
            stripeDLabelOutlet.text = " "
            stripeELabelOutlet.text = " "
            stripeFLabelOutlet.text = " "
          
        // all kids gray belts have the same criteria, so any gray belt variant is representative and appropriate here
        case .kidsGreyWhiteBelt, .kidsGreyBelt,
             .kidsGreyBlackBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.grayWhiteBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.grayWhiteBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "White Stripes: \(MockData.grayWhiteBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "Red Stripes: \(MockData.grayWhiteBelt.vStripe ?? "")"
            stripeCLabelOutlet.text = "Black Stripes: \(MockData.grayWhiteBelt.vStripe ?? "")"
            stripeDLabelOutlet.text = " "
            stripeELabelOutlet.text = " "
            stripeFLabelOutlet.text = " "
           
        // all kids yellow belts have the same criteria, so any gray belt variant is representative and appropriate here
        case .kidsYellowWhiteBelt,
             .kidsYellowBelt, .kidsYellowBlackBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.yellowWhiteBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.yellowWhiteBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "White Stripes: \(MockData.yellowWhiteBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "Red Stripes: \(MockData.yellowWhiteBelt.vStripe ?? "")"
            stripeCLabelOutlet.text = "Black Stripes: \(MockData.yellowWhiteBelt.vStripe ?? "")"
            stripeDLabelOutlet.text = " "
            stripeELabelOutlet.text = " "
            stripeFLabelOutlet.text = " "
            
        // all kids orange belts have the same criteria, so any gray belt variant is representative and appropriate here
        case .kidsOrangeWhiteBelt, .kidsOrangeBelt,
             .kidsOrangeBlackBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.orangeBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.orangeBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "White Stripes: \(MockData.orangeBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "Red Stripes: \(MockData.orangeBelt.vStripe ?? "")"
            stripeCLabelOutlet.text = "Black Stripes: \(MockData.orangeBelt.vStripe ?? "")"
            stripeDLabelOutlet.text = " "
            stripeELabelOutlet.text = " "
            stripeFLabelOutlet.text = " "
        
        // all kids green belts have the same criteria, so any gray belt variant is representative and appropriate here
        case .kidsGreenWhiteBelt,
             .kidsGreenBelt, .kidsGreenBlackBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.greenBelt.beltTime ?? "") "
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.greenBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "White Stripes: \(MockData.greenBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "Red Stripes: \(MockData.greenBelt.vStripe ?? "")"
            stripeCLabelOutlet.text = "Black Stripes: \(MockData.greenBelt.vStripe ?? "")"
            stripeDLabelOutlet.text = " "
            stripeELabelOutlet.text = " "
            stripeFLabelOutlet.text = " "
            
        case .adultWhiteBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.whiteBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.whiteBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "1st Stripe \(MockData.whiteBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "3rd Stripe: \(MockData.whiteBelt.iiiStripe ?? "")"
            stripeCLabelOutlet.text = ""
            stripeDLabelOutlet.text = "2nd Stripe: \(MockData.whiteBelt.iiStripe ?? "")"
            stripeELabelOutlet.text = "4th Stripe: \(MockData.whiteBelt.ivStripe ?? "")"
            stripeFLabelOutlet.text = ""
            
        case .adultBlueBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.blueBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.blueBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "1st Stripe \(MockData.blueBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "3rd Stripe: \(MockData.blueBelt.iiiStripe ?? "")"
            stripeCLabelOutlet.text = ""
            stripeDLabelOutlet.text = "2nd Stripe: \(MockData.blueBelt.iiStripe ?? "")"
            stripeELabelOutlet.text = "4th Stripe: \(MockData.blueBelt.ivStripe ?? "")"
            stripeFLabelOutlet.text = ""
            
        case .adultPurpleBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.purpleBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.purpleBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "1st Stripe \(MockData.purpleBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "3rd Stripe: \(MockData.purpleBelt.iiiStripe ?? "")"
            stripeCLabelOutlet.text = ""
            stripeDLabelOutlet.text = "2nd Stripe: \(MockData.purpleBelt.iiStripe ?? "")"
            stripeELabelOutlet.text = "4th Stripe: \(MockData.purpleBelt.ivStripe ?? "")"
            stripeFLabelOutlet.text = ""
            
        case .adultBrownBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.brownBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.brownBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "1st Stripe \(MockData.brownBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "3rd Stripe: \(MockData.brownBelt.iiiStripe ?? "")"
            stripeCLabelOutlet.text = ""
            stripeDLabelOutlet.text = "2nd Stripe: \(MockData.brownBelt.iiStripe ?? "")"
            stripeELabelOutlet.text = "4th Stripe: \(MockData.brownBelt.ivStripe ?? "")"
            stripeFLabelOutlet.text = ""
           
        case .adultBlackBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.blackBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.blackBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "1st Degree \(MockData.blackBelt.iStripe ?? "")"
            stripeBLabelOutlet.text = "3rd Degree: \(MockData.blackBelt.iiiStripe ?? "")"
            stripeCLabelOutlet.text = "5th Degree: \(MockData.blackBelt.vStripe ?? "")"
            stripeDLabelOutlet.text = "2nd Degree: \(MockData.blackBelt.iiStripe ?? "")"
            stripeELabelOutlet.text = "4th Degree: \(MockData.blackBelt.ivStripe ?? "")"
            stripeFLabelOutlet.text = "6th Degree: \(MockData.blackBelt.viStripe ?? "")"
            
        case .adultRedBlackBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.redBlackBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.redBlackBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = ""
            stripeBLabelOutlet.text = ""
            stripeCLabelOutlet.text = ""
            stripeDLabelOutlet.text = ""
            stripeELabelOutlet.text = ""
            stripeFLabelOutlet.text = ""
            
        case .adultRedWhiteBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.redWhiteBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.redWhiteBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = ""
            stripeBLabelOutlet.text = ""
            stripeCLabelOutlet.text = ""
            stripeDLabelOutlet.text = ""
            stripeELabelOutlet.text = ""
            stripeFLabelOutlet.text = ""
            
        case .adultRedBelt:
            
            beltLabelOutlet.text = "Belt: \(MockData.redBelt.beltTime ?? "")"
            ageRequirementLabelOutlet.text = "Min. Age: \(MockData.redBelt.minAgeRequirement ?? "")"
            stripeALabelOutlet.text = "10th Degree \(MockData.redBelt.xStripe ?? "")"
            stripeBLabelOutlet.text = " "
            stripeCLabelOutlet.text = " "
            stripeDLabelOutlet.text = " "
            stripeELabelOutlet.text = " "
            stripeFLabelOutlet.text = " "
            
        default:
            print("those promotion specifications are unfamiliar")
        }
    }

}
