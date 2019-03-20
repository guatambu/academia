//
//  ReviewAndCreateClassTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ReviewAndCreateClassTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var time: String?
    var timeCode: Int?
    var location: Location?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    
    var locationCD: LocationCD?
    var instructors: [AdultStudent]?
    var ownerInstructors: [Owner]?
    var classGroups: [Group]?
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // tableView Sections Header Labels
    let sectionHeaderLabels = ["Owners", "Instructors"]
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var welcomeInstructionsLabelOutlet: UILabel!
    @IBOutlet weak var classNameLabelOutlet: UILabel!
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
    var instructorsCD: [StudentAdultCD]?
    var ownerInstructorsCD: [OwnerCD]?
    var classGroupsCD: [GroupCD]?
    
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        populateCompletedClassInfo()
        
        // run checks to produce advisory info to user regarding student types selected to a group
        if let instructors = instructors, let ownerInstructors = ownerInstructors, instructors.isEmpty && ownerInstructors.isEmpty {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no owner instructors added to class"
            
        } else if let instructors = instructors, instructors.isEmpty {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no student instructors added to group"
            
        } else if let  ownerInstructors = ownerInstructors, ownerInstructors.isEmpty {
            
            instructorAdvisoryLabelOutlet.isHidden = false
            instructorAdvisoryLabelOutlet.text = "no owner added to group as instructors"
            
        } else {
            
            instructorAdvisoryLabelOutlet.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set VC title font styling
        navigationController?.navigationBar.titleTextAttributes = beltBuilder.gillSansLightRed
        
        title = "Please Review Your Info"
    }
    
    
    // MARK: - Actions
    
    @IBAction func createClassButtonTapped(_ sender: DesignableButton) {
        
        // create AulaCD data model object
        createAulaCoreDataModel()
        
        // create the new location in the LocationModelController source of truth
        createClass()
        
        // programmatic segue back to the MyLocations TVC to view the current locations
        guard let viewControllers = self.navigationController?.viewControllers else {
            print("ERROR: nil value for viewControllers in ReviewAndCreateClassTableViewController.swift -> createClassButtonTapped(sender:) - line 100")
            return
        }
        
        for viewController in viewControllers {
            
            if viewController is OwnerClassListTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            } 
        }
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
        label.frame = CGRect(x: 16, y: 0, width: 120, height: 40)
        
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            if let ownerInstructors = ownerInstructors {
                
                return ownerInstructors.count
            }
        } else if section == 1 {
            if let instructors = instructors {
                
                return instructors.count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let ownerInstructors = ownerInstructors, let instructors = instructors else {
            print("ERROR: nil value for ownerInstructor and/or instructors in ReviewAndCreateClassTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 160")
            return UITableViewCell()
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewOwnerInstructorCell", for: indexPath) as! ReviewOwnerInstructorTableViewCell
            
            cell.ownerInstructor = ownerInstructors[indexPath.row]
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewInsructorCell", for: indexPath) as! ReviewInstructorTableViewCell
            
            cell.instructor = instructors[indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let ownerInstructors = ownerInstructors, let instructors = instructors else {
//            print("ERROR: nil value for ownerInstructor and/or instructors in ReviewAndCreateClassTableViewController.swift -> tableView(tableView:, didSelectRowAt:) - line 185")
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
            guard let ownerInstructorsCD = ownerInstructorsCD else {
                
                print("ERROR: nil value for kidMembersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 242.")
                return
            }
            
            let ownerInstructorsCDSet = NSSet(array: ownerInstructorsCD)
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let kids = ownerInstructorsCDSet.sortedArray(using: [nameSort])
            
            guard let studentKidCD = kids[indexPath.row] as? StudentKidCD else {
                print("ERROR: nil value for studentKidCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 252.")
                return
            }
            
            destViewController.studentKidCD = studentKidCD
            
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
            guard let adultInstructorsCD = instructorsCD else {
                
                print("ERROR: nil value for adultMembersCD array in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 288.")
                return
            }
            
            let adultInstructorsCDSet = NSSet(array: adultInstructorsCD)
            
            let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
            let adults = adultInstructorsCDSet.sortedArray(using: [nameSort])
            
            guard let studentAdultCD = adults[indexPath.row] as? StudentAdultCD else {
                print("ERROR: nil value for studentAdultCD in ReviewAndCreateGroupTableViewController.swift -> tableView(tableView: didSelectRowAt:) - line 298.")
                return
            }
            
            destViewController.studentAdultCD = studentAdultCD
        }
    }
}


// MARK: - Helper Methods -> populateCompletedClassInfo(), createClass()
extension ReviewAndCreateClassTableViewController {
    
    func populateCompletedClassInfo() {
        
        var daysOfTheWeekString = ""
        var groupNamesString = ""
        
        guard let aulaName = aulaName else {
            print("there was a nil value in the aulaName passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 269")
            return
        }
        guard let active = active else {
            print("there was a nil value in the active passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 273")
            return
        }
        guard let aulaDescription = aulaDescription else {
            print("there was a nil value in the aulaDescription passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 277")
            return
        }
        guard let daysOfTheWeek = daysOfTheWeek else {
            print("there was a nil value in the daysOfTheWeek array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 281")
            return
        }
        guard let time = time else {
            print("there was a nil value in the time passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 285")
            return
        }
        guard let location = location else {
            print("there was a nil value in the location passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 289")
            return
        }
        guard let classGroups = classGroups else {
            print("there was a nil value in the classGroups array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 293")
            return
        }
    
        // name outlet
        classNameLabelOutlet.text = aulaName
        // days of th week outlet
        for day in daysOfTheWeek {
            if day == daysOfTheWeek.last {
                daysOfTheWeekString += "\(day.rawValue)"
            } else {
                daysOfTheWeekString += "\(day.rawValue), "
            }
        }
        daysOfTheWeekLabelOutlet.text = daysOfTheWeekString
        // time of day outlet
        timeLabelOutlet.text = "\(time)"
        // active outlet
        if active == true {
            
            activeLabelOutlet.text = "active: YES"
        } else {
            activeLabelOutlet.text = "active: NO"
        }
        // lastChanged outlet
        let currentDayAndTime = Date()
        formatLastChanged(lastChanged: currentDayAndTime)
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
        classDescriptionTextView.text = "\(aulaDescription)"
    }
    
    func createClass() {
        
        guard let aulaName = aulaName else {
            print("there was a nil value in the aulaName passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 337")
            return
        }
        guard let active = active else {
            print("there was a nil value in the active passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 341")
            return
        }
        guard let aulaDescription = aulaDescription else {
            print("there was a nil value in the aulaDescription passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 345")
            return
        }
        guard let daysOfTheWeek = daysOfTheWeek else {
            print("there was a nil value in the daysOfTheWeek array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 349")
            return
        }
        guard let time = time else {
            print("there was a nil value in the time passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 353")
            return
        }
        guard let timeCode = timeCode else {
            print("there was a nil value in the timeCode passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 359")
            return
        }
        guard let location = location else {
            print("there was a nil value in the location passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 363")
            return
        }
        guard let instructors = instructors else {
            print("there was a nil value in the instructors array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 367")
            return
        }
        guard let ownerInstructors = ownerInstructors else {
            print("there was a nil value in the ownerInstructors array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 371")
            return
        }
        guard let classGroups = classGroups else {
            print("there was a nil value in the classGroups array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 375")
            return
        }
        
        for day in daysOfTheWeek {
            
            AulaModelController.shared.add(active: active, className: aulaName, classDescription: aulaDescription, daysOfTheWeek: [day], time: time, timeCode: timeCode, location: location, instructor: instructors, ownerInstructor: ownerInstructors, classGroups: classGroups)
            
        }
        
        print("class daysOfTheWeek array: \(daysOfTheWeek)")
    }
}

// MARK: - date formatter setup for lastChanged display
extension ReviewAndCreateClassTableViewController {
    
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


// MARK: - functions to create, configure, and save AulaCD data model to CoreData
extension ReviewAndCreateClassTableViewController {
    
    func createAulaCoreDataModel() {
        
        guard let aulaName = aulaName else {
            print("there was a nil value in the aulaName passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 425")
            return
        }
        guard let active = active else {
            print("there was a nil value in the active passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 429")
            return
        }
        guard let aulaDescription = aulaDescription else {
            print("there was a nil value in the aulaDescription passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 433")
            return
        }
        guard let time = time else {
            print("there was a nil value in the time passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 441")
            return
        }
        guard let timeCode = timeCode else {
            print("there was a nil value in the timeCode passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 445")
            return
        }
        guard let daysOfTheWeek = daysOfTheWeek else {
            print("there was a nil value in the daysOfTheWeek array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 497")
            return
        }
        guard let location = location else {
            print("there was a nil value in the locationCD passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 449")
            return
        }
        guard let instructorsCD = instructorsCD else {
            print("there was a nil value in the instructorsCD array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 453")
            return
        }
        guard let ownerInstructorsCD = ownerInstructorsCD else {
            print("there was a nil value in the ownerInstructorsCD array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 457")
            return
        }
        guard let classGroupsCD = classGroupsCD else {
            print("there was a nil value in the classGroupsCD array passed to ReviewAndCreateClassTVC.swift -> populateCompletedClassInfo() - line 461")
            return
        }
        
        // convert timeCode Int value to Int16
        guard let timeCodeInt16 = Int16(exactly: timeCode) else { return }
        // create newAula data model object
        let newAula = AulaCD(active: active, aulaName: aulaName, aulaDescription: aulaDescription, time: time, timeCode: timeCodeInt16, location: locationCD)
        
        // create AddressCD data model object
        let addressCD = AddressCD(addressLine1: location.addressLine1, addressLine2: location.addressLine2, city: location.city, state: location.state, zipCode: location.zipCode)
        // create SocialLinksCD data model object
        let socialLinks = LocationSocialLinksCD(socialLink1: location.social1, socialLink2: location.social2, socialLink3: location.social3)
        // properly format location pic to Data type
        guard let locationPicData = location.locationPic?.jpegData(compressionQuality: 1) else { print("fail locationPicData"); return }
        // create LocationCD data model object and assign it to newAula
        locationCD = LocationCD(locationUUID: UUID(), active: true
            , dateCreated: Date(), dateEdited: Date(), locationPic: locationPicData, locationName: location.locationName, phone: location.phone, website: location.website, email: location.email ?? "no email in aula location", address: addressCD, socialLinks: socialLinks, aula: newAula)
        
        // configure newAula "to-many" properties
        // days of the week
        for day in daysOfTheWeek {
            switch day {
            case .Sunday:
                let sunday = AulaDaysOfTheWeekCD(day: day.rawValue)
                newAula.addToDaysOfTheWeek(sunday)
            case .Monday:
                let monday = AulaDaysOfTheWeekCD(day: day.rawValue)
                newAula.addToDaysOfTheWeek(monday)
            case .Tuesday:
                let tuesday = AulaDaysOfTheWeekCD(day: day.rawValue)
                newAula.addToDaysOfTheWeek(tuesday)
            case .Wednesday:
                let wednesday = AulaDaysOfTheWeekCD(day: day.rawValue)
                newAula.addToDaysOfTheWeek(wednesday)
            case .Thursday:
                let thursday = AulaDaysOfTheWeekCD(day: day.rawValue)
                newAula.addToDaysOfTheWeek(thursday)
            case .Friday:
                let friday = AulaDaysOfTheWeekCD(day: day.rawValue)
                newAula.addToDaysOfTheWeek(friday)
            case .Saturday:
                let saturday = AulaDaysOfTheWeekCD(day: day.rawValue)
                newAula.addToDaysOfTheWeek(saturday)
            }
        }
        // instructors
        if !instructorsCD.isEmpty {
            // add instructors to newAula
            for instructor in instructorsCD {
                newAula.addToAdultStudentInstructorsAula(instructor)
            }
        }
        // owner instructors
        if !ownerInstructorsCD.isEmpty {
            // add instructors to newAula
            for ownerInstructor in ownerInstructorsCD {
                newAula.addToOwnerInstructorAula(ownerInstructor)
            }
        }
        // groups associated with newAula
        if !classGroupsCD.isEmpty {
            // add groups to newAula
            for group in classGroupsCD {
                newAula.addToGroupsAula(group)
            }
        }
        
        // add the created and configured aulato the source of truth
        AulaCDModelController.shared.add(aula: newAula)
        // save to CoreData
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}




// TODO:  set the entire data models throughout the app to CoreData sources of truth for next step in testing.  that goes for all the Data Model Object types: Owner, students, location, payment program, aula, groups across their respective creation workflows
