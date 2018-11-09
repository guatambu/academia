//
//  Belt.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/8/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Belt {
    
    // MARK: - Properties
    
    // UID
    let beltUID: UUID
    
    // general properties
    var dateCreated: Date
    var dateEdited: Date
    var name: InternationalStandardBJJBelts
    var active: Bool
    var elligibleForNextBelt: Bool
    var numberOfClassesToNextPromotion: Int
    
    // belt constructors
    var kidStripes: Int?
    var adultStripes: Int?
    var blackBeltDegrees: Int?
    var coralBeltDegrees: Int?    
    
//    // MARK: - SET Properties
//    
//    // UIColor specs
//    let silverColor: UIColor = UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
//    let goldColor: UIColor = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0.0, alpha: 1.0)
//    let kidsGraduationBarColor = UIColor.black
//    let adultGraduationBarColor = UIColor.black
//    let blackBeltUpGraduationBarColor = UIColor.red
//    let kidsWhiteCenterRibbonColor = UIColor.white
//    let kidsBlackCenterRibbonColor = UIColor.black
//    
//    // graduation bar specs
//    let kidsBeltGraduationBarWidth: CGFloat = 232.0
//    let adultGraduationBarWidth: CGFloat = 120.0
//    let coralBeltGraduationBarWidth: CGFloat = 132.0
//    
//    // belt UIView Constructor Elements
//    let beltView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return view
//    }()
//    
//    let beltGraduationBar: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let coralBar: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.red
//        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        return view
//    }()
//    
//    let kidsCenterRibbon:  UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        return view
//    }()
//    
//    let leftTeacherBar: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
//        return view
//    }()
//    let rightTeacherBar: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderColor = UIColor.darkGray.cgColor
//        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
//        return view
//    }()
//    
//    // Stripe Constructor Elements
//    let whiteStripe: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.darkGray.cgColor
//        view.backgroundColor = UIColor.white
//        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
//        return view
//    }()
//    let redStripe: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.red
//        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
//        return view
//    }()
//    let blackStripe: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.lightGray.cgColor
//        view.backgroundColor = UIColor.black
//        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
//        return view
//    }()
//    let blackBeltDegree: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.darkGray.cgColor
//        view.backgroundColor = UIColor.white
//        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
//        return view
//    }()
//    let coralBeltDegree: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.darkGray.cgColor
//        view.backgroundColor = UIColor.white
//        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
//        return view
//    }()
//    
//    // stripe holder: UIStackView
//    let stripesStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [])
//        // black belt = up to 6 blackBeltDegrees
//        // coral belt = 7 coralBeltDegrees
//        // red & white belt = 8 coralBeltDegrees
//        // red belt = 9 & 10 coralBeltDegrees
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .horizontal
//        stack.spacing = 4
//        stack.distribution = .fillEqually
//        return stack
//    }()
    
    
    // Memberwise Initializer
    init(beltUID: UUID,
         dateCreated: Date,
         dateEdited: Date,
         name: InternationalStandardBJJBelts,
         active: Bool,
         elligibleForNextBelt: Bool,
         numberOfClassesToNextPromotion: Int,
         kidStripes: Int?,
         adultStripes: Int?,
         blackBeltDegrees: Int?,
         coralBeltDegrees: Int?
        ) {
        
        self.beltUID = beltUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.active = active
        self.elligibleForNextBelt = elligibleForNextBelt
        self.numberOfClassesToNextPromotion = numberOfClassesToNextPromotion
        self.kidStripes = kidStripes
        self.adultStripes = adultStripes
        self.blackBeltDegrees = blackBeltDegrees
        self.coralBeltDegrees = coralBeltDegrees
    }
    
//    // Belt Visual Contstruction Method
//    func buildABelt(view: UIView, belt: InternationalStandardBJJBelts, kidsStripes: Int?, adultStripes: Int?, blackBeltDegrees: Int?) {
//        
////  //  can return the belt constructor specs via copy paste    //  //
//        
//        // ADD BELT CONSTRUCTOR ELEMENTS TO DESIRED UIView
//        addBeltConstructorsToView(view: view)
//        
//        // BELT ELEMENTS CONTSTRAINTS
//        addBeltConstraintsToView(view: view)
//        
//        // SET UP INDIVIDUAL BELTS
//        switch belt {
//            
//            // STANDARD KIDS BELTS
//            
//        case .kidsWhiteBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.white
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsWhiteBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 1
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            
//        case .kidsGreyWhiteBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.gray
//            kidsCenterRibbon.backgroundColor = UIColor.white
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsGreyWhiteBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            
//        case .kidsGreyBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.gray
//            kidsCenterRibbon.backgroundColor = UIColor.gray
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsGreyBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//
//        case .kidsGreyBlackBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.gray
//            kidsCenterRibbon.backgroundColor = UIColor.black
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsGreyBlackBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//
//        case .kidsYellowWhiteBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.yellow
//            kidsCenterRibbon.backgroundColor = UIColor.white
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsYellowWhiteBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//
//        case .kidsYellowBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.yellow
//            kidsCenterRibbon.backgroundColor = UIColor.yellow
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsYellowBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
// 
//        case .kidsYellowBlackBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.yellow
//            kidsCenterRibbon.backgroundColor = UIColor.black
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsYellowBlackBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//          
//        case .kidsOrangeWhiteBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.orange
//            kidsCenterRibbon.backgroundColor = UIColor.white
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsOrangeWhiteBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            
//        case .kidsOrangeBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.orange
//            kidsCenterRibbon.backgroundColor = UIColor.orange
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsOrangeBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            
//        case .kidsOrangeBlackBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.orange
//            kidsCenterRibbon.backgroundColor = UIColor.black
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsOrangeBlackBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            
//        case .kidsGreenWhiteBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.green
//            kidsCenterRibbon.backgroundColor = UIColor.white
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsGreenWhiteBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            
//        case .kidsGreenBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.orange
//            kidsCenterRibbon.backgroundColor = UIColor.orange
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsGreenBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            
//        case .kidsGreenBlackBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.orange
//            kidsCenterRibbon.backgroundColor = UIColor.black
//            // set graduation bar
//            setGraduationBarSpecs(belt: .kidsGreenBlackBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidsStripes, numberOfDegrees: nil)
//            
//            
//            // STANDARD ADULT BELTS
//            
//        case .adultWhiteBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.white
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultWhiteBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: adultStripes, numberOfDegrees: nil)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 1
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            
//        case .adultBlueBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.blue
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultBlueBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: adultStripes, numberOfDegrees: nil)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 0
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            
//        case .adultPurpleBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.purple
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultPurpleBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: adultStripes, numberOfDegrees: nil)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 0
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            
//        case .adultBrownBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.brown
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultBrownBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: adultStripes, numberOfDegrees: nil)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 0
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            
//        case .adultBlackBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.black
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultBlackBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: nil, numberOfDegrees: blackBeltDegrees)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 0
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            // add teacher bars
//            setTeacherBars(belt: .adultBlackBelt)
//            
//        case .adultRedBlackBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.black
//            coralBar.isHidden = false
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultRedBlackBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: nil, numberOfDegrees: blackBeltDegrees)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 0
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            // add teacher bars
//            setTeacherBars(belt: .adultRedBlackBelt)
//            
//        case .adultRedWhiteBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.white
//            coralBar.isHidden = false
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultRedWhiteBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: nil, numberOfDegrees: blackBeltDegrees)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 1
//            // add teacher bars
//            setTeacherBars(belt: .adultRedWhiteBelt)
//            
//        case .adultRedBelt:
//            // set belt color
//            beltView.backgroundColor = UIColor.red
//            coralBar.isHidden = true
//            // set graduation bar
//            setGraduationBarSpecs(belt: .adultRedBelt)
//            // set stripes
//            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: nil, numberOfDegrees: blackBeltDegrees)
//            // add border to white belt for visibility
//            view.layer.borderWidth = 1
//            // add teacher bars
//            setTeacherBars(belt: .adultRedBelt)
//            
//        default:
//            print("WHOOPS: looks like you picked an option that doesn't help us build a belt to visually present in the app")
//        }
//    }
//    
//    func stripeGenerator(beltGraduationBar: UIView, numberOfStripes: Int?, numberOfDegrees: Int?) {
//        
////  //  can return the stripe specs via copy paste  //  //
//        
//        switch numberOfStripes {
//        case nil:
//            break
//            
//        // add white stripe(s)
//        case 1:
//            stripesStackView.addArrangedSubview(whiteStripe)
//        case 2:
//            for _ in 1...2 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//        case 3:
//            for _ in 1...3 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//        case 4:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            
//        // with now all 4 white stripes, add red stripe(s)
//        case 5:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            stripesStackView.addArrangedSubview(redStripe)
//        case 6:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            for _ in 1...2 {
//                stripesStackView.addArrangedSubview(redStripe)
//            }
//        case 7:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            for _ in 1...3 {
//                stripesStackView.addArrangedSubview(redStripe)
//            }
//        case 8:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(redStripe)
//            }
//            
//        // with now all 4 white stripes, and all 4 red stripes, add black stripe(s)
//        case 9:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(redStripe)
//            }
//            stripesStackView.addArrangedSubview(blackStripe)
//        case 10:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(redStripe)
//            }
//            for _ in 1...2 {
//                stripesStackView.addArrangedSubview(blackStripe)
//            }
//        case 11:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(whiteStripe)
//            }
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(redStripe)
//            }
//            for _ in 1...3 {
//                stripesStackView.addArrangedSubview(blackStripe)
//            }
//        default:
//            print("OOOPS!!!  we don't have that many stripes on our belts senhor")
//        }
//        
//        // "degrees" are a different width than "stripes"
//        // 'black belt degrees' difrer in width to 'coral belt & up' degrees
//        switch numberOfDegrees {
//        case nil:
//            break
//        case 1:
//            stripesStackView.addArrangedSubview(blackBeltDegree)
//        case 2:
//            for _ in 1...2 {
//                stripesStackView.addArrangedSubview(blackBeltDegree)
//            }
//        case 3:
//            for _ in 1...3 {
//                stripesStackView.addArrangedSubview(blackBeltDegree)
//            }
//        case 4:
//            for _ in 1...4 {
//                stripesStackView.addArrangedSubview(blackBeltDegree)
//            }
//        case 5:
//            for _ in 1...5 {
//                stripesStackView.addArrangedSubview(blackBeltDegree)
//            }
//        case 6:
//            for _ in 1...6 {
//                stripesStackView.addArrangedSubview(blackBeltDegree)
//            }
//        case 7:
//            for _ in 1...7 {
//                stripesStackView.addArrangedSubview(coralBeltDegree)
//            }
//        case 8:
//            for _ in 1...8 {
//                stripesStackView.addArrangedSubview(coralBeltDegree)
//            }
//        case 9:
//            for _ in 1...9 {
//                stripesStackView.addArrangedSubview(coralBeltDegree)
//            }
//        case 10:
//            for _ in 1...10 {
//                stripesStackView.addArrangedSubview(coralBeltDegree)
//            }
//        default:
//            print("OOOPS!!!  we don't have that many degrees on our black belts senhor")
//        }
//        
//        // add stripe stackView constraints
//        NSLayoutConstraint.activate([
//            stripesStackView.topAnchor.constraint(equalTo: beltGraduationBar.topAnchor),
//            stripesStackView.bottomAnchor.constraint(equalTo: beltGraduationBar.bottomAnchor),
//            stripesStackView.leftAnchor.constraint(equalTo: beltGraduationBar.leftAnchor, constant: 8.0)
//            ])
//
//    }
//    
//    // adjust color and width of graduation bar for appropriate belts
//    func setGraduationBarSpecs(belt: InternationalStandardBJJBelts) {
//        
//        switch belt {
//        // standard kids belts
//        case .kidsWhiteBelt, .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
//            // set graduation bar
//            self.beltGraduationBar.backgroundColor = self.kidsGraduationBarColor
//            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.kidsBeltGraduationBarWidth).isActive = true
//            
//        // standard adult belts
//        case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
//            // set graduation bar
//            self.beltGraduationBar.backgroundColor = self.adultGraduationBarColor
//            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.adultGraduationBarWidth).isActive = true
//            
//        // standard black belt
//        case .adultBlackBelt:
//            self.beltGraduationBar.backgroundColor = self.blackBeltUpGraduationBarColor
//            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.adultGraduationBarWidth).isActive = true
//        // coral belts and up
//        case .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt:
//            self.beltGraduationBar.backgroundColor = self.blackBeltUpGraduationBarColor
//            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.coralBeltGraduationBarWidth).isActive = true
//            
//        default:
//            print("OOOPS! we don't recoginize this kind of belt")
//        }
//    }
//    
//    // sets up Teacher Bars on either side of belt graduation bar
//    func setTeacherBars(belt: InternationalStandardBJJBelts) {
//       
//        switch belt {
//        case .adultBlackBelt:
//            // show teacgher bars
//            rightTeacherBar.isHidden = false
//            leftTeacherBar.isHidden = false
//            // outline helps white bar visibility
//            rightTeacherBar.layer.borderWidth = 1
//            leftTeacherBar.layer.borderWidth = 1
//            // white teacher bars
//            rightTeacherBar.backgroundColor = UIColor.white
//            leftTeacherBar.backgroundColor = UIColor.white
//            
//        case .adultRedBlackBelt, . adultRedWhiteBelt:
//            // show teacgher bars
//            rightTeacherBar.isHidden = false
//            leftTeacherBar.isHidden = false
//            // no color visibility help needed
//            rightTeacherBar.layer.borderWidth = 0
//            leftTeacherBar.layer.borderWidth = 0
//            //silver color teacher bars
//            rightTeacherBar.backgroundColor = silverColor
//            leftTeacherBar.backgroundColor = silverColor
//            
//        case .adultRedBelt:
//            // show teacgher bars
//            rightTeacherBar.isHidden = false
//            leftTeacherBar.isHidden = false
//            // no color visibility help needed
//            rightTeacherBar.layer.borderWidth = 0
//            leftTeacherBar.layer.borderWidth = 0
//            //silver color teacher bars
//            rightTeacherBar.backgroundColor = goldColor
//            leftTeacherBar.backgroundColor = goldColor
//            
//        default:
//            print("some people use teacher bars on the other remaining belts, and we will add this if and when the practice becomes  widespread or is requested enough")
//        }
//    }
//    
//    // adds belt constructor elements to desired UIView
//    func addBeltConstructorsToView(view: UIView) {
//        
//        // add belt views to view
//        view.addSubview(beltView)
//        
//        // add kidsCenterRibbon
//        beltView.addSubview(kidsCenterRibbon)
//        
//        // add adult graduation bar to beltViewA
//        beltView.addSubview(beltGraduationBar)
//        
//        // add coral bar to beltViewA
//        beltView.addSubview(coralBar)
//        coralBar.isHidden = true
//        
//        // add teacher bars to either side of graduation bar
//        beltView.addSubview(leftTeacherBar)
//        beltView.addSubview(rightTeacherBar)
//        rightTeacherBar.isHidden = true
//        leftTeacherBar.isHidden = true
//    }
//    
//    // adds belt elements' constraints to desired UIView
//    func addBeltConstraintsToView(view: UIView) {
//    
//        // add belt constraints
//        beltView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        beltView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        beltView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        beltView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//    
//        // add kidsCenterRibbon constraints
//        kidsCenterRibbon.centerYAnchor.constraint(equalTo: beltView.centerYAnchor).isActive = true
//        kidsCenterRibbon.rightAnchor.constraint(equalTo: beltView.rightAnchor).isActive = true
//        kidsCenterRibbon.leftAnchor.constraint(equalTo: beltView.leftAnchor).isActive = true
//    
//        // add belt gradutaion bar constraints
//        beltGraduationBar.topAnchor.constraint(equalTo: beltView.topAnchor, constant: 0).isActive = true
//        beltGraduationBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor, constant: 0).isActive = true
//        beltGraduationBar.rightAnchor.constraint(equalTo: beltView.rightAnchor, constant: -40).isActive = true
//    
//        // add coralBar constraints
//        coralBar.topAnchor.constraint(equalTo: beltView.topAnchor, constant: 0).isActive = true
//        coralBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor, constant: 0).isActive = true
//        coralBar.leftAnchor.constraint(equalTo: beltView.leftAnchor).isActive = true
//    
//        // add left teacher bar constraints
//        leftTeacherBar.topAnchor.constraint(equalTo: beltView.topAnchor).isActive = true
//        leftTeacherBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor).isActive = true
//        leftTeacherBar.rightAnchor.constraint(equalTo: beltGraduationBar.leftAnchor).isActive = true
//        // add right teacher bar constraints
//        rightTeacherBar.topAnchor.constraint(equalTo: beltView.topAnchor).isActive = true
//        rightTeacherBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor).isActive = true
//        rightTeacherBar.leftAnchor.constraint(equalTo: beltGraduationBar.rightAnchor).isActive = true
//    }
}

extension Belt: Equatable {
    
    static func ==(lhs: Belt, rhs: Belt) -> Bool {
        if lhs.beltUID != rhs.beltUID { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.name != rhs.name { return false }
        if lhs.active != rhs.active { return false }
        if lhs.elligibleForNextBelt != rhs.elligibleForNextBelt { return false }
        if lhs.kidStripes != rhs.kidStripes { return false }
        if lhs.adultStripes != rhs.adultStripes { return false }
        if lhs.blackBeltDegrees != rhs.blackBeltDegrees { return false }
        if lhs.coralBeltDegrees != rhs.coralBeltDegrees { return false }
        
        return true
    }
}

