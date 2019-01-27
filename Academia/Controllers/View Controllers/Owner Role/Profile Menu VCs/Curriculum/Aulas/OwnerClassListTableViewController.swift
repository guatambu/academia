//
//  OwnerClassListTableViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/24/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class OwnerClassListTableViewController: UITableViewController {
    
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
            print("ERROR: unexpected UITableView section created in OwnerClassListTableViewController.swift -> tableView(tableView:, numberOfRowsInSection:) - line 165")
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesMenuCell", for: indexPath) as? AulasListMenuTableViewCell else { return UITableViewCell() }
        
        // TODO: - add in sections functionality as above in numberOfRowsInSection
        
        let aula = AulaModelController.shared.aulas[indexPath.row]
        // Configure the cell...
        cell.aula = aula
        
        return cell
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toAulaInfoDetailsSegue" {
            guard let destinationTVC = segue.destination as? ClassInfoDetailsTableViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let aula = AulaModelController.shared.aulas[indexPath.row]
            
            // Pass the selected object to the new view controller.
            destinationTVC.aula = aula
        }
    }

}
