//
//  NameAndBeltViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 11/6/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class NameAndBeltViewController: UIViewController {
    
    // MARK: - Properties
    
    var isOwner: Bool?
    var isKid: Bool?
    var username: String?
    var password: String?
    var firstName = ""
    var lastName = ""
    var beltLevel: InternationalStandardBJJBelts = .adultWhiteBelt
    
    @IBOutlet weak var welcomeLabeOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var firstNameLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabelOutlet: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    let beltViewA: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let beltGraduationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // kids belt
//        view.backgroundColor = UIColor.black
//        view.widthAnchor.constraint(equalToConstant: 232).isActive = true
        // adult basic belt
//        view.backgroundColor = UIColor.black
//        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // black belt
//        view.backgroundColor = UIColor.red
//        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // coral and red belts
        view.backgroundColor = UIColor.red
        view.widthAnchor.constraint(equalToConstant: 132).isActive = true
        return view
    }()
    lazy var stripesStackView: UIStackView = {
        // kids
//        let stack = UIStackView(arrangedSubviews: [whiteStripe1, whiteStripe2, whiteStripe3, whiteStripe4, redStripe1, redStripe2, redStripe3, redStripe4, blackStripe1, blackStripe2, blackStripe3])
        
        // adult
//        let stack = UIStackView(arrangedSubviews: [whiteStripe1, whiteStripe2, whiteStripe3, whiteStripe4])
        
        // black belt
//        let stack = UIStackView(arrangedSubviews: [blackBeltDegree1, blackBeltDegree2, blackBeltDegree3, blackBeltDegree4, blackBeltDegree5, blackBeltDegree6])
        
        // coral belt
//        let stack = UIStackView(arrangedSubviews: [coralBeltDegree1, coralBeltDegree2, coralBeltDegree3, coralBeltDegree4, coralBeltDegree5, coralBeltDegree6, coralBeltDegree7, coralBeltDegree8])
        
        // red belt
        let stack = UIStackView(arrangedSubviews: [coralBeltDegree1, coralBeltDegree2, coralBeltDegree3, coralBeltDegree4, coralBeltDegree5, coralBeltDegree6, coralBeltDegree7, coralBeltDegree8, coralBeltDegree9, coralBeltDegree10])

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()
    let whiteStripe1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let whiteStripe2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let whiteStripe3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let whiteStripe4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let redStripe1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let redStripe2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let redStripe3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let redStripe4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let blackStripe1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = UIColor.black
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let blackStripe2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = UIColor.black
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let blackStripe3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = UIColor.black
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
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
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
//        view.backgroundColor = UIColor.white
        // gold color
//        view.backgroundColor = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0.0, alpha: 1.0)
        //silver color
        view.backgroundColor = UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let rightTeacherBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
//        view.backgroundColor = UIColor.white
        // gold color
//        view.backgroundColor = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0.0, alpha: 1.0)
        //silver color
        view.backgroundColor = UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    let blackBeltDegree1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return view
    }()
    let blackBeltDegree2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return view
    }()
    let blackBeltDegree3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return view
    }()
    let blackBeltDegree4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return view
    }()
    let blackBeltDegree5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return view
    }()
    let blackBeltDegree6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return view
    }()
    let coralBeltDegree1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree7: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree8: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree9: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    let coralBeltDegree10: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // successfully working... yay programtatic segues!
        print("viewWillAppear: isOwner = \(String(describing: isOwner))")
        print("viewWillAppear: isKid = \(String(describing: isKid))")
        print("viewWillAppear: username = \(String(describing: username))")
        print("viewWillAppear: password = \(String(describing: password))")
        
        generateBelt()
    }
    
    
    // MARK: - Actions
    @IBAction func setBeltLevelButtonTapped(_ sender: DesignableButton) {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
        
        // programmatically performing segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserAddress") as! AddressViewController
        
        guard let newFirstName = self.firstNameTextField.text,
            let newLastName = lastNameTextField.text,
            self.firstNameTextField.text != "",
            self.lastNameTextField.text != ""
            else {

            welcomeInstructionsLabelOutlet.textColor = UIColor.red
            return
        }
        
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        
        // pass data to destViewController
        destViewController.isOwner = isOwner
        destViewController.isKid = isKid
        destViewController.username = username
        destViewController.password = password
        destViewController.firstName = newFirstName
        destViewController.lastName = newLastName
        destViewController.beltLevel = beltLevel
        
        return
    }
    
    
    // MARK: - Helper Methods
    
    func generateBelt() {
        
        // add belt views to viewController
        view.addSubview(beltViewA)
        // add kidsCenterRibbon
//        beltViewA.addSubview(kidsCenterRibbon)
        // add adult graduation bar to beltViewA
        beltViewA.addSubview(beltGraduationBar)
        // add stripes stack view to adultGraduationBar
        beltGraduationBar.addSubview(stripesStackView)
        // add coral bar to beltViewA
        beltViewA.addSubview(coralBar)
        
        // add teacher bars to either side of graduation bar
        beltViewA.addSubview(leftTeacherBar)
        beltViewA.addSubview(rightTeacherBar)
        
        // add belt constraints
        beltViewA.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        beltViewA.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beltViewA.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 32).isActive = true
        
        // add kidsCenterRibbon constraints
//        kidsCenterRibbon.centerYAnchor.constraint(equalTo: beltViewA.centerYAnchor).isActive = true
//        kidsCenterRibbon.rightAnchor.constraint(equalTo: beltViewA.rightAnchor).isActive = true
//        kidsCenterRibbon.leftAnchor.constraint(equalTo: beltViewA.leftAnchor).isActive = true
        
        // add belt gradutaion bar constraints
        beltGraduationBar.topAnchor.constraint(equalTo: beltViewA.topAnchor, constant: 0).isActive = true
        beltGraduationBar.bottomAnchor.constraint(equalTo: beltViewA.bottomAnchor, constant: 0).isActive = true
        beltGraduationBar.rightAnchor.constraint(equalTo: beltViewA.rightAnchor, constant: -40).isActive = true
        
        // add coralBar constraints
        coralBar.topAnchor.constraint(equalTo: beltViewA.topAnchor, constant: 0).isActive = true
        coralBar.bottomAnchor.constraint(equalTo: beltViewA.bottomAnchor, constant: 0).isActive = true
        coralBar.leftAnchor.constraint(equalTo: beltViewA.leftAnchor).isActive = true
        
        // add stripe stackView constraints
        NSLayoutConstraint.activate([
            stripesStackView.topAnchor.constraint(equalTo: beltGraduationBar.topAnchor),
            stripesStackView.bottomAnchor.constraint(equalTo: beltGraduationBar.bottomAnchor),
            stripesStackView.leftAnchor.constraint(equalTo: beltGraduationBar.leftAnchor, constant: 8.0)
            ])
        
        // add left teacher bar constraints
        leftTeacherBar.topAnchor.constraint(equalTo: beltViewA.topAnchor).isActive = true
        leftTeacherBar.bottomAnchor.constraint(equalTo: beltViewA.bottomAnchor).isActive = true
        leftTeacherBar.rightAnchor.constraint(equalTo: beltGraduationBar.leftAnchor).isActive = true
        // add right teacher bar constraints
        rightTeacherBar.topAnchor.constraint(equalTo: beltViewA.topAnchor).isActive = true
        rightTeacherBar.bottomAnchor.constraint(equalTo: beltViewA.bottomAnchor).isActive = true
        rightTeacherBar.leftAnchor.constraint(equalTo: beltGraduationBar.rightAnchor).isActive = true
    }
    
    
}
