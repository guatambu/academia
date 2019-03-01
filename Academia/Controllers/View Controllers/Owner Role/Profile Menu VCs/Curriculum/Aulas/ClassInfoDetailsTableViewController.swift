//
//  ClassInfoDetailsTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.


import UIKit

class ClassInfoDetailsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var aula: Aula?
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Owners", "Instructors"]
    
    let beltBuilder = BeltBuilder()
    
    // outlets
    @IBOutlet weak var classNameLabelOutlet: UILabel!
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var daysOfTheWeekLabelOutlet: UILabel!
    @IBOutlet weak var timeLabelOutlet: UILabel!
    @IBOutlet weak var activeLabelOutlet: UILabel!
    @IBOutlet weak var lastChangedLabelOutlet: UILabel!
    @IBOutlet weak var elligibleGroupsLabelOutlet: UILabel!
    @IBOutlet weak var groupListLabelOutlet: UILabel!
    @IBOutlet weak var locationLabelOutlet: UILabel!
    @IBOutlet weak var locationNameLabelOutlet: UILabel!
    @IBOutlet weak var classDescriptionTextView: UITextView!
    @IBOutlet weak var instructorAdvisoryLabelOutlet: UILabel!
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedAulaInfo()
        
        // run checks to produce advisory info to user regarding student types selected to a group
        if let instructors = aula?.instructor, let ownerInstructors = aula?.ownerInstructor, instructors.isEmpty && ownerInstructors.isEmpty {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no owner instructors added to class"
            
        } else if let instructors = aula?.instructor, instructors.isEmpty {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no student instructors added to group"
            
        } else if let  ownerInstructors = aula?.ownerInstructor, ownerInstructors.isEmpty {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no owner added to group as instructors"
            
        } else {
            
            instructorAdvisoryLabelOutlet.isHidden = true
        }
        
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
        
        guard let aula = aula else {
            print("ERROR: found nil value when unwrapping aula property in ClassInfoDetailsTableViewController.swift -> viewDidLoad() - line 48.")
            return
        }
        
        print("daysOfTheWeek: \(aula.daysOfTheWeek)")
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func deleteClassButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Group", message: "are you sure you want to delete this group?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAccount = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive) { (alert) in
            
            AulaModelController.shared.delete(aula: AulaModelController.shared.aulas[0])
            
            // programmatically performing the segue
            guard let viewControllers = self.navigationController?.viewControllers else { return }
            
            for viewController in viewControllers {
                
                if viewController is OwnerClassListTableViewController{
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
            
            print("how many location we got now: \(AulaModelController.shared.aulas.count)")
        }
        
        alertController.addAction(cancel)
        alertController.addAction(deleteAccount)
        
        self.present(alertController, animated: true)
        
    }
    
    
    // MARK: - editButtonTapped()
    @IBAction func editButtonTapped(_ sender: Any) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerBaseCampFlow", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toClassNameAndDescription") as! ClassNameAndDescriptionViewController
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
        
        // set properties on destinationVC
        destViewController.inEditingMode = true
        
        aulaToEdit = aula
        destViewController.aulaToEdit = aulaToEdit
        
    }
    
    
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
        
        guard let aula = aula else {
            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 152")
            return 0
        }
        
        guard let instructors = aula.instructor, let ownerInstructors = aula.ownerInstructor else {
            
            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 158")
            return 0
        }
        
        if section == 0 {
            return ownerInstructors.count
            
        } else if section == 1 {
            return instructors.count
            
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let aula = aula else {
            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 171")
            return UITableViewCell()
        }
        
        guard let instructors = aula.instructor, let ownerInstructors = aula.ownerInstructor else {
            
            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 177")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            if ownerInstructors.isEmpty {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
                
                cell.ownerInstructor = ownerInstructors[indexPath.row]
                
                return cell
            }
            
            
        } else {
            
            if instructors.isEmpty {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewInstructorCell", for: indexPath) as! ReviewInstructorTableViewCell
                
                cell.instructor = instructors[indexPath.row]
                
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let aula = aula else {
            print("ERROR: nil value for group property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 197")
            return
        }
        
        guard let instructors = aula.instructor, let ownerInstructors = aula.ownerInstructor else {
            
            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 203")
            return
        }
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "OwnerStudentsFlow", bundle: nil)
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
            // kidStudent setup
            let owner = ownerInstructors[indexPath.row]
            
            destViewController.isOwner = true
            destViewController.isKid = false
            destViewController.username = owner.username
            destViewController.password = owner.password
            destViewController.firstName = owner.firstName
            destViewController.lastName = owner.lastName
            destViewController.profilePic = owner.profilePic
            destViewController.birthdate = owner.birthdate
            destViewController.beltLevel = owner.belt.beltLevel
            destViewController.numberOfStripes = owner.belt.numberOfStripes
            destViewController.addressLine1 = owner.addressLine1
            destViewController.addressLine2 = owner.addressLine2
            destViewController.city = owner.city
            destViewController.state = owner.state
            destViewController.zipCode = owner.zipCode
            destViewController.phone = owner.phone
            destViewController.mobile = owner.mobile
            destViewController.email = owner.email
            destViewController.emergencyContactName = owner.emergencyContactName
            destViewController.emergencyContactRelationship = owner.emergencyContactRelationship
            destViewController.emergencyContactPhone = owner.emergencyContactPhone
            
        } else if indexPath.section == 1 {
            // adultStudent setup
            let adult = instructors[indexPath.row]
            
            destViewController.isOwner = false
            destViewController.isKid = false
            destViewController.username = adult.username
            destViewController.password = adult.password
            destViewController.firstName = adult.firstName
            destViewController.lastName = adult.lastName
            destViewController.profilePic = adult.profilePic
            destViewController.birthdate = adult.birthdate
            destViewController.beltLevel = adult.belt.beltLevel
            destViewController.numberOfStripes = adult.belt.numberOfStripes
            destViewController.addressLine1 = adult.addressLine1
            destViewController.addressLine2 = adult.addressLine2
            destViewController.city = adult.city
            destViewController.state = adult.state
            destViewController.zipCode = adult.zipCode
            destViewController.phone = adult.phone
            destViewController.mobile = adult.mobile
            destViewController.email = adult.email
            destViewController.emergencyContactName = adult.emergencyContactName
            destViewController.emergencyContactRelationship = adult.emergencyContactRelationship
            destViewController.emergencyContactPhone = adult.emergencyContactPhone
            
        }
    }
}


extension ClassInfoDetailsTableViewController {
    
    func populateCompletedAulaInfo() {
        
        guard let aula = aula else {
            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> populateCompletedAulaInfo() - line 327")
            return
        }
        
        var daysOfTheWeekString = ""
        var groupNamesString = ""
        
        
        guard let time = aula.time else {
            print("there was a nil value in the time passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 285")
            return
        }
        guard let location = aula.location else {
            print("there was a nil value in the location passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 289")
            return
        }
        guard let classGroups = aula.classGroups else {
            print("there was a nil value in the classGroups array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 293")
            return
        }
        
        // name outlet
        classNameLabelOutlet.text = aula.aulaName
        // days of th week outlet
        for day in aula.daysOfTheWeek {
            if day == aula.daysOfTheWeek.last {
                daysOfTheWeekString += "\(day.rawValue)"
            } else {
                daysOfTheWeekString += "\(day.rawValue), "
            }
        }
        daysOfTheWeekLabelOutlet.text = daysOfTheWeekString
        // time of day outlet
        timeLabelOutlet.text = "\(time)"
        // active outlet
        if aula.active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        formatLastChanged(lastChanged: aula.dateEdited)
        // group list outlet
        for group in classGroups {
            if group == classGroups.last {
                groupNamesString += "\(group.name)"
            } else {
                groupNamesString += "\(group.name), "
            }
        }
        groupListLabelOutlet.text = groupNamesString
        // location outlet
        locationNameLabelOutlet.text = "\(location.locationName)"
        // class description
        classDescriptionTextView.text = "\(aula.aulaDescription)"
    }
}


// MARK: - Programmatic Segues to return to proper ProfileFlow storyboard and group profileVC
extension UIViewController {
    
    func returnToClassInfo() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is ClassInfoDetailsTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}


// MARK: - date formatter setup for lastChanged display
extension ClassInfoDetailsTableViewController {
    
    func formatLastChanged(lastChanged: Date) {
        
        // set up date format
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let lastChangedString = dateFormatter.string(from: lastChanged)
        
        print(lastChangedString)
        
        self.lastChangedLabelOutlet.text = "last change: " + lastChangedString
    }
}
