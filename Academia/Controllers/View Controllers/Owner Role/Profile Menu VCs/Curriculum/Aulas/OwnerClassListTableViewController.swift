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
        label.frame = CGRect(x: 16, y: 0, width: 80, height: 40)
        
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Sunday
        if section == 0 {
            
            var sundays: [Aula] = []
            
            for aula in AulaModelController.shared.aulas {
                
                if aula.daysOfTheWeek.contains(.Sunday) {
                    sundays.append(aula)
                }
            }

            return sundays.count
          
        // Monday
        } else if section == 1 {
            
            var mondays: [Aula] = []
            
            for aula in AulaModelController.shared.aulas {
                
                if aula.daysOfTheWeek.contains(.Monday) {
                    mondays.append(aula)
                }
            }
            return mondays.count
        
        // Tuesday
        } else if section == 2 {
            
            var tuesdays: [Aula] = []
            
            for aula in AulaModelController.shared.aulas {
                
                if aula.daysOfTheWeek.contains(.Tuesday) {
                    tuesdays.append(aula)
                }
            }
            return tuesdays.count
        
        // Wednesday
        } else if section == 3 {
            
            var wednesdays: [Aula] = []
            
            for aula in AulaModelController.shared.aulas {
                
                if aula.daysOfTheWeek.contains(.Wednesday) {
                    wednesdays.append(aula)
                }
            }
            return wednesdays.count
        
        // Thursday
        } else if section == 4 {
            
            var thursdays: [Aula] = []
            
            for aula in AulaModelController.shared.aulas {
                
                if aula.daysOfTheWeek.contains(.Thursday) {
                    thursdays.append(aula)
                }
            }
            return thursdays.count
         
        // Friday
        } else if section == 5 {
            
            var fridays: [Aula] = []
            
            for aula in AulaModelController.shared.aulas {
                
                if aula.daysOfTheWeek.contains(.Friday) {
                    fridays.append(aula)
                }
            }
            return fridays.count
         
        // Saturday
        } else if section == 6 {
            
            var saturdays: [Aula] = []
            
            for aula in AulaModelController.shared.aulas {
                
                if aula.daysOfTheWeek.contains(.Saturday) {
                    saturdays.append(aula)
                }
            }
            return saturdays.count
        
        // error case where some random section were to be displayed
        } else {
            print("ERROR: unexpected UITableView section created in OwnerClassListTableViewController.swift -> tableView(tableView:, numberOfRowsInSection:) - line 167")
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        
        // Sunday
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
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
        
            // Configure the cell
            cell.aula = aula
            
            return cell
            
        // Monday
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
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
            
            // Configure the cell...
            cell.aula = aula
            
            return cell
            
        // Tuesday
        } else if indexPath.section == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
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
            
            // Configure the cell...
            cell.aula = aula
            
            return cell
            
        // Wednesday
        } else if indexPath.section == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
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
            
            // Configure the cell...
            cell.aula = aula
            
            return cell
            
        // Thursday
        } else if indexPath.section == 4 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
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
            
            // Configure the cell...
            cell.aula = aula
            
            return cell
        
        // Friday
        } else if indexPath.section == 5 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
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
            
            // Configure the cell...
            cell.aula = aula
            
            return cell
        
        // Saturday
        } else if indexPath.section == 6 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
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
            
            // Configure the cell...
            cell.aula = aula
            
            return cell
            
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

