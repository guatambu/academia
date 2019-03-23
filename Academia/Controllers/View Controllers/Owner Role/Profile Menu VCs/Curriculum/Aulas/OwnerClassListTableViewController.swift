//
//  OwnerClassListTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit
import CoreData

class OwnerClassListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // create a fetchedRequestController with predicate to grab the current AulaCD objects... use these as the source for the tableView DataSource  methods
    var fetchedResultsController: NSFetchedResultsController<AulaCD>!
    
    let beltBuilder = BeltBuilder()
    
    @IBOutlet weak var addClassRightBarButtonOutlet: UIBarButtonItem!
    
    
    // tableView Sections Header Labels
    let weekdays: [ClassTimeComponents.Weekdays] = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        // create fetch request and initialize results
        initializeFetchedResultsController()
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("aulas array in AulaModelController:\(AulaModelController.shared.aulas)")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // may want to have sections with titles here
        return weekdays.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        sectionHeaderView.backgroundColor = UIColor.white
        
        let avenirFont16 = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)! ]
        
        let label = UILabel()
        label.attributedText = NSAttributedString(string: weekdays[section].rawValue, attributes: avenirFont16)
        label.frame = CGRect(x: 16, y: 0, width: 200, height: 40)
        
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // get the returned [AulaCD] fetchedObjects array from fetchedResultsController
        guard let aulasCD = fetchedResultsController.fetchedObjects else {
            return 0
        }
        
        // for each section, search the returned aulasCD array for each day of the week String and populate the weekday sections arrays according to those reuslts
        
        // Sunday
        if section == 0 {
            
            var sundays: NSSet = []
            
            for aula in aulasCD {
                
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Sunday.rawValue)")
                    sundays = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
            }
            print("sundays: \(sundays.count)")
            return sundays.count
          
        // Monday
        } else if section == 1 {
            
            var mondays: NSSet = []
            
            for aula in aulasCD {
                
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Monday.rawValue)")
                    mondays = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
            }
            print("mondays: \(mondays.count)")
            return mondays.count
        
        // Tuesday
        } else if section == 2 {
            
            var tuesdays: NSSet = []
            
            for aula in aulasCD {
                
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Tuesday.rawValue)")
                    tuesdays = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
            }
            print("tuesdays: \(tuesdays.count)")
            return tuesdays.count
        
        // Wednesday
        } else if section == 3 {
            
            var wednesdays: NSSet = []
            
            for aula in aulasCD {
                
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Wednesday.rawValue)")
                    wednesdays = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
            }
            print("wednesdays: \(wednesdays.count)")
            return wednesdays.count
        
        // Thursday
        } else if section == 4 {
            
            var thursdays: NSSet = []
            
            for aula in aulasCD {
                
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Thursday.rawValue)")
                    thursdays = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
            }
            print("thursdays: \(thursdays.count)")
            return thursdays.count
         
        // Friday
        } else if section == 5 {
            
            var fridays: NSSet = []
            
            for aula in aulasCD {
                
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Friday.rawValue)")
                    fridays = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
            }
            print("fridays: \(fridays.count)")
            return fridays.count
         
        // Saturday
        } else if section == 6 {
            
            var saturdays: NSSet = []
            
            for aula in aulasCD {
                
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Saturday.rawValue)")
                    saturdays = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
            }
            print("saturdays: \(saturdays.count)")
            return saturdays.count
        
        // error case where some random section were to be displayed
        } else {
            print("ERROR: unexpected UITableView section created in OwnerClassListTableViewController.swift -> tableView(tableView:, numberOfRowsInSection:) - line 167")
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get the returned [AulaCD] fetchedObjects array from fetchedResultsController
        guard let aulasCD = fetchedResultsController.fetchedObjects else {
            return UITableViewCell()
        }
        
        

        // Configure the cell...
        
        // for each section, search the returned aulasCD array for each day of the week String and populate the cells according to those reuslts
        
        // Sunday
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var sundays = [AulaCD]()
            
            var sundaySet: NSSet = []
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Sunday.rawValue)")
                    // using the predicate, return the filtered result to the sundaySet
                    sundaySet = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
                // if the sundaySet has a value for this aula object, then that confirms there is an aula for htis day, so append the aula to the sundays: [AulaCD] array
                print("sundays: \(sundaySet.count)")
                
                if sundaySet.count != 0 {
                    sundays.append(aula)
                }
            }
            // sort sundays array to display included classes by timeCode
            sundays.sort(by: {$0.timeCode < $1.timeCode })
            print("sundays: \(sundays)")
            // if the sundays: [AulaCD array is not empty, pass the contents to the cell via the appropriate indexPath.row Int value]
            // Configure the cell
            if !sundays.isEmpty {
                let aulaCD = sundays[indexPath.row]
                cell.aulaCD = aulaCD
                return cell
            } else {
                // if there is nothing in the sundays array, return an empty cell
                return UITableViewCell()
            }
            
        // Monday
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var mondays = [AulaCD]()
            
            var mondaySet: NSSet = []
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Monday.rawValue)")
                    // using the predicate, return the filtered result to the sundaySet
                    mondaySet = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
                // if the sundaySet has a value for this aula object, then that confirms there is an aula for htis day, so append the aula to the sundays: [AulaCD] array
                print("sundays: \(mondaySet.count)")
                
                if mondaySet.count != 0 {
                    mondays.append(aula)
                }
            }
            // sort sundays array to display included classes by timeCode
            mondays.sort(by: {$0.timeCode < $1.timeCode })
            print("sundays: \(mondays)")
            // if the sundays: [AulaCD array is not empty, pass the contents to the cell via the appropriate indexPath.row Int value]
            // Configure the cell
            if !mondays.isEmpty {
                let aulaCD = mondays[indexPath.row]
                cell.aulaCD = aulaCD
                return cell
            } else {
                // if there is nothing in the sundays array, return an empty cell
                return UITableViewCell()
            }
            
        // Tuesday
        } else if indexPath.section == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var tuesdays = [AulaCD]()
            
            var tuesdaySet: NSSet = []
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Tuesday.rawValue)")
                    // using the predicate, return the filtered result to the sundaySet
                    tuesdaySet = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
                // if the sundaySet has a value for this aula object, then that confirms there is an aula for htis day, so append the aula to the sundays: [AulaCD] array
                print("sundays: \(tuesdaySet.count)")
                
                if tuesdaySet.count != 0 {
                    tuesdays.append(aula)
                }
            }
            // sort sundays array to display included classes by timeCode
            tuesdays.sort(by: {$0.timeCode < $1.timeCode })
            print("sundays: \(tuesdays)")
            // if the sundays: [AulaCD array is not empty, pass the contents to the cell via the appropriate indexPath.row Int value]
            // Configure the cell
            if !tuesdays.isEmpty {
                let aulaCD = tuesdays[indexPath.row]
                cell.aulaCD = aulaCD
                return cell
            } else {
                // if there is nothing in the sundays array, return an empty cell
                return UITableViewCell()
            }
            
        // Wednesday
        } else if indexPath.section == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var wednesdays = [AulaCD]()
            
            var wednesdaySet: NSSet = []
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Wednesday.rawValue)")
                    // using the predicate, return the filtered result to the sundaySet
                    wednesdaySet = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
                // if the sundaySet has a value for this aula object, then that confirms there is an aula for htis day, so append the aula to the sundays: [AulaCD] array
                print("sundays: \(wednesdaySet.count)")
                
                if wednesdaySet.count != 0 {
                    wednesdays.append(aula)
                }
            }
            // sort sundays array to display included classes by timeCode
            wednesdays.sort(by: {$0.timeCode < $1.timeCode })
            print("sundays: \(wednesdays)")
            // if the sundays: [AulaCD array is not empty, pass the contents to the cell via the appropriate indexPath.row Int value]
            // Configure the cell
            if !wednesdays.isEmpty {
                let aulaCD = wednesdays[indexPath.row]
                cell.aulaCD = aulaCD
                return cell
            } else {
                // if there is nothing in the sundays array, return an empty cell
                return UITableViewCell()
            }
            
        // Thursday
        } else if indexPath.section == 4 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var thursdays = [AulaCD]()
            
            var thursdaySet: NSSet = []
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Thursday.rawValue)")
                    // using the predicate, return the filtered result to the sundaySet
                    thursdaySet = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
                // if the sundaySet has a value for this aula object, then that confirms there is an aula for htis day, so append the aula to the sundays: [AulaCD] array
                print("sundays: \(thursdaySet.count)")
                
                if thursdaySet.count != 0 {
                    thursdays.append(aula)
                }
            }
            // sort sundays array to display included classes by timeCode
            thursdays.sort(by: {$0.timeCode < $1.timeCode })
            print("sundays: \(thursdays)")
            // if the sundays: [AulaCD array is not empty, pass the contents to the cell via the appropriate indexPath.row Int value]
            // Configure the cell
            if !thursdays.isEmpty {
                let aulaCD = thursdays[indexPath.row]
                cell.aulaCD = aulaCD
                return cell
            } else {
                // if there is nothing in the sundays array, return an empty cell
                return UITableViewCell()
            }
        
        // Friday
        } else if indexPath.section == 5 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var fridays = [AulaCD]()
            
            var fridaySet: NSSet = []
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Friday.rawValue)")
                    // using the predicate, return the filtered result to the sundaySet
                    fridaySet = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
                // if the sundaySet has a value for this aula object, then that confirms there is an aula for htis day, so append the aula to the sundays: [AulaCD] array
                print("sundays: \(fridaySet.count)")
                
                if fridaySet.count != 0 {
                    fridays.append(aula)
                }
            }
            // sort sundays array to display included classes by timeCode
            fridays.sort(by: {$0.timeCode < $1.timeCode })
            print("sundays: \(fridays)")
            // if the sundays: [AulaCD array is not empty, pass the contents to the cell via the appropriate indexPath.row Int value]
            // Configure the cell
            if !fridays.isEmpty {
                let aulaCD = fridays[indexPath.row]
                cell.aulaCD = aulaCD
                return cell
            } else {
                // if there is nothing in the sundays array, return an empty cell
                return UITableViewCell()
            }
        
        // Saturday
        } else if indexPath.section == 6 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var saturdays = [AulaCD]()
            
            var saturdaySet: NSSet = []
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let daysOfTheWeek = aula.daysOfTheWeek {
                    let predicate = NSPredicate(format: "day == %@", "\(ClassTimeComponents.Weekdays.Saturday.rawValue)")
                    // using the predicate, return the filtered result to the sundaySet
                    saturdaySet = daysOfTheWeek.filtered(using: predicate) as NSSet
                }
                // if the sundaySet has a value for this aula object, then that confirms there is an aula for htis day, so append the aula to the sundays: [AulaCD] array
                print("sundays: \(saturdaySet.count)")
                
                if saturdaySet.count != 0 {
                    saturdays.append(aula)
                }
            }
            // sort sundays array to display included classes by timeCode
            saturdays.sort(by: {$0.timeCode < $1.timeCode })
            print("sundays: \(saturdays)")
            // if the sundays: [AulaCD array is not empty, pass the contents to the cell via the appropriate indexPath.row Int value]
            // Configure the cell
            if !saturdays.isEmpty {
                let aulaCD = saturdays[indexPath.row]
                cell.aulaCD = aulaCD
                return cell
                
            } else {
                // if there is nothing in the sundays array, return an empty cell
                return UITableViewCell()
            }
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            print("ERROR: unexpected UITableView section created in OwnerClassListTableViewController.swift -> tableView(tableView:, cellForRowAt:) - line 249")
            
            return cell
        }
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toAulaInfoDetailsSegue" {
            guard let destinationTVC = segue.destination as? ClassInfoDetailsTableViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // Sunday
            if indexPath.section == 0 {
                
                var sundays: [Aula] = []
                
                for aula in AulaModelController.shared.aulas {
                    
                    if aula.daysOfTheWeek.contains(.Sunday) {
                        sundays.append(aula)
                    }
                }
                
                // sort sundays array to display classes by timeCode
                sundays.sort(by: {$0.timeCode ?? 0 < $1.timeCode ?? 0})
                print(sundays)
                
                let aula = sundays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aula = aula
                
            // Monday
            } else if indexPath.section == 1 {
                
                var mondays: [Aula] = []
                
                for aula in AulaModelController.shared.aulas {
                    
                    if aula.daysOfTheWeek.contains(.Monday) {
                        mondays.append(aula)
                    }
                }
                
                // sort mondays array to display classes by timeCode
                mondays.sort(by: {$0.timeCode ?? 0 < $1.timeCode ?? 0})
                print(mondays)
                
                let aula = mondays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aula = aula
                
            // Tuesday
            } else if indexPath.section == 2 {
                
                var tuesdays: [Aula] = []
                
                for aula in AulaModelController.shared.aulas {
                    
                    if aula.daysOfTheWeek.contains(.Tuesday) {
                        tuesdays.append(aula)
                    }
                }
                
                // sort tuesdays array to display classes by timeCode
                tuesdays.sort(by: {$0.timeCode ?? 0 < $1.timeCode ?? 0})
                print(tuesdays)
                
                let aula = tuesdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aula = aula
                
            // Wednesday
            } else if indexPath.section == 3 {
                
                var wednesdays: [Aula] = []
                
                for aula in AulaModelController.shared.aulas {
                    
                    if aula.daysOfTheWeek.contains(.Wednesday) {
                        wednesdays.append(aula)
                    }
                }
                
                // sort wednesdays array to display classes by timeCode
                wednesdays.sort(by: {$0.timeCode ?? 0 < $1.timeCode ?? 0})
                print(wednesdays)
                
                let aula = wednesdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aula = aula
                
            // Thursday
            } else if indexPath.section == 4 {
                
                var thursdays: [Aula] = []
                
                for aula in AulaModelController.shared.aulas {
                    
                    if aula.daysOfTheWeek.contains(.Thursday) {
                        thursdays.append(aula)
                    }
                }
                
                // sort thursdays array to display classes by timeCode
                thursdays.sort(by: {$0.timeCode ?? 0 < $1.timeCode ?? 0})
                print(thursdays)
                
                let aula = thursdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aula = aula
                
            // Friday
            } else if indexPath.section == 5 {
                
                var fridays: [Aula] = []
                
                for aula in AulaModelController.shared.aulas {
                    
                    if aula.daysOfTheWeek.contains(.Friday) {
                        fridays.append(aula)
                    }
                }
                
                // sort fridays array to display classes by timeCode
                fridays.sort(by: {$0.timeCode ?? 0 < $1.timeCode ?? 0})
                print(fridays)
                
                let aula = fridays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aula = aula
                
            // Saturday
            } else if indexPath.section == 6 {
                
                var saturdays: [Aula] = []
                
                for aula in AulaModelController.shared.aulas {
                    
                    if aula.daysOfTheWeek.contains(.Saturday) {
                        saturdays.append(aula)
                    }
                }
                
                // sort saturdays array to display classes by timeCode
                saturdays.sort(by: {$0.timeCode ?? 0 < $1.timeCode ?? 0})
                print(saturdays)
                
                let aula = saturdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aula = aula
                
                
            } else {
                print("ERROR: unexpected UITableView section with day of the week we don't have in OwnerClassListTableViewController.swift -> prepare(for segue:) - line 464")
            }
        }
    }

}


// MARK: - NSFetchedREsultsController initializer method
extension OwnerClassListTableViewController: NSFetchedResultsControllerDelegate {
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AulaCD")
        let aulaNameSort = NSSortDescriptor(key: "aulaName", ascending: true)
        request.sortDescriptors = [aulaNameSort]
        
        let moc = CoreDataStack.context
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<AulaCD>
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}



// TODO: can the sections and their respective data be better handled by the fetchedResultsController.  i believe so.
