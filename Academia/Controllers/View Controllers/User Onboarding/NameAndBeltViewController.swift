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
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let beltGraduationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        return view
    }()
    
    lazy var stripesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [whiteStripe1, whiteStripe2, whiteStripe3, whiteStripe4])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
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
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // successfully working... yay programtatic segues!
        print("viewWillAppear: isOwner = \(String(describing: isOwner))")
        print("viewWillAppear: isKid = \(String(describing: isKid))")
        print("viewWillAppear: username = \(String(describing: username))")
        print("viewWillAppear: password = \(String(describing: password))")
        
        view.addSubview(beltViewA)
        beltViewA.addSubview(beltGraduationBar)
        beltGraduationBar.addSubview(stripesStackView)
    
        beltViewA.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        beltViewA.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        beltViewA.heightAnchor.constraint(equalToConstant: 40).isActive = true
        beltViewA.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 32).isActive = true
        
        beltGraduationBar.topAnchor.constraint(equalTo: beltViewA.topAnchor, constant: 0).isActive = true
        beltGraduationBar.bottomAnchor.constraint(equalTo: beltViewA.bottomAnchor, constant: 0).isActive = true
        beltGraduationBar.widthAnchor.constraint(equalToConstant: 120).isActive = true
        beltGraduationBar.rightAnchor.constraint(equalTo: beltViewA.rightAnchor, constant: -40).isActive = true
        
        NSLayoutConstraint.activate([
            stripesStackView.topAnchor.constraint(equalTo: beltGraduationBar.topAnchor),
            stripesStackView.bottomAnchor.constraint(equalTo: beltGraduationBar.bottomAnchor),
            stripesStackView.leftAnchor.constraint(equalTo: beltGraduationBar.leftAnchor, constant: 16.0)
            ])
    
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
}
