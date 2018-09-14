//
//  AddClassTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/27/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddClassTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var saveEditBarButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var statusMessageOutlet: UILabel!
    @IBOutlet weak var classNameTextFieldOutlet: UITextField!
    @IBOutlet weak var activeSwitchOutlet: UISwitch!
    @IBOutlet weak var locationMessageOutlet: UILabel!
    @IBOutlet weak var leadInstructorMessageOutlet: UILabel!
    @IBOutlet weak var assistantsMessageOutlet: UILabel!
    @IBOutlet weak var dayMessageOutlet: UILabel!
    @IBOutlet weak var timeMessageOutlet: UILabel!
    
    
    
    var aula: Aula?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let avenirFont = [ NSAttributedStringKey.foregroundColor: UIColor.gray,
                           NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        classNameTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "class name", attributes: avenirFont)

    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func locationPickerWheelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func leadInstructorPickerWheelButtonTapped(_ sender: UIButton) {
    }
    @IBAction func assistantsPickerWheelButtonTapped(_ sender: UIButton) {
    }
    @IBAction func dayPickerWheelButtonTapped(_ sender: UIButton) {
    }
    @IBOutlet weak var timePickerWheelButtonTapped: UIButton!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
