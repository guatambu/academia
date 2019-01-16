//
//  ClassLocationAndTimeViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassLocationAndTimeViewController: UIViewController {

    // MARK: - Properties
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Kids", "Adults"]
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeMessageLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var classTimeLabelOutlet: UILabel!
    @IBOutlet weak var classTimeDetailsLabelOutlet: UILabel!
    @IBOutlet weak var classLocationLabelOutlet: UILabel!
    @IBOutlet weak var classLocationDetailsLabelOutlet: UILabel!
    @IBOutlet weak var classLocationTimePickerView: UIPickerView!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: DesignableButton) {
    }

}
