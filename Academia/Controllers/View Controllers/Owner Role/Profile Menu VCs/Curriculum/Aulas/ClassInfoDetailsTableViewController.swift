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
    
    // CoreData properties
    var aulaCD: AulaCD?
    var dayOfTheWeek: String?
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedAulaInfo()
        
        // run checks to produce advisory info to user regarding student types selected to a group
        
//        if let instructors = aula?.instructor, let ownerInstructors = aula?.ownerInstructor, instructors.isEmpty && ownerInstructors.isEmpty {
//
//            instructorAdvisoryLabelOutlet.isHidden = false
//            instructorAdvisoryLabelOutlet.text = "no owner instructors added to class"
//
//        } else if let instructors = aula?.instructor, instructors.isEmpty {
//
//            instructorAdvisoryLabelOutlet.isHidden = false
//            instructorAdvisoryLabelOutlet.text = "no student instructors added to group"
//
//        } else if let  ownerInstructors = aula?.ownerInstructor, ownerInstructors.isEmpty {
//
//            instructorAdvisoryLabelOutlet.isHidden = false
//            instructorAdvisoryLabelOutlet.text = "no owner added to group as instructors"
//
//        } else {
//
//            instructorAdvisoryLabelOutlet.isHidden = true
//        }
        
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
            print("ERROR: found nil value when unwrapping aula property in ClassInfoDetailsTableViewController.swift -> viewDidLoad() - line 48.")
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
        
//        guard let aula = aula else {
//            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 189")
//            return 0
//        }
//        
//        guard let instructors = aula.instructor, let ownerInstructors = aula.ownerInstructor else {
//            
//            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 195")
//            return 0
//        }
        
        // CoreData version
        guard let aulaCD = aulaCD else {
            print("ERROR: nil value for aulaCD property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 200")
            return 0
        }
        
        guard let instructorsCD = aulaCD.adultStudentInstructorsAula, let ownerInstructorsCD = aulaCD.ownerInstructorAula else {
            
            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 195")
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
        
//        guard let aula = aula else {
//            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 171")
//            return UITableViewCell()
//        }
//
//        guard let instructors = aula.instructor, let ownerInstructors = aula.ownerInstructor else {
//
//            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 177")
//            return UITableViewCell()
//        }
//
//        // Configure the cell...
//        if indexPath.section == 0 {
//
//            if ownerInstructors.isEmpty {
//
//                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
//
//                return cell
//
//            } else {
//
//                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
//
//                cell.ownerInstructor = ownerInstructors[indexPath.row]
//
//                return cell
//            }
//
//
//        } else {
//
//            if instructors.isEmpty {
//
//                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
//
//                return cell
//
//            } else {
//
//                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewInstructorCell", for: indexPath) as! ReviewInstructorTableViewCell
//
//                cell.instructor = instructors[indexPath.row]
//
//                return cell
//            }
//        }
        
        // CoreData version
        guard let aulaCD = aulaCD else {
            
            print("ERROR: nil value for aulaCD property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, cellForRowAt:) - line 301")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            
            guard let ownerInstructorsCD = aulaCD.ownerInstructorAula else {
                
                print("ERROR: nil value for aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 316")
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
                
                print("ERROR: nil value for aula.instructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 340")
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
        
//        guard let aula = aula else {
//            print("ERROR: nil value for group property in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, didSelectRowAt:) - line 197")
//            return
//        }
//        
//        guard let instructors = aula.instructor, let ownerInstructors = aula.ownerInstructor else {
//            
//            print("ERROR: nil value for aula.instructor or aula.ownerInstructor array in ClassInfoDetailsTableViewController.swift -> tableView(_ tableView:, numberOfRowsInSection:) - line 203")
//            return
//        }
        
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
            // kidStudent setup
            //            let kid = mockKids[indexPath.row]
            //
            //            destViewController.isOwner = false
            //            destViewController.isKid = true
            //            destViewController.username = kid.username
            //            destViewController.password = kid.password
            //            destViewController.firstName = kid.firstName
            //            destViewController.lastName = kid.lastName
            //            destViewController.parentGuardian = kid.parentGuardian
            //            destViewController.profilePic = kid.profilePic
            //            destViewController.birthdate = kid.birthdate
            //            destViewController.beltLevel = kid.belt.beltLevel
            //            destViewController.numberOfStripes = kid.belt.numberOfStripes
            //            destViewController.addressLine1 = kid.addressLine1
            //            destViewController.addressLine2 = kid.addressLine2
            //            destViewController.city = kid.city
            //            destViewController.state = kid.state
            //            destViewController.zipCode = kid.zipCode
            //            destViewController.phone = kid.phone
            //            destViewController.mobile = kid.mobile
            //            destViewController.email = kid.email
            //            destViewController.emergencyContactName = kid.emergencyContactName
            //            destViewController.emergencyContactRelationship = kid.emergencyContactRelationship
            //            destViewController.emergencyContactPhone = kid.emergencyContactPhone
            
            
            // CoreData version
            guard let ownerInstructorsCD = aulaCD?.ownerInstructorAula else {
                
                print("ERROR: nil value for kidMembersCD array in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 363.")
                return
            }
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let owners = ownerInstructorsCD.sortedArray(using: [nameSort])
            
            guard let ownerCD = owners[indexPath.row] as? OwnerCD else {
                print("ERROR: nil value for studentKidCD in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 371.")
                return
            }
            
            destViewController.ownerCD = ownerCD
            
        } else if indexPath.section == 1 {
            // adultStudent setup
            //            let adult = mockAdults[indexPath.row]
            //
            //            destViewController.isOwner = false
            //            destViewController.isKid = false
            //            destViewController.username = adult.username
            //            destViewController.password = adult.password
            //            destViewController.firstName = adult.firstName
            //            destViewController.lastName = adult.lastName
            //            destViewController.profilePic = adult.profilePic
            //            destViewController.birthdate = adult.birthdate
            //            destViewController.beltLevel = adult.belt.beltLevel
            //            destViewController.numberOfStripes = adult.belt.numberOfStripes
            //            destViewController.addressLine1 = adult.addressLine1
            //            destViewController.addressLine2 = adult.addressLine2
            //            destViewController.city = adult.city
            //            destViewController.state = adult.state
            //            destViewController.zipCode = adult.zipCode
            //            destViewController.phone = adult.phone
            //            destViewController.mobile = adult.mobile
            //            destViewController.email = adult.email
            //            destViewController.emergencyContactName = adult.emergencyContactName
            //            destViewController.emergencyContactRelationship = adult.emergencyContactRelationship
            //            destViewController.emergencyContactPhone = adult.emergencyContactPhone
            
            
            // CoreData version
            guard let adultInstructorsCD = aulaCD?.adultStudentInstructorsAula else {
                
                print("ERROR: nil value for adultMembersCD array in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 407.")
                return
            }
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultInstructorsCD.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for studentAdultCD in ClassInfoDetailsTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 415.")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
        }
    }
}


extension ClassInfoDetailsTableViewController {
    
    func populateCompletedAulaInfo() {
        
//        guard let aula = aula else {
//            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> populateCompletedAulaInfo() - line 327")
//            return
//        }
//
//        var daysOfTheWeekString = ""
//        var groupNamesString = ""
//
//
//        guard let time = aula.time else {
//            print("there was a nil value in the time passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 285")
//            return
//        }
//        guard let location = aula.location else {
//            print("there was a nil value in the location passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 289")
//            return
//        }
//        guard let classGroups = aula.classGroups else {
//            print("there was a nil value in the classGroups array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 293")
//            return
//        }
//
//        // name outlet
//        classNameLabelOutlet.text = aula.aulaName
//        // days of th week outlet
//        for day in aula.daysOfTheWeek {
//            if day == aula.daysOfTheWeek.last {
//                daysOfTheWeekString += "\(day.rawValue)"
//            } else {
//                daysOfTheWeekString += "\(day.rawValue), "
//            }
//        }
//        daysOfTheWeekLabelOutlet.text = daysOfTheWeekString
//        // time of day outlet
//        timeLabelOutlet.text = "\(time)"
//        // active outlet
//        if aula.active == true {
//
//            activeLabelOutlet.text = "active: YES"
//        } else {
//            activeLabelOutlet.text = "active: NO"
//        }
//        // lastChanged outlet
//        formatLastChanged(lastChanged: aula.dateEdited)
//        // group list outlet
//        for group in classGroups {
//            if group == classGroups.last {
//                groupNamesString += "\(group.name)"
//            } else {
//                groupNamesString += "\(group.name), "
//            }
//        }
//        groupListLabelOutlet.text = groupNamesString
//        // location outlet
//        locationNameLabelOutlet.text = "\(location.locationName)"
//        // class description
//        classDescriptionTextView.text = "\(aula.aulaDescription)"
        
        // CoreData version
        guard let aulaCD = aulaCD else {
            print("ERROR: nil value for aula property in ClassInfoDetailsTableViewController.swift -> populateCompletedAulaInfo() - line 488")
            return
        }
        guard let location = aulaCD.location else {
            print("there was a nil value in the location passed to ClassInfoDetailsTableViewController.swift -> populateCompletedClassInfo() - line 493")
            return
        }
        guard let classGroups = aulaCD.groupsAula else {
            print("there was a nil value in the groupsAula array passed to ClassInfoDetailsTableViewController.swift -> populateCompletedClassInfo() - line 497")
            return
        }
        
        var groupNamesString = ""
        let groupCounter = classGroups.count
        
        // name outlet
        classNameLabelOutlet.text = aulaCD.aulaName
        // days of th week outlet
        daysOfTheWeekLabelOutlet.text = dayOfTheWeek
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
            
            for _ in 1...classGroups.count {
                
                let groupCD = classGroups.object(at: (classGroups.count - 1)) as! GroupCD
                
                if groupCounter <= 1 {
                    groupNamesString += "\(groupCD.name ?? "")"
                } else {
                    groupNamesString += "\(groupCD.name ?? ""), "
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
        
        print(lastChangedString)
        
        self.lastChangedLabelOutlet.text = "last change: " + lastChangedString
    }
}
