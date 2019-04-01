//
//  BeltBuilder.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/9/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class BeltBuilder {
    
    // MARK: - Properties
    
    // Belt arrays
    let adultBelts: [InternationalStandardBJJBelts] = [.adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt, .adultBlackBelt, .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt]
    
    let kidsBelts: [InternationalStandardBJJBelts] = [.kidsWhiteBelt, .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt]
    
    // belt stripe specifications
    let kidsWhiteBeltStripes = [0, 1, 2, 3, 4, 5]
    let allOtherKidsBeltStripes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    let adultBasicBeltStripes = [0, 1, 2, 3, 4]
    let blackBeltDegrees = [0, 1, 2, 3, 4, 5, 6]
    let redBlackBeltDegrees = [7]
    let redWhiteBeltDegrees = [8]
    let redBeltDegrees = [9, 10]
    
    
    // UIColor specs
    let silverColor: UIColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0)
    let goldColor: UIColor = UIColor(red: 252/255, green: 194/255, blue: 0/255, alpha: 1.0)
    let kidsGraduationBarColor = UIColor.black
    let adultGraduationBarColor = UIColor.black
    let blackBeltUpGraduationBarColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0) // same Red as redBeltRed
    let kidsWhiteCenterRibbonColor = UIColor.white
    let kidsBlackCenterRibbonColor = UIColor.black
    let grayBeltGray = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0)
    let yellowBeltYellow = UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1.0)
    let orangeBeltOrange = UIColor(red: 255/255, green: 147/255, blue: 0/255, alpha: 1.0)
    let greenBeltGreen = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1.0)
    let blueBeltBlue = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1.0)
    let purpleBeltPurple = UIColor(red: 148/255, green: 55/255, blue: 255/255, alpha: 1.0)
    let brownBeltBrown = UIColor(red: 148/255, green: 82/255, blue: 0/255, alpha: 1.0)
    let blackBeltBlack = UIColor.black
    let redBeltRed = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)
    
    // fonts
    // gil sans light using redBelRed
    let gillSansLightRed = [ NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0),
                            NSAttributedString.Key.font: UIFont(name: "GillSans-Light", size: 20)! ]
    // large black avenir font using blackBeltBlack
    let avenirFontBlackLarge = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                            NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 24)! ]
    // black avenir font using blackBeltBlack
    let avenirFontBlack = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                       NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 16)! ]
    // grey avenir font using gregyBeltGrey
    let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0),
                       NSAttributedString.Key.font: UIFont(name: "Avenir-LightOblique", size: 16)! ]
    
    // smaller grey avenir font using gregyBeltGrey
    let avenirFontSmall = [ NSAttributedString.Key.foregroundColor: UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0),
                       NSAttributedString.Key.font: UIFont(name: "Avenir-LightOblique", size: 16)! ]
    
    // error red avenit font using redBeltRed
    let errorAvenirFont = [ NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0),
                            NSAttributedString.Key.font: UIFont(name: "Avenir-LightOblique", size: 16)! ]
    
    // smaller error red avenit font using redBeltRed
    let errorAvenirFontSmall = [ NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0),
                            NSAttributedString.Key.font: UIFont(name: "Avenir-LightOblique", size: 16)! ]
    
    // graduation bar specs
    let kidsBeltGraduationBarWidth: CGFloat = 232.0
    let adultGraduationBarWidth: CGFloat = 120.0
    
    // belt UIView Constructor Elements
    let beltView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    let beltGraduationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coralBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
    let kidsCenterRibbon:  UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return view
    }()
    
    let leftTeacherBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let rightTeacherBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    
    // stripe holder: UIStackView
    let stripesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        stack.tag = 100
        return stack
    }()
    
    
    func buildABelt(view: UIView, belt: InternationalStandardBJJBelts, numberOfStripes: Int) {
    // Belt Visual Contstruction Method
        
        // ADD BELT CONSTRUCTOR ELEMENTS TO DESIRED UIView
        addBeltConstructorsToView(view: view)
        
        // BELT ELEMENTS CONTSTRAINTS
        addBeltConstraintsToView(view: view)
        
        // SET UP INDIVIDUAL BELTS
        switch belt {
            
        // STANDARD KIDS BELTS
        case .kidsWhiteBelt:
            // set belt color
            beltView.backgroundColor = kidsWhiteCenterRibbonColor
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsWhiteBelt)
            // add border to white belt for visibility
            beltView.layer.borderWidth = 0.5
            beltView.layer.borderColor = grayBeltGray.cgColor
            
        case .kidsGreyWhiteBelt:
            // set belt color
            beltView.backgroundColor = grayBeltGray
            kidsCenterRibbon.backgroundColor = kidsWhiteCenterRibbonColor
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreyWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreyWhiteBelt)
            
        case .kidsGreyBelt:
            // set belt color
            beltView.backgroundColor = grayBeltGray
            kidsCenterRibbon.backgroundColor = grayBeltGray
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreyBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreyBelt)
            
        case .kidsGreyBlackBelt:
            // set belt color
            beltView.backgroundColor = grayBeltGray
            kidsCenterRibbon.backgroundColor = blackBeltBlack
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreyBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreyBlackBelt)
            
        case .kidsYellowWhiteBelt:
            // set belt color
            beltView.backgroundColor = yellowBeltYellow
            kidsCenterRibbon.backgroundColor = kidsWhiteCenterRibbonColor
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsYellowWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsYellowWhiteBelt)
            
        case .kidsYellowBelt:
            // set belt color
            beltView.backgroundColor = yellowBeltYellow
            kidsCenterRibbon.backgroundColor = yellowBeltYellow
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsYellowBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsYellowBelt)
            
        case .kidsYellowBlackBelt:
            // set belt color
            beltView.backgroundColor = yellowBeltYellow
            kidsCenterRibbon.backgroundColor = blackBeltBlack
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsYellowBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsYellowBlackBelt)
            
        case .kidsOrangeWhiteBelt:
            // set belt color
            beltView.backgroundColor = orangeBeltOrange
            kidsCenterRibbon.backgroundColor = kidsWhiteCenterRibbonColor
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsOrangeWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsOrangeWhiteBelt)
            
        case .kidsOrangeBelt:
            // set belt color
            beltView.backgroundColor = orangeBeltOrange
            kidsCenterRibbon.backgroundColor = orangeBeltOrange
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsOrangeBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsOrangeBelt)
            
        case .kidsOrangeBlackBelt:
            // set belt color
            beltView.backgroundColor = orangeBeltOrange
            kidsCenterRibbon.backgroundColor = blackBeltBlack
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsOrangeBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsOrangeBlackBelt)
            
        case .kidsGreenWhiteBelt:
            // set belt color
            beltView.backgroundColor = greenBeltGreen
            kidsCenterRibbon.backgroundColor = kidsWhiteCenterRibbonColor
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreenWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreenWhiteBelt)
            
        case .kidsGreenBelt:
            // set belt color
            beltView.backgroundColor = greenBeltGreen
            kidsCenterRibbon.backgroundColor = greenBeltGreen
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreenBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreenBelt)
            
        case .kidsGreenBlackBelt:
            // set belt color
            beltView.backgroundColor = greenBeltGreen
            kidsCenterRibbon.backgroundColor = blackBeltBlack
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreenBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreenBlackBelt)
            
            
        // STANDARD ADULT BELTS
        case .adultWhiteBelt:
            // set belt color
            beltView.backgroundColor = kidsWhiteCenterRibbonColor
            // set graduation bar
            setGraduationBarSpecs(belt: .adultWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultWhiteBelt)
            // add border to white belt for visibility
            beltView.layer.borderWidth = 0.5
            beltView.layer.borderColor = grayBeltGray.cgColor
            
        case .adultBlueBelt:
            // set belt color
            beltView.backgroundColor = blueBeltBlue
            // set graduation bar
            setGraduationBarSpecs(belt: .adultBlueBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultBlueBelt)
            
        case .adultPurpleBelt:
            // set belt color
            beltView.backgroundColor = purpleBeltPurple
            // set graduation bar
            setGraduationBarSpecs(belt: .adultPurpleBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultPurpleBelt)
            
        case .adultBrownBelt:
            // set belt color
            beltView.backgroundColor = brownBeltBrown
            // set graduation bar
            setGraduationBarSpecs(belt: .adultBrownBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultBrownBelt)
            
        case .adultBlackBelt:
            // set belt color
            beltView.backgroundColor = blackBeltBlack
            // set graduation bar
            setGraduationBarSpecs(belt: .adultBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultBlackBelt)
            // add teacher bars
            setTeacherBars(belt: .adultBlackBelt)
            
        case .adultRedBlackBelt:
            // set belt color
            beltView.backgroundColor = blackBeltBlack
            coralBar.isHidden = false
            // set graduation bar
            setGraduationBarSpecs(belt: .adultRedBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultRedBlackBelt)
            // add teacher bars
            setTeacherBars(belt: .adultRedBlackBelt)
            
        case .adultRedWhiteBelt:
            // set belt color
            beltView.backgroundColor = kidsWhiteCenterRibbonColor
            coralBar.isHidden = false
            // set graduation bar
            setGraduationBarSpecs(belt: .adultRedWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultRedWhiteBelt)
            // add border to white belt for visibility
            beltView.layer.borderWidth = 0.5
            beltView.layer.borderColor = grayBeltGray.cgColor
            // add teacher bars
            setTeacherBars(belt: .adultRedWhiteBelt)
            
        case .adultRedBelt:
            // set belt color
            beltView.backgroundColor = redBeltRed
            coralBar.isHidden = true
            // set graduation bar
            setGraduationBarSpecs(belt: .adultRedBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultRedBelt)
            // add teacher bars
            setTeacherBars(belt: .adultRedBelt)
            
        default:
            print("WHOOPS: looks like you picked an option that doesn't help us build a belt to visually present in the app")
        }
    }
    
    func stripeGenerator(beltGraduationBar: UIView, numberOfStripes: Int, belt: InternationalStandardBJJBelts) {
        // standard kids belts
        
        switch belt {
            
        case nil:
            
            break
        case .kidsWhiteBelt:
            if numberOfStripes <= 0 { break }
            // prevent too many stripes added when in edit workflow
            if numberOfStripes != 0 {
                for _ in 1...numberOfStripes {
                    for stripeView in stripesStackView.arrangedSubviews {
                        stripesStackView.removeArrangedSubview(stripeView)
                    }
                }
            }
            // prevents too many stripes added upon initial creation
            if numberOfStripes > 5 { break }
            
            for i in 1...numberOfStripes {
                let whiteStripe: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = grayBeltGray.cgColor
                    view.backgroundColor = kidsWhiteCenterRibbonColor
                    view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                    return view
                }()
                let redStripe: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.backgroundColor = redBeltRed
                    view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                    return view
                }()
                if i < 5 {
                    stripesStackView.addArrangedSubview(whiteStripe)
                } else if i < 6 {
                    stripesStackView.addArrangedSubview(redStripe)
                }
            }
            case .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
            
                if numberOfStripes <= 0 { break }
                // prevent too many stripes added when in edit workflow
                if numberOfStripes != 0 {
                    for _ in 1...numberOfStripes {
                        for stripeView in stripesStackView.arrangedSubviews {
                            stripesStackView.removeArrangedSubview(stripeView)
                        }
                    }
                }
                // prevents too many stripes added upon initial creation
                if numberOfStripes > 11 { break }
                // these 2 lines prevent too many stripes added when in edit workflow
               
                
                for i in 1...numberOfStripes {
                    let whiteStripe: UIView = {
                        let view = UIView()
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.layer.borderWidth = 1
                        view.layer.borderColor = grayBeltGray.cgColor
                        view.backgroundColor = kidsWhiteCenterRibbonColor
                        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                        return view
                    }()
                    let redStripe: UIView = {
                        let view = UIView()
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.backgroundColor = redBeltRed
                        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                        return view
                    }()
                    let blackStripe: UIView = {
                        let view = UIView()
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.layer.borderWidth = 1
                        view.layer.borderColor = grayBeltGray.cgColor
                        view.backgroundColor = blackBeltBlack
                        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                        return view
                    }()
                    if i < 5 {
                        stripesStackView.addArrangedSubview(whiteStripe)
                    } else if i < 9 {
                        stripesStackView.addArrangedSubview(redStripe)
                    } else {
                        stripesStackView.addArrangedSubview(blackStripe)
                    }
            }
        // standard adult belts
        case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
            
            if numberOfStripes <= 0 { break }
            // prevent too many stripes added when in edit workflow
            if numberOfStripes != 0 {
                for _ in 1...numberOfStripes {
                    for stripeView in stripesStackView.arrangedSubviews {
                        stripesStackView.removeArrangedSubview(stripeView)
                    }
                }
            }
            // prevents too many stripes added upon initial creation
            if numberOfStripes > 4 { break }
            
            
            for _ in 1...numberOfStripes {
                let whiteStripe: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = grayBeltGray.cgColor
                    view.backgroundColor = kidsWhiteCenterRibbonColor
                    view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                    return view
                }()
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            
        // standard black belt
        case .adultBlackBelt:
            
            if numberOfStripes <= 0 { break }
            
            // prevent too many stripes added when in edit workflow
            if numberOfStripes != 0 {
                for _ in 1...numberOfStripes {
                    for stripeView in stripesStackView.arrangedSubviews {
                        stripesStackView.removeArrangedSubview(stripeView)
                    }
                }
            }
            // prevents too many stripes added upon initial creation
            if numberOfStripes > 6 { break }

            
            for _ in 1...numberOfStripes {
                let blackBeltDegree: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = grayBeltGray.cgColor
                    view.backgroundColor = kidsWhiteCenterRibbonColor
                    view.widthAnchor.constraint(equalToConstant: 12).isActive = true
                    return view
                }()
                stripesStackView.addArrangedSubview(blackBeltDegree)
            }
            
        // coral belts and up
        case .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt:
            // check it out
            
            if numberOfStripes <= 0 { break }
            
            // prevent too many stripes added when in edit workflow
            if numberOfStripes != 0 {
                for _ in 1...numberOfStripes {
                    for stripeView in stripesStackView.arrangedSubviews {
                        stripesStackView.removeArrangedSubview(stripeView)
                    }
                }
            }
            // prevents too many stripes added upon initial creation
            if numberOfStripes > 10 { break }
            
            
            for _ in 1...numberOfStripes {
                let coralBeltDegree: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = grayBeltGray.cgColor
                    view.backgroundColor = kidsWhiteCenterRibbonColor
                    view.widthAnchor.constraint(equalToConstant: 7).isActive = true
                    return view
                }()
                stripesStackView.addArrangedSubview(coralBeltDegree)
            }
        default:
            print("OOOPS!  we either don't recognize that belt or that is way too many stripes senhor!")
        }
    }
    
    // adjust color and width of graduation bar for appropriate belts
    func setGraduationBarSpecs(belt: InternationalStandardBJJBelts) {
        
        switch belt {
        // standard kids belts
        case .kidsWhiteBelt, .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
            // set graduation bar
            self.beltGraduationBar.backgroundColor = self.kidsGraduationBarColor
            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.kidsBeltGraduationBarWidth).isActive = true
            
        // standard adult belts
        case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
            // set graduation bar
            self.beltGraduationBar.backgroundColor = self.adultGraduationBarColor
            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.adultGraduationBarWidth).isActive = true
            
        // standard black belts
        case .adultBlackBelt, .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt:
            self.beltGraduationBar.backgroundColor = self.blackBeltUpGraduationBarColor
            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.adultGraduationBarWidth).isActive = true
        default:
            print("OOOPS! we don't recoginize this kind of belt")
        }
    }
    
    // sets up Teacher Bars on either side of belt graduation bar
    func setTeacherBars(belt: InternationalStandardBJJBelts) {
        
        switch belt {
        case .adultBlackBelt:
            // show teacgher bars
            rightTeacherBar.isHidden = false
            leftTeacherBar.isHidden = false
            // outline helps white bar visibility
            rightTeacherBar.layer.borderWidth = 1
            leftTeacherBar.layer.borderWidth = 1
            // white teacher bars
            rightTeacherBar.backgroundColor = kidsWhiteCenterRibbonColor
            leftTeacherBar.backgroundColor = kidsWhiteCenterRibbonColor
            
        case .adultRedBlackBelt, .adultRedWhiteBelt:
            
            // show teacgher bars
            rightTeacherBar.isHidden = false
            leftTeacherBar.isHidden = false
            // no color visibility help needed
            rightTeacherBar.layer.borderWidth = 0
            leftTeacherBar.layer.borderWidth = 0
            //silver color teacher bars
            rightTeacherBar.backgroundColor = silverColor
            leftTeacherBar.backgroundColor = silverColor
            
        case .adultRedBelt:
            
            // show teacher bars
            rightTeacherBar.isHidden = false
            leftTeacherBar.isHidden = false
            // no color visibility help needed
            rightTeacherBar.layer.borderWidth = 0
            leftTeacherBar.layer.borderWidth = 0
            //silver color teacher bars
            rightTeacherBar.backgroundColor = goldColor
            leftTeacherBar.backgroundColor = goldColor
            
        default:
            print("some people use teacher bars on the other remaining belts, and we will add this if and when the practice becomes  widespread or is requested enough")
        }
    }
    
    // adds belt constructor elements to desired UIView
    func addBeltConstructorsToView(view: UIView) {
    
        // add belt views to view
        view.addSubview(beltView)
        
        // add kidsCenterRibbon
        beltView.addSubview(kidsCenterRibbon)
        
        // add adult graduation bar to beltViewA
        beltView.addSubview(beltGraduationBar)
        
        // add stripes stackView to gradutaion bar
        beltGraduationBar.addSubview(stripesStackView)
        
        // add coral bar to beltViewA
        beltView.addSubview(coralBar)
        coralBar.isHidden = true
        
        // add teacher bars to either side of graduation bar
        beltView.addSubview(leftTeacherBar)
        beltView.addSubview(rightTeacherBar)
        rightTeacherBar.isHidden = true
        leftTeacherBar.isHidden = true
    }
    
    // adds belt elements' constraints to desired UIView
    func addBeltConstraintsToView(view: UIView) {
        
        // add belt constraints
        beltView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        beltView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beltView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        beltView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // add kidsCenterRibbon constraints
        kidsCenterRibbon.centerYAnchor.constraint(equalTo: beltView.centerYAnchor).isActive = true
        kidsCenterRibbon.rightAnchor.constraint(equalTo: beltView.rightAnchor).isActive = true
        kidsCenterRibbon.leftAnchor.constraint(equalTo: beltView.leftAnchor).isActive = true
        
        // add belt gradutaion bar constraints
        beltGraduationBar.topAnchor.constraint(equalTo: beltView.topAnchor, constant: 0).isActive = true
        beltGraduationBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor, constant: 0).isActive = true
        beltGraduationBar.rightAnchor.constraint(equalTo: beltView.rightAnchor, constant: -40).isActive = true
        
        // add coralBar constraints
        coralBar.topAnchor.constraint(equalTo: beltView.topAnchor, constant: 0).isActive = true
        coralBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor, constant: 0).isActive = true
        coralBar.leftAnchor.constraint(equalTo: beltView.leftAnchor).isActive = true
        
        // add left teacher bar constraints
        leftTeacherBar.topAnchor.constraint(equalTo: beltView.topAnchor).isActive = true
        
        leftTeacherBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor).isActive = true
        
        leftTeacherBar.rightAnchor.constraint(equalTo: beltGraduationBar.leftAnchor).isActive = true
        // add right teacher bar constraints
        rightTeacherBar.topAnchor.constraint(equalTo: beltView.topAnchor).isActive = true
        
        rightTeacherBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor).isActive = true
        
        rightTeacherBar.leftAnchor.constraint(equalTo: beltGraduationBar.rightAnchor).isActive = true
        
        // add stripe stackView constraints
        stripesStackView.bottomAnchor.constraint(equalTo: beltGraduationBar.bottomAnchor).isActive = true

        stripesStackView.leftAnchor.constraint(equalTo: beltGraduationBar.leftAnchor, constant: 8.0).isActive = true

        stripesStackView.topAnchor.constraint(equalTo: beltGraduationBar.topAnchor).isActive = true

    }
    
}





























