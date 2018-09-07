//
//  AdultBlackBeltTableViewCell.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/26/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AdultBlackBeltTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // belt constructor Views
    @IBOutlet weak var beltViewOutlet: UIView!
    @IBOutlet weak var leftTeacherBarViewOutlet: UIView!
    @IBOutlet weak var rightTeacherBarViewOutlet: UIView!
    @IBOutlet weak var redBarOutlet: UIView!
    @IBOutlet weak var coralBarOutlet: UIView!
    @IBOutlet weak var firstWhiteDegreeOutlet: UIView!
    @IBOutlet weak var secondWhiteDegreeOutlet: UIView!
    @IBOutlet weak var thirdWhiteDegreeOutlet: UIView!
    @IBOutlet weak var fourthWhiteDegreeOutlet: UIView!
    @IBOutlet weak var fifthWhiteDegreeOutlet: UIView!
    @IBOutlet weak var sixthWhiteDegreeOutlet: UIView!
    @IBOutlet weak var seventhWhiteDegreeOutlet: UIView!
    @IBOutlet weak var eigthWhiteDegreeOutlet: UIView!
    @IBOutlet weak var ninthWhiteDegreeOutlet: UIView!
    @IBOutlet weak var tenthWhiteDegreeOutlet: UIView!
    
    // Labels
    @IBOutlet weak var beltTimeLabelOutlet: UILabel!
    @IBOutlet weak var labelFirstDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelSecondDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelThirdDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelFourthDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelFifthDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelSixthDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelSeventhDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelEigthDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelNinthDegreeTimeOutlet: UILabel!
    @IBOutlet weak var labelTenthDegreeTimeOutlet: UILabel!
    
    // details arrow
    @IBOutlet weak var rightRedArrowImageViewOutlet: UIImageView!
    
    
    // MARK: - display Adult Black Belt
    
    func displayAdultBlackBeltWith(provided adultBlackBelt: AdultBlackBelt) {
        if adultBlackBelt.active {
            // set adult belt color
            beltViewOutlet.backgroundColor = adultBlackBelt.belt
            
            // set graduation bar color
            redBarOutlet.backgroundColor = adultBlackBelt.redBar
            
            // set the left and right Teacher Bars
            rightTeacherBarViewOutlet.backgroundColor = adultBlackBelt.rightTeacherBar
            leftTeacherBarViewOutlet.backgroundColor = adultBlackBelt.leftTeacherBar
            
            // set the coral Bar if present
            if let coralBarColor = adultBlackBelt.coralBar {
                coralBarOutlet.isHidden = false
                coralBarOutlet.backgroundColor = coralBarColor
            }
            
            // display promotion degrees that are present
            
            // white stripes
            if adultBlackBelt.firstWhiteDegree {
                firstWhiteDegreeOutlet.isHidden = false
            } else {
                firstWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.secondWhiteDegree {
                secondWhiteDegreeOutlet.isHidden = false
            } else {
                secondWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.thirdWhiteDegree {
                thirdWhiteDegreeOutlet.isHidden = false
            } else {
                thirdWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.fourthWhiteDegree {
                fourthWhiteDegreeOutlet.isHidden = false
            } else {
                fourthWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.fifthWhiteDegree {
                fifthWhiteDegreeOutlet.isHidden = false
            } else {
                fourthWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.sixthWhiteDegree {
                sixthWhiteDegreeOutlet.isHidden = false
                adultBlackBelt.elligibleForNextBelt = true
            } else {
                sixthWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.seventhWhiteDegree {
                seventhWhiteDegreeOutlet.isHidden = false
                adultBlackBelt.elligibleForNextBelt = false
            } else {
                seventhWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.eigthWhiteDegree {
                eigthWhiteDegreeOutlet.isHidden = false
                adultBlackBelt.elligibleForNextBelt = true
            } else {
                fourthWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.ninthWhiteDegree {
                ninthWhiteDegreeOutlet.isHidden = false
                adultBlackBelt.elligibleForNextBelt = false
            } else {
                ninthWhiteDegreeOutlet.isHidden = true
            }
            if adultBlackBelt.tenthWhiteDegree {
                tenthWhiteDegreeOutlet.isHidden = false
                adultBlackBelt.elligibleForNextBelt = true
            } else {
                tenthWhiteDegreeOutlet.isHidden = true
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


