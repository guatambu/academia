//
//  StudentClassesTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/20/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.


import UIKit

class StudentClassesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let beltBuilder = BeltBuilder()
    
    // tableView Sections Header Labels
    let weekdays: [ClassTimeComponents.Weekdays] = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 24)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // get the saved aulas source of truth array
        let aulasCD = AulaCDModelController.shared.aulas
        
        // for each section, search the returned aulasCD array for each day of the week String and populate the weekday sections arrays according to those reuslts
        
        // Sunday
        if section == 0 {
            
            var counter = 0
            
            for aula in aulasCD {
                
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Sunday.rawValue {
                        counter += 1
                    }
                }
            }
            return counter
            
            // Monday
        } else if section == 1 {
            
            var counter = 0
            
            for aula in aulasCD {
                
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Monday.rawValue {
                        counter += 1
                    }
                }
            }
            return counter
            
            // Tuesday
        } else if section == 2 {
            
            var counter = 0
            
            for aula in aulasCD {
                
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Tuesday.rawValue {
                        counter += 1
                    }
                }
            }
            return counter
            
            // Wednesday
        } else if section == 3 {
            
            var counter = 0
            
            for aula in aulasCD {
                
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Wednesday.rawValue {
                        counter += 1
                    }
                }
            }
            return counter
            
            // Thursday
        } else if section == 4 {
            var counter = 0
            
            for aula in aulasCD {
                
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Thursday.rawValue {
                        counter += 1
                    }
                }
            }
            return counter
            
            // Friday
        } else if section == 5 {
            
            var counter = 0
            
            for aula in aulasCD {
                
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Friday.rawValue {
                        counter += 1
                    }
                }
            }
            return counter
            
            // Saturday
        } else if section == 6 {
            
            var counter = 0
            
            for aula in aulasCD {
                
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Saturday.rawValue {
                        counter += 1
                    }
                }
            }
            return counter
            
            // error case where some random section were to be displayed
        } else {
            print("ERROR: unexpected UITableView section created in StudentClassesTableViewController.swift -> tableView(tableView:, numberOfRowsInSection:) - line 189")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get the saved aulas source of truth array
        let aulasCD = AulaCDModelController.shared.aulas
        
        // Configure the cell...
        
        // for each section, search the returned aulasCD array for each day of the week String and populate the cells according to those reuslts
        
        // Sunday
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
            
            var sundays = [AulaCD]()
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    // if there is a match, add the class to the sundays aula array
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Sunday.rawValue {
                        
                        sundays.append(aula)
                    }
                }
            }
            // sort sundays array to display included classes by timeCode
            sundays.sort(by: {$0.timeCode < $1.timeCode })
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
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    // if there is a match, add the class to the sundays aula array
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Monday.rawValue {
                        
                        mondays.append(aula)
                    }
                }
            }
            // sort sundays array to display included classes by timeCode
            mondays.sort(by: {$0.timeCode < $1.timeCode })
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
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    // if there is a match, add the class to the sundays aula array
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Tuesday.rawValue {
                        
                        tuesdays.append(aula)
                    }
                }
            }
            // sort sundays array to display included classes by timeCode
            tuesdays.sort(by: {$0.timeCode < $1.timeCode })
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
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    // if there is a match, add the class to the sundays aula array
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Wednesday.rawValue {
                        
                        wednesdays.append(aula)
                    }
                }
            }
            // sort sundays array to display included classes by timeCode
            wednesdays.sort(by: {$0.timeCode < $1.timeCode })
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
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    // if there is a match, add the class to the sundays aula array
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Thursday.rawValue {
                        
                        thursdays.append(aula)
                    }
                }
            }
            // sort sundays array to display included classes by timeCode
            thursdays.sort(by: {$0.timeCode < $1.timeCode })
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
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    // if there is a match, add the class to the sundays aula array
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Friday.rawValue {
                        
                        fridays.append(aula)
                    }
                }
            }
            // sort sundays array to display included classes by timeCode
            fridays.sort(by: {$0.timeCode < $1.timeCode })
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
            
            for aula in aulasCD {
                
                // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                if let dayOfTheWeek = aula.dayOfTheWeek {
                    
                    // if there is a match, add the class to the sundays aula array
                    if dayOfTheWeek == ClassTimeComponents.Weekdays.Saturday.rawValue {
                        
                        saturdays.append(aula)
                    }
                }
            }
            // sort sundays array to display included classes by timeCode
            saturdays.sort(by: {$0.timeCode < $1.timeCode })
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
        if segue.identifier == "toStudentClassDetailSegue" {
            
            // get the saved aulas source of truth array
            let aulasCD = AulaCDModelController.shared.aulas
            
            guard let destinationTVC = segue.destination as? StudentClassDetailTableViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // Sunday
            if indexPath.section == 0 {
                
                var sundays: [AulaCD] = []
                
                for aula in aulasCD {
                    
                    // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                    if let dayOfTheWeek = aula.dayOfTheWeek {
                        
                        // if there is a match, add the class to the sundays aula array
                        if dayOfTheWeek == ClassTimeComponents.Weekdays.Sunday.rawValue {
                            
                            sundays.append(aula)
                        }
                    }
                }
                
                // sort sundays array to display classes by timeCode
                sundays.sort(by: {$0.timeCode < $1.timeCode })
                print(sundays)
                
                let aulaCD = sundays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aulaCD = aulaCD
                destinationTVC.dayOfTheWeek = ClassTimeComponents.Weekdays.Sunday.rawValue
                
                // Monday
            } else if indexPath.section == 1 {
                
                var mondays: [AulaCD] = []
                
                for aula in aulasCD {
                    
                    // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                    if let dayOfTheWeek = aula.dayOfTheWeek {
                        
                        // if there is a match, add the class to the sundays aula array
                        if dayOfTheWeek == ClassTimeComponents.Weekdays.Monday.rawValue {
                            
                            mondays.append(aula)
                        }
                    }
                }
                
                // sort mondays array to display classes by timeCode
                mondays.sort(by: {$0.timeCode < $1.timeCode })
                print(mondays)
                
                let aulaCD = mondays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aulaCD = aulaCD
                destinationTVC.dayOfTheWeek = ClassTimeComponents.Weekdays.Monday.rawValue
                
                // Tuesday
            } else if indexPath.section == 2 {
                
                var tuesdays: [AulaCD] = []
                
                for aula in aulasCD {
                    
                    // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                    if let dayOfTheWeek = aula.dayOfTheWeek {
                        
                        // if there is a match, add the class to the sundays aula array
                        if dayOfTheWeek == ClassTimeComponents.Weekdays.Tuesday.rawValue {
                            
                            tuesdays.append(aula)
                        }
                    }
                }
                
                // sort tuesdays array to display classes by timeCode
                tuesdays.sort(by: {$0.timeCode < $1.timeCode })
                print(tuesdays)
                
                let aulaCD = tuesdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aulaCD = aulaCD
                destinationTVC.dayOfTheWeek = ClassTimeComponents.Weekdays.Tuesday.rawValue
                
                // Wednesday
            } else if indexPath.section == 3 {
                
                var wednesdays: [AulaCD] = []
                
                for aula in aulasCD {
                    
                    // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                    if let dayOfTheWeek = aula.dayOfTheWeek {
                        
                        // if there is a match, add the class to the sundays aula array
                        if dayOfTheWeek == ClassTimeComponents.Weekdays.Wednesday.rawValue {
                            
                            wednesdays.append(aula)
                        }
                    }
                }
                
                // sort wednesdays array to display classes by timeCode
                wednesdays.sort(by: {$0.timeCode < $1.timeCode })
                print(wednesdays)
                
                let aulaCD = wednesdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aulaCD = aulaCD
                destinationTVC.dayOfTheWeek = ClassTimeComponents.Weekdays.Wednesday.rawValue
                
                // Thursday
            } else if indexPath.section == 4 {
                
                var thursdays: [AulaCD] = []
                
                for aula in aulasCD {
                    
                    // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                    if let dayOfTheWeek = aula.dayOfTheWeek {
                        
                        // if there is a match, add the class to the sundays aula array
                        if dayOfTheWeek == ClassTimeComponents.Weekdays.Thursday.rawValue {
                            
                            thursdays.append(aula)
                        }
                    }
                }
                
                // sort thursdays array to display classes by timeCode
                thursdays.sort(by: {$0.timeCode < $1.timeCode })
                print(thursdays)
                
                let aulaCD = thursdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aulaCD = aulaCD
                destinationTVC.dayOfTheWeek = ClassTimeComponents.Weekdays.Thursday.rawValue
                
                // Friday
            } else if indexPath.section == 5 {
                
                var fridays: [AulaCD] = []
                
                for aula in aulasCD {
                    
                    // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                    if let dayOfTheWeek = aula.dayOfTheWeek {
                        
                        // if there is a match, add the class to the sundays aula array
                        if dayOfTheWeek == ClassTimeComponents.Weekdays.Friday.rawValue {
                            
                            fridays.append(aula)
                        }
                    }
                }
                
                // sort fridays array to display classes by timeCode
                fridays.sort(by: {$0.timeCode < $1.timeCode })
                print(fridays)
                
                let aulaCD = fridays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aulaCD = aulaCD
                destinationTVC.dayOfTheWeek = ClassTimeComponents.Weekdays.Friday.rawValue
                
                // Saturday
            } else if indexPath.section == 6 {
                
                var saturdays: [AulaCD] = []
                
                for aula in aulasCD {
                    
                    // check the aula.daysOfTheWeek NSSet to see if there is a day of the week present that is identical to this day of the week
                    if let dayOfTheWeek = aula.dayOfTheWeek {
                        
                        // if there is a match, add the class to the sundays aula array
                        if dayOfTheWeek == ClassTimeComponents.Weekdays.Saturday.rawValue {
                            
                            saturdays.append(aula)
                        }
                    }
                }
                
                // sort saturdays array to display classes by timeCode
                saturdays.sort(by: {$0.timeCode < $1.timeCode })
                print(saturdays)
                
                let aulaCD = saturdays[indexPath.row]
                
                // Pass the selected object to the new view controller.
                destinationTVC.aulaCD = aulaCD
                destinationTVC.dayOfTheWeek = ClassTimeComponents.Weekdays.Saturday.rawValue
                
                
            } else {
                print("ERROR: unexpected UITableView section with day of the week we don't have in OwnerClassListTableViewController.swift -> prepare(for segue:) - line 464")
            }
        }
    }
    
}

