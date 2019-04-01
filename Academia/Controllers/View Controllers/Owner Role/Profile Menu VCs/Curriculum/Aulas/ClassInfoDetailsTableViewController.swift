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
    let classTimeComponents = ClassTimeComponents()
    
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
    
    // CoreData properties
    var aulaCD: AulaCD?
    var dayOfTheWeek: String?
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedAulaInfo()
        
        // CoreData version
        if let instructorsCD = aulaCD?.adultStudentInstructorsAula, let ownerInstructorsCD = aulaCD?.ownerInstructorAula, instructorsCD.count == 0 && ownerInstructorsCD.count == 0 {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no owner instructors added to class"
            
        } else if let instructorsCD = aulaCD?.adultStudentInstructorsAula, instructorsCD.count == 0 {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no student instructors added to group"
            
        } else if let  ownerInstructorsCD = aulaCD?.ownerInstructorAula, ownerInstructorsCD.count == 0 {
            
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
        
        guard let aulaCD = aulaCD else {
            print("ERROR: found nil value when unwrapping aula property in ClassInfoDetailsTableViewController.swift -> viewDidLoad() - line 87.")
            return
        }
        
        print("daysOfTheWeek: \(String(describing: aulaCD.aulaName))")
        
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
        destViewController.aulaCDToEdit = aulaCD
        
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
        
        // CoreData version
        guard let aulaCD = aulaCD else {
            print("ERROR: nil value for aulaCD property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 191")
            return 0
        }
        
        guard let instructorsCD = aulaCD.adultStudentInstructorsAula, let ownerInstructorsCD = aulaCD.ownerInstructorAula else {
            
            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 197")
            return 0
        }
        
        if section == 0 {
//            return ownerInstructors.count
            
            return ownerInstructorsCD.count
            
        } else if section == 1 {
//            return instructors.count
            
            return instructorsCD.count
            
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // CoreData version
        guard let aulaCD = aulaCD else {
            
            print("ERROR: nil value for aulaCD property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 221")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            guard let ownerInstructorsCD = aulaCD.ownerInstructorAula else {
                
                print("ERROR: nil value for aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 230")
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
                
                print("ERROR: nil value for aula.instructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 254")
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
                
                print("ERROR: nil value for kidMembersCD array in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 301.")
                return
            }
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let owners = ownerInstructorsCD.sortedArray(using: [nameSort])
            
            guard let ownerCD = owners[indexPath.row] as? OwnerCD else {
                print("ERROR: nil value for studentKidCD in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 309.")
                return
            }
            
            destViewController.ownerCD = ownerCD
            
        } else if indexPath.section == 1 {

            // CoreData version
            guard let adultInstructorsCD = aulaCD?.adultStudentInstructorsAula else {
                
                print("ERROR: nil value for adultMembersCD array in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 320.")
                return
            }
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultInstructorsCD.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for studentAdultCD in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 328.")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
        }
    }
}


extension ClassInfoDetailsTableViewController {
    
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
        guard let classGroups = aulaCD.groupsAula else {
            print("there was a nil value in the groupsAula array passed to ClassInfoDetailsTableViewController.swift -> populateCompletedClassInfo() - line 362")
            return
        }
        
        // sort the classGroups on the .name property to return them in alphabetical order
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let sortedClassGroups = classGroups.sortedArray(using: [nameSort])
        
        // properties to properly build a string to list the names of the included groups (if any)
        var groupNamesString = ""
        // set a counter property to track where we are in the array iteration process so we can know when we are at the last object in the array's contents
        var groupCounter = classGroups.count
        
        // name outlet
        classNameLabelOutlet.text = aulaCD.aulaName
        
        // days of the week outlet
        daysOfTheWeekLabelOutlet.text = "\(dayOfTheWeek)"
        
        // time of day outlet
        timeLabelOutlet.text = "\(aulaCD.time ?? "")"
        // active outlet
        if aulaCD.active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        formatLastChanged(lastChanged: aulaCD.dateEdited ?? Date())
        // group list outlet
        if classGroups.count != 0 {
            
            for i in 1...classGroups.count {
                
                let groupCD = sortedClassGroups[i - 1] as! GroupCD
                
                if groupCounter < i {
                    groupNamesString += "\(groupCD.name ?? "")"
                } else {
                    groupNamesString += "\(groupCD.name ?? ""), "
                    groupCounter -= 1
                }
            }
        }
        groupListLabelOutlet.text = groupNamesString
        // location outlet
        locationNameLabelOutlet.text = "\(location.locationName ?? "")"
        // class description
        classDescriptionTextView.text = "\(aulaCD.aulaDescription ?? "")"
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
        
        self.lastChangedLabelOutlet.text = "last change: " + lastChangedString
    }
}
