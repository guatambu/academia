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
        
        switch belt {
            
        case .kidsWhiteBelt:
            
            for view in beltBuilder.stripesStackView.arrangedSubviews {
                beltBuilder.stripesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            
            beltBuilder.buildABelt(view: beltHolderView, belt: belt, numberOfStripes: numberOfKidsWhiteBeltStripes)
            
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

}
