//
//  StudentClassDetailViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.


import UIKit

class StudentClassDetailTableViewController: UITableViewController {

    // MARK: - Properties
    
    var aula: Aula?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Owners", "Instructors"]
    
    let beltBuilder = BeltBuilder()
    let classTimeComponents = ClassTimeComponents()
    
    // outlets
    @IBOutlet weak var classNameLabelOutlet: UILabel!
    @IBOutlet weak var daysOfTheWeekLabelOutlet: UILabel!
    @IBOutlet weak var timeLabelOutlet: UILabel!
    @IBOutlet weak var locationLabelOutlet: UILabel!
    @IBOutlet weak var locationNameLabelOutlet: UILabel!
    @IBOutlet weak var classDescriptionLabelOutlet: UILabel!
    @IBOutlet weak var classDescriptionTextView: UITextView!
    @IBOutlet weak var instructorAdvisoryLabelOutlet: UILabel!
    
    // CoreData properties
    var aulaCD: AulaCD?
    var dayOfTheWeek: String?
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedAulaInfo()
            
        instructorAdvisoryLabelOutlet.isHidden = true
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Current Class Schedule"
    }
    
    
    // MARK: - Actions
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionHeaderLabels.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        sectionHeaderView.backgroundColor = UIColor.white
        
        let avenirFont16 = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        let label = UILabel()
        label.attributedText = NSAttributedString(string: sectionHeaderLabels[section], attributes: avenirFont16)
        label.frame = CGRect(x: 16, y: 0, width: 80, height: 40)
        
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // CoreData version
        guard let aulaCD = aulaCD else {
            print("ERROR: nil value for aulaCD property in StudentClassDetailTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 104")
            return 0
        }
        
        guard let instructorsCD = aulaCD.adultStudentInstructorsAula, let ownerInstructorsCD = aulaCD.ownerInstructorAula else {
            
            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in StudentClassDetailTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 110")
            return 0
        }
        
        if section == 0 {
            
            return ownerInstructorsCD.count
            
        } else if section == 1 {
            
            return instructorsCD.count
            
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CoreData version
        guard let aulaCD = aulaCD else {
            
            print("ERROR: nil value for aulaCD property in StudentClassDetailTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 132")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            guard let ownerInstructorsCD = aulaCD.ownerInstructorAula else {
                
                print("ERROR: nil value for aula.ownerInstructor array in StudentClassDetailTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 141")
                return UITableViewCell()
            }
            
            if ownerInstructorsCD.count != 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
                
                cell.ownerInstructorCD = ownerInstructorsCD.object(at: indexPath.row) as? OwnerCD
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
                
                return cell
            }
            
            
        } else {
            
            guard let instructorsCD = aulaCD.adultStudentInstructorsAula else {
                
                print("ERROR: nil value for aula.instructor array in StudentClassDetailTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 165")
                return UITableViewCell()
            }
            
            if instructorsCD.count != 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewInstructorTableViewCell
                
                cell.instructorCD = instructorsCD.object(at: indexPath.row) as? StudentAdultCD
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewInstructorCell", for: indexPath) as! ReviewInstructorTableViewCell
                
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toProfileComplete") as! OwnersStudentDetailViewController
        
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // set nav bar controller appearance
        navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
        navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if indexPath.section == 0 {
            
            // CoreData version
            guard let ownerInstructorsCD = aulaCD?.ownerInstructorAula else {
                
                print("ERROR: nil value for kidMembersCD array in StudentClassDetailTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 212.")
                return
            }
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let owners = ownerInstructorsCD.sortedArray(using: [nameSort])
            
            guard let ownerCD = owners[indexPath.row] as? OwnerCD else {
                print("ERROR: nil value for studentKidCD in StudentClassDetailTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 220.")
                return
            }
            
            destViewController.ownerCD = ownerCD
            
        } else if indexPath.section == 1 {
            
            // CoreData version
            guard let adultInstructorsCD = aulaCD?.adultStudentInstructorsAula else {
                
                print("ERROR: nil value for adultMembersCD array in StudentClassDetailTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 231.")
                return
            }
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultInstructorsCD.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for studentAdultCD in StudentClassDetailTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 239.")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
        }
    }
}


// MARK: - populateCompletedAulaInfo() for UI display
extension StudentClassDetailTableViewController {
    
    func populateCompletedAulaInfo() {
        
        // CoreData version
        guard let aulaCD = aulaCD else {
            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> populateCompletedAulaInfo() - line 344")
            return
        }
        print("aulaCD.aulaName: \(aulaCD.aulaName ?? "")")
        print("aulaCD.location.locationName: \(aulaCD.location?.locationName ?? "")")
        print("aulaCD.groupsAula.count: \(aulaCD.groupsAula?.count ?? 0)")
        
        guard let location = aulaCD.location else {
            print("there was a nil value in the location passed to ClassInfoDetailsTableViewController.swift -> populateCompletedClassInfo() - line 354")
            return
        }
        guard let dayOfTheWeek = aulaCD.dayOfTheWeek else {
            print("there was a nil value in the dayOfTheWeek passed to ClassInfoDetailsTableViewController.swift -> populateCompletedClassInfo() - line 358")
            return
        }
        
        // name outlet
        classNameLabelOutlet.text = aulaCD.aulaName
        
        // days of the week outlet
        daysOfTheWeekLabelOutlet.text = "\(dayOfTheWeek)"
        
        // time of day outlet
        timeLabelOutlet.text = "\(aulaCD.time ?? "")"

        // location outlet
        locationNameLabelOutlet.text = "\(location.locationName ?? "")"
        // class description
        classDescriptionTextView.text = "\(aulaCD.aulaDescription ?? "")"
        
    }
}



