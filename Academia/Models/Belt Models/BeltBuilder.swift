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
    let kidsWhiteBeltStripes = 5
    let allOtherKidsBeltStripes = 11
    let adultBasicBeltStripes = 4
    let blackBeltDegrees = 6
    let redBlackBeltDegrees = 7
    let redWhiteBeltDegrees = 8
    let redBeltDegrees = 10
    
    
    // UIColor specs
    let silverColor: UIColor = UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    let goldColor: UIColor = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0.0, alpha: 1.0)
    let kidsGraduationBarColor = UIColor.black
    let adultGraduationBarColor = UIColor.black
    let blackBeltUpGraduationBarColor = UIColor.red
    let kidsWhiteCenterRibbonColor = UIColor.white
    let kidsBlackCenterRibbonColor = UIColor.black
    
    // graduation bar specs
    let kidsBeltGraduationBarWidth: CGFloat = 232.0
    let adultGraduationBarWidth: CGFloat = 120.0
    let coralBeltGraduationBarWidth: CGFloat = 132.0
    
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
        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
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
        // black belt = up to 6 blackBeltDegrees
        // coral belt = 7 coralBeltDegrees
        // red & white belt = 8 coralBeltDegrees
        // red belt = 9 & 10 coralBeltDegrees
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    // Belt Visual Contstruction Method
    func buildABelt(view: UIView, belt: InternationalStandardBJJBelts, numberOfStripes: Int) {
        
        // ADD BELT CONSTRUCTOR ELEMENTS TO DESIRED UIView
        addBeltConstructorsToView(view: view)
        
        // BELT ELEMENTS CONTSTRAINTS
        addBeltConstraintsToView(view: view)
        
        // SET UP INDIVIDUAL BELTS
        switch belt {
            
        // STANDARD KIDS BELTS
        case .kidsWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.white
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsWhiteBelt)
            // add border to white belt for visibility
            beltView.layer.borderWidth = 0.5
            beltView.layer.borderColor = UIColor.darkGray.cgColor
            
        case .kidsGreyWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.gray
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreyWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreyWhiteBelt)
            
        case .kidsGreyBelt:
            // set belt color
            beltView.backgroundColor = UIColor.gray
            kidsCenterRibbon.backgroundColor = UIColor.gray
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreyBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreyBelt)
            
        case .kidsGreyBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.gray
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreyBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreyBlackBelt)
            
        case .kidsYellowWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.yellow
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsYellowWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsYellowWhiteBelt)
            
        case .kidsYellowBelt:
            // set belt color
            beltView.backgroundColor = UIColor.yellow
            kidsCenterRibbon.backgroundColor = UIColor.yellow
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsYellowBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsYellowBelt)
            
        case .kidsYellowBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.yellow
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsYellowBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsYellowBlackBelt)
            
        case .kidsOrangeWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsOrangeWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsOrangeWhiteBelt)
            
        case .kidsOrangeBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.orange
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsOrangeBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsOrangeBelt)
            
        case .kidsOrangeBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsOrangeBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsOrangeBlackBelt)
            
        case .kidsGreenWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.green
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreenWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreenWhiteBelt)
            
        case .kidsGreenBelt:
            // set belt color
            beltView.backgroundColor = UIColor.green
            kidsCenterRibbon.backgroundColor = UIColor.green
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreenBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreenBelt)
            
        case .kidsGreenBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.green
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            setGraduationBarSpecs(belt: .kidsGreenBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .kidsGreenBlackBelt)
            
            
        // STANDARD ADULT BELTS
        case .adultWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.white
            // set graduation bar
            setGraduationBarSpecs(belt: .adultWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultWhiteBelt)
            // add border to white belt for visibility
            beltView.layer.borderWidth = 0.5
            beltView.layer.borderColor = UIColor.darkGray.cgColor
            
        case .adultBlueBelt:
            // check it out
            print(InternationalStandardBJJBelts.adultBlueBelt.rawValue)
            // set belt color
            beltView.backgroundColor = UIColor.blue
            // set graduation bar
            setGraduationBarSpecs(belt: .adultBlueBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultBlueBelt)
            
        case .adultPurpleBelt:
            // set belt color
            beltView.backgroundColor = UIColor.purple
            // set graduation bar
            setGraduationBarSpecs(belt: .adultPurpleBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultPurpleBelt)
            
        case .adultBrownBelt:
            // set belt color
            beltView.backgroundColor = UIColor.brown
            // set graduation bar
            setGraduationBarSpecs(belt: .adultBrownBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultBrownBelt)
            
        case .adultBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.black
            // set graduation bar
            setGraduationBarSpecs(belt: .adultBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultBlackBelt)
            // add teacher bars
            setTeacherBars(belt: .adultBlackBelt)
            
        case .adultRedBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.black
            coralBar.isHidden = false
            // set graduation bar
            setGraduationBarSpecs(belt: .adultRedBlackBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultRedBlackBelt)
            // add teacher bars
            setTeacherBars(belt: .adultRedBlackBelt)
            
        case .adultRedWhiteBelt:
            // check it out
            print("this is the set teachers bar function saying what up!!!")
            
            // set belt color
            beltView.backgroundColor = UIColor.white
            coralBar.isHidden = false
            // set graduation bar
            setGraduationBarSpecs(belt: .adultRedWhiteBelt)
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: numberOfStripes, belt: .adultRedWhiteBelt)
            // add border to white belt for visibility
            beltView.layer.borderWidth = 0.5
            beltView.layer.borderColor = UIColor.darkGray.cgColor
            // add teacher bars
            setTeacherBars(belt: .adultRedWhiteBelt)
            
        case .adultRedBelt:
            
            // check it out
            print(InternationalStandardBJJBelts.adultRedBelt.rawValue)
            print("this is the build a belt function!!! 1/6")
            // set belt color
            beltView.backgroundColor = UIColor.red
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
        
        print("this is the stripe generator function saying hello!!! 2/6")
        
        switch belt {
            
        case nil:
            
            break
        case .kidsWhiteBelt:
            if numberOfStripes <= 0 { break }
            if numberOfStripes > 5 { break }
            if stripesStackView.subviews.count > 5 { break }
            
            for i in 1...numberOfStripes {
                let whiteStripe: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = UIColor.darkGray.cgColor
                    view.backgroundColor = UIColor.white
                    view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                    return view
                }()
                let redStripe: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.backgroundColor = UIColor.red
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
                if numberOfStripes > 11 { break }
                if stripesStackView.subviews.count > 11 { break }
                
                for i in 1...numberOfStripes {
                    let whiteStripe: UIView = {
                        let view = UIView()
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.layer.borderWidth = 1
                        view.layer.borderColor = UIColor.darkGray.cgColor
                        view.backgroundColor = UIColor.white
                        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                        return view
                    }()
                    let redStripe: UIView = {
                        let view = UIView()
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.backgroundColor = UIColor.red
                        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                        return view
                    }()
                    let blackStripe: UIView = {
                        let view = UIView()
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.layer.borderWidth = 1
                        view.layer.borderColor = UIColor.lightGray.cgColor
                        view.backgroundColor = UIColor.black
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
            if numberOfStripes > 4 { break }
            if stripesStackView.subviews.count > 4 { break }
            
            for _ in 1...numberOfStripes {
                let whiteStripe: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = UIColor.darkGray.cgColor
                    view.backgroundColor = UIColor.white
                    view.widthAnchor.constraint(equalToConstant: 16).isActive = true
                    return view
                }()
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            
        // standard black belt
        case .adultBlackBelt:
            
            if numberOfStripes <= 0 { break }
            if numberOfStripes > 6 { break }
            if stripesStackView.subviews.count > 6 { break }
            
            for _ in 1...numberOfStripes {
                let blackBeltDegree: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = UIColor.darkGray.cgColor
                    view.backgroundColor = UIColor.white
                    view.widthAnchor.constraint(equalToConstant: 12).isActive = true
                    return view
                }()
                stripesStackView.addArrangedSubview(blackBeltDegree)
            }
            
        // coral belts and up
        case .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt:
            // check it out
            
            if numberOfStripes <= 0 { break }
            if numberOfStripes > 10 { break }
            if stripesStackView.subviews.count > 10 { break }
            
            for _ in 1...numberOfStripes {
                let coralBeltDegree: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.layer.borderWidth = 1
                    view.layer.borderColor = UIColor.darkGray.cgColor
                    view.backgroundColor = UIColor.white
                    view.widthAnchor.constraint(equalToConstant: 8).isActive = true
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
            
        // standard black belt
        case .adultBlackBelt:
            self.beltGraduationBar.backgroundColor = self.blackBeltUpGraduationBarColor
            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.adultGraduationBarWidth).isActive = true
        // coral belts and up
        case .adultRedBlackBelt, .adultRedWhiteBelt, .adultRedBelt:
            // check it out
            print("this is the set graduation bar function saying hey!!! 3/6")
            
            self.beltGraduationBar.backgroundColor = self.blackBeltUpGraduationBarColor
            self.beltGraduationBar.widthAnchor.constraint(equalToConstant: self.coralBeltGraduationBarWidth).isActive = true
            
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
            rightTeacherBar.backgroundColor = UIColor.white
            leftTeacherBar.backgroundColor = UIColor.white
            
        case .adultRedBlackBelt, . adultRedWhiteBelt:
            
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
            
            // check it out
            print("this is the set teachers bar function saying what up!!! 4/6")
            
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
        
        // check it out
        print("this is the set add belt constructors to view function saying what up!!! 5/6")
        
        
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
        
        // check it out
        print("this is the add belt constraints to view function saying what up!!! 6/6")
        
        
        // add belt constraints
        beltView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        beltView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beltView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        beltView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        /***  works up to here ***/
        print("belt constraints work!!! a/f")
        
        // add kidsCenterRibbon constraints
        kidsCenterRibbon.centerYAnchor.constraint(equalTo: beltView.centerYAnchor).isActive = true
        kidsCenterRibbon.rightAnchor.constraint(equalTo: beltView.rightAnchor).isActive = true
        kidsCenterRibbon.leftAnchor.constraint(equalTo: beltView.leftAnchor).isActive = true
        
        /*** works up to here ***/
        print("kid center ribbon constraints work!!! b/f")
        
        // add belt gradutaion bar constraints
        beltGraduationBar.topAnchor.constraint(equalTo: beltView.topAnchor, constant: 0).isActive = true
        beltGraduationBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor, constant: 0).isActive = true
        beltGraduationBar.rightAnchor.constraint(equalTo: beltView.rightAnchor, constant: -40).isActive = true
        
        /*** works up to here ***/
        print("belt graduation bar constraints work!!! c/f")
        
        // add coralBar constraints
        coralBar.topAnchor.constraint(equalTo: beltView.topAnchor, constant: 0).isActive = true
        coralBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor, constant: 0).isActive = true
        coralBar.leftAnchor.constraint(equalTo: beltView.leftAnchor).isActive = true
        
        /*** works up to here ***/
        print("coral bar constraints work!!! d/f")
        
        // add left teacher bar constraints
        leftTeacherBar.topAnchor.constraint(equalTo: beltView.topAnchor).isActive = true
        
        leftTeacherBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor).isActive = true
        
        leftTeacherBar.rightAnchor.constraint(equalTo: beltGraduationBar.leftAnchor).isActive = true
        // add right teacher bar constraints
        rightTeacherBar.topAnchor.constraint(equalTo: beltView.topAnchor).isActive = true
        
        rightTeacherBar.bottomAnchor.constraint(equalTo: beltView.bottomAnchor).isActive = true
        
        rightTeacherBar.leftAnchor.constraint(equalTo: beltGraduationBar.rightAnchor).isActive = true
        
        /*** works up to here ***/
        print("both teacher bar constraints work!!! e/f")
        
        // add stripe stackView constraints
        stripesStackView.bottomAnchor.constraint(equalTo: beltGraduationBar.bottomAnchor).isActive = true

        stripesStackView.leftAnchor.constraint(equalTo: beltGraduationBar.leftAnchor, constant: 8.0).isActive = true

        stripesStackView.topAnchor.constraint(equalTo: beltGraduationBar.topAnchor).isActive = true
        
        /*** works up to here ***/
        print("stripe stackView constraints work!!! f/f")
    }
    
    // return an array of Int eqivalent to stripes in a given belt
    func howManyStripes(belt: InternationalStandardBJJBelts) -> [Int] {
        
        var numberOfStripes: [Int] = []
        
        switch belt {
            
        case .kidsWhiteBelt:
            for i in 1...kidsWhiteBeltStripes {
                numberOfStripes.append(i)
            }
        case .kidsGreyWhiteBelt, .kidsGreyBelt, .kidsGreyBlackBelt, .kidsYellowWhiteBelt, .kidsYellowBelt, .kidsYellowBlackBelt, .kidsOrangeWhiteBelt, .kidsOrangeBelt, .kidsOrangeBlackBelt, .kidsGreenWhiteBelt, .kidsGreenBelt, .kidsGreenBlackBelt:
            for i in 1...allOtherKidsBeltStripes {
                numberOfStripes = []
                numberOfStripes.append(i)
            }
            
        case .adultWhiteBelt, .adultBlueBelt, .adultPurpleBelt, .adultBrownBelt:
            numberOfStripes = []
            for i in 1...adultBasicBeltStripes {
                numberOfStripes.append(i)
            }
            
        case .adultBlackBelt:
            numberOfStripes = []
            for i in 1...blackBeltDegrees {
                numberOfStripes.append(i)
            }
            
        case .adultRedBlackBelt:
            numberOfStripes = []
            numberOfStripes.append(7)
            
        case .adultRedWhiteBelt:
            numberOfStripes = []
            numberOfStripes.append(8)
        case .adultRedBelt:
            numberOfStripes = []
            for i in redWhiteBeltDegrees...blackBeltDegrees {
                numberOfStripes.append(i)
            }
        default:
            print("we don't recognize that type of belt... howManyStripes function in BeltBuilder.swift - line 682")
        }
        
        return numberOfStripes
    }
}




























