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
    var dateCreated: Date
    var dateEdited: Date
    var name: InternationalStandardBJJBelts
    var active: Bool
    var elligibleForNextBelt: Bool
    
    
    // belt constructors
    var kidStripes: Int?
    var adultStripes: Int?
    var blackBeltDegrees: Int?
    var coralBeltDegrees: Int?
    
    // Labels
//    var beltTime: String?
//    var firstStripeTime: String?
//    var secondStripeTime: String?
//    var thirdStripeTime: String?
//    var fourthStripeTime: String?
    
    
    // Memberwise Initializer
    
    init(beltUID: UUID,
         dateCreated: Date,
         dateEdited: Date,
         name: InternationalStandardBJJBelts,
         active: Bool,
         elligibleForNextBelt: Bool,
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
        self.kidStripes = kidStripes
        self.adultStripes = adultStripes
        self.blackBeltDegrees = blackBeltDegrees
        self.coralBeltDegrees = coralBeltDegrees
    }
    
    // Belt Visual Contstruction Methods
    
    func buildABelt(view: UIView, belt: InternationalStandardBJJBelts, kidsStripes: Int?, adultStripes: Int?, blackBeltDegrees: Int?) {
        
        let beltView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
//            view.layer.borderWidth = 1
//            view.layer.borderColor = UIColor.darkGray.cgColor
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//            view.backgroundColor = UIColor.gray
            return view
        }()
        let beltGraduationBar: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            // kids belt
            //view.backgroundColor = UIColor.black
            //view.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // adult basic belt
            //        view.backgroundColor = UIColor.black
            //        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
            // black belt
            //        view.backgroundColor = UIColor.red
            //        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
            // coral and red belts
            //        view.backgroundColor = UIColor.red
            //        view.widthAnchor.constraint(equalToConstant: 132).isActive = true
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
            // white background
            //        view.backgroundColor = UIColor.white
            // black background
            view.backgroundColor = UIColor.black
            view.heightAnchor.constraint(equalToConstant: 10).isActive = true
            return view
        }()
        let leftTeacherBar: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            // white color
//            view.layer.borderWidth = 1
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            view.backgroundColor = UIColor.white
            
            // gold color
//            view.layer.borderWidth = 0
//            view.backgroundColor = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0.0, alpha: 1.0)
            
            //silver color
//            view.layer.borderWidth = 0
//            view.backgroundColor = UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
//            view.widthAnchor.constraint(equalToConstant: 16).isActive = true
            return view
        }()
        let rightTeacherBar: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.darkGray.cgColor
            
            // white color
//            view.layer.borderWidth = 1
//            view.layer.borderColor = UIColor.darkGray.cgColor
//            view.backgroundColor = UIColor.white
            
            // gold color
//            view.layer.borderWidth = 0
//            view.backgroundColor = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0.0, alpha: 1.0)
            
            //silver color
//            view.layer.borderWidth = 0
//            view.backgroundColor = UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
//            view.widthAnchor.constraint(equalToConstant: 16).isActive = true
            view.widthAnchor.constraint(equalToConstant: 16).isActive = true
            return view
        }()
        
        // add belt views to view
        view.addSubview(beltView)
        // add kidsCenterRibbon
        beltView.addSubview(kidsCenterRibbon)
        // add adult graduation bar to beltViewA
        beltView.addSubview(beltGraduationBar)
        // add coral bar to beltViewA
        beltView.addSubview(coralBar)
        
        // add teacher bars to either side of graduation bar
        beltView.addSubview(leftTeacherBar)
        beltView.addSubview(rightTeacherBar)
        
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
        
        
        
        switch belt {
            // standard kids belts
            // for each belt case, set belt color, set center ribbon, and number and color of stripes
        case .kidsWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.white
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            // add border to white belt for visibility
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.darkGray.cgColor
            
        case .kidsGreyWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.gray
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            
        case .kidsGreyBelt:
            // set belt color
            beltView.backgroundColor = UIColor.gray
            kidsCenterRibbon.backgroundColor = UIColor.gray
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)

        case .kidsGreyBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.gray
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)

        case .kidsYellowWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.yellow
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)

        case .kidsYellowBelt:
            // set belt color
            beltView.backgroundColor = UIColor.yellow
            kidsCenterRibbon.backgroundColor = UIColor.yellow
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
 
        case .kidsYellowBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.yellow
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
          
        case .kidsOrangeWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            
        case .kidsOrangeBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.orange
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            
        case .kidsOrangeBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            
        case .kidsGreenWhiteBelt:
            // set belt color
            beltView.backgroundColor = UIColor.green
            kidsCenterRibbon.backgroundColor = UIColor.white
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            
        case .kidsGreenBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.orange
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            
        case .kidsGreenBlackBelt:
            // set belt color
            beltView.backgroundColor = UIColor.orange
            kidsCenterRibbon.backgroundColor = UIColor.black
            // set graduation bar
            beltGraduationBar.backgroundColor = UIColor.black
            beltGraduationBar.widthAnchor.constraint(equalToConstant: 232).isActive = true
            // set stripes
            stripeGenerator(beltGraduationBar: beltGraduationBar, numberOfStripes: kidStripes, numberOfDegrees: nil)
            
            
//            // standard adult belts
//        case .adultWhiteBelt:
//        case .adultBlueBelt:
//        case .adultPurpleBelt:
//        case .adultBrownBelt:
//        case .adultBlackBelt:
//        case .adultRedBlackBelt:
//        case .adultRedWhiteBelt:
//        case .adultRedBelt:
        default:
            print("WHOOPS: looks like you picked an option that doesn't help us build a belt to visually present in the app")
        }
    }
    
    func stripeGenerator(beltGraduationBar: UIView, numberOfStripes: Int?, numberOfDegrees: Int?) {
        
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
        let blackBeltDegree: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.darkGray.cgColor
            view.backgroundColor = UIColor.white
            view.widthAnchor.constraint(equalToConstant: 12).isActive = true
            return view
        }()
        let coralBeltDegree: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.darkGray.cgColor
            view.backgroundColor = UIColor.white
            view.widthAnchor.constraint(equalToConstant: 8).isActive = true
            return view
        }()

        
        let stripesStackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [])
            
            // black belt
            //            let stack = UIStackView(arrangedSubviews: [blackBeltDegree1, blackBeltDegree2, blackBeltDegree3, blackBeltDegree4, blackBeltDegree5, blackBeltDegree6])
            
            // coral belt
            //            let stack = UIStackView(arrangedSubviews: [coralBeltDegree1, coralBeltDegree2, coralBeltDegree3, coralBeltDegree4, coralBeltDegree5, coralBeltDegree6, coralBeltDegree7, coralBeltDegree8])
            
            // red belt
            //            let stack = UIStackView(arrangedSubviews: [coralBeltDegree1, coralBeltDegree2, coralBeltDegree3, coralBeltDegree4, coralBeltDegree5, coralBeltDegree6, coralBeltDegree7, coralBeltDegree8, coralBeltDegree9, coralBeltDegree10])
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.spacing = 4
            stack.distribution = .fillEqually
            return stack
        }()
        
        switch numberOfStripes {
        case nil:
            break
            
        // add white stripe(s)
        case 1:
            stripesStackView.addArrangedSubview(whiteStripe)
        case 2:
            for _ in 1...2 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
        case 3:
            for _ in 1...3 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
        case 4:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            
        // with now all 4 white stripes, add red stripe(s)
        case 5:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            stripesStackView.addArrangedSubview(redStripe)
        case 6:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            for _ in 1...2 {
                stripesStackView.addArrangedSubview(redStripe)
            }
        case 7:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            for _ in 1...3 {
                stripesStackView.addArrangedSubview(redStripe)
            }
        case 8:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(redStripe)
            }
            
        // with now all 4 white stripes, and all 4 red stripes, add black stripe(s)
        case 9:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(redStripe)
            }
            stripesStackView.addArrangedSubview(blackStripe)
        case 10:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(redStripe)
            }
            for _ in 1...2 {
                stripesStackView.addArrangedSubview(blackStripe)
            }
        case 11:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(whiteStripe)
            }
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(redStripe)
            }
            for _ in 1...3 {
                stripesStackView.addArrangedSubview(blackStripe)
            }
        default:
            print("OOOPS!!!  we don't have that many stripes on our belts senhor")
        }
        
        switch numberOfDegrees {
        case nil:
            break
        case 1:
            stripesStackView.addArrangedSubview(blackBeltDegree)
        case 2:
            for _ in 1...2 {
                stripesStackView.addArrangedSubview(blackBeltDegree)
            }
        case 3:
            for _ in 1...3 {
                stripesStackView.addArrangedSubview(blackBeltDegree)
            }
        case 4:
            for _ in 1...4 {
                stripesStackView.addArrangedSubview(blackBeltDegree)
            }
        case 5:
            for _ in 1...5 {
                stripesStackView.addArrangedSubview(blackBeltDegree)
            }
        case 6:
            for _ in 1...6 {
                stripesStackView.addArrangedSubview(blackBeltDegree)
            }
        case 7:
            for _ in 1...7 {
                stripesStackView.addArrangedSubview(coralBeltDegree)
            }
        case 8:
            for _ in 1...8 {
                stripesStackView.addArrangedSubview(coralBeltDegree)
            }
        case 9:
            for _ in 1...9 {
                stripesStackView.addArrangedSubview(coralBeltDegree)
            }
        case 10:
            for _ in 1...10 {
                stripesStackView.addArrangedSubview(coralBeltDegree)
            }
        default:
            print("OOOPS!!!  we don't have that many degrees on our black belts senhor")
        }
        
        // add stripe stackView constraints
        NSLayoutConstraint.activate([
            stripesStackView.topAnchor.constraint(equalTo: beltGraduationBar.topAnchor),
            stripesStackView.bottomAnchor.constraint(equalTo: beltGraduationBar.bottomAnchor),
            stripesStackView.leftAnchor.constraint(equalTo: beltGraduationBar.leftAnchor, constant: 8.0)
            ])

    }
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

