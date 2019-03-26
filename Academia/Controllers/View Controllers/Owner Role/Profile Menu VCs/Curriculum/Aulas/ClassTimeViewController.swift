//
//  ClassTimeViewController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 1/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// NOTE:  "aula" means "class" in Portuguese. "aula" stands in for the word "class" throughout this workflow as the word "class" is already used as a Swift keyword.

import UIKit

class ClassTimeViewController: UIViewController  {

    // MARK: - Properties
    
    var aulaName: String?
    var active: Bool?
    var aulaDescription: String?
    var daysOfTheWeek: [ClassTimeComponents.Weekdays]?
    var time: String?
    var timeCode: Int?
    
    var inEditingMode: Bool?
    var aulaToEdit: Aula?
    
    // to hold the compiled strings for the classDaysLabelOutlet
    var daysListString = ""
    
    // instances
    let beltBuilder = BeltBuilder()
    let classTimeComponents = ClassTimeComponents()
    var hapticFeedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    // IBOutlets
    @IBOutlet weak var addClassTimeLabelOutlet: UILabel!
    @IBOutlet weak var daysOfTheWeekLabelOutlet: UILabel!
    @IBOutlet weak var classDaysLabelOutlet: UILabel!
    
    // class time UIPickerView
    @IBOutlet weak var classTimePickerView: UIPickerView!
    
    // CoreData properties
    var aulaCDToEdit: AulaCD?
    
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        let avenirFont = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)! ]
        
        navigationController?.navigationBar.titleTextAttributes = avenirFont
        
        // populate the classDaysLabelOutlet with the previously selected daysOfTheWeek
        guard let daysOfTheWeek = daysOfTheWeek else {
            
            print("ERROR: nil value found for daysOfTheWeek array in ClassTimeViewController.swift -> viewWillAppear() - line 50.")
            return
        }
        for day in daysOfTheWeek {
            
            if day == daysOfTheWeek.last {
                daysListString += "\(day)"
            } else {
                daysListString += "\(day), "
            }
            
            daysOfTheWeekLabelOutlet.text = daysListString
        }
        
        // handle inEditingMode setup
        enterEditingMode(inEditingMode: inEditingMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classTimePickerView.delegate = self
        classTimePickerView.dataSource = self
        
        //populateCompletedProfileInfo()
        guard let aulaName = aulaName, let active = active, let aulaDescription = aulaDescription else {
            print("no aulaName, active, or aulaDescription passed to: ClassTimeVC -> viewDidLoad() - line 80")
            return
        }
        
        print("ClassTimeVC \naula name: \(aulaName) \nactive: \(active) \ndescription: \(aulaDescription)")
        
    }
    
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        
        // Location update profile info
        guard let _ = time else {
            
            // warning to user where welcome instructions text changes to red
            addClassTimeLabelOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)

            
            print("ERROR: nil value found for time property in ClassTimeViewController.swift -> saveButtonTapped() - line 108.")
            
            return
        }
            
        updateAulaInfo()
        
        self.returnToClassInfo()
        
        // reset welcome instructions text color and message upon succesful save
        addClassTimeLabelOutlet.textColor = beltBuilder.blackBeltBlack
        
        print("saved edited class time and timeCode: \(String(describing: AulaModelController.shared.aulas[0].time)) \n\(String(describing: AulaModelController.shared.aulas[0].timeCode)))")
        
        inEditingMode = false
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // check for errors before performing segue, and if error, block navigation
        if time == nil {
            
            // warning to user where welcome instructions text changes to red
            addClassTimeLabelOutlet.textColor = beltBuilder.redBeltRed
            
            // fire haptic feedback for error
            hapticFeedbackGenerator = UINotificationFeedbackGenerator()
            hapticFeedbackGenerator?.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            
            return false
            
        } else {
            
            return true
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // confirm appropriate segue via segue.identifier
        if segue.identifier == "toClassLocation" {
            
            // set nav bar controller appearance
            navigationController?.navigationBar.tintColor = beltBuilder.redBeltRed
            navigationController?.navigationBar.backgroundColor = beltBuilder.kidsWhiteCenterRibbonColor
            navigationController?.navigationBar.shadowImage = UIImage()
            
            // Get the ClassTimeViewController using segue.destination.
            guard let destViewController = segue.destination as? ClassLocationViewController else { return }
            
            // pass data to destViewController
            destViewController.time = time
            destViewController.timeCode = timeCode
            destViewController.daysOfTheWeek = daysOfTheWeek
            destViewController.aulaName = aulaName
            destViewController.active = active
            destViewController.aulaDescription = aulaDescription
            
            destViewController.inEditingMode = inEditingMode
            destViewController.aulaToEdit = aulaToEdit
            destViewController.aulaCDToEdit = aulaCDToEdit
        }
        
        // if in Editing Mode = true, good to allow user to have their work saved as the progress through the edit workflow for one final save rather than having to save at each viewcontroller
        updateAulaInfo()
        
        // reset welcome instructions text color and message upon succesful save
        addClassTimeLabelOutlet.textColor = beltBuilder.blackBeltBlack
        
    }

}


// MARK: - Editing Mode for Individual Class case specific setup
extension ClassTimeViewController {
    
    // Update Function for case where want to update user info without a segue
    func updateAulaInfo() {
        
//        guard let aula = aulaToEdit else { return }
//
//        // class update info
//       
//        AulaModelController.shared.update(aula: aula, active: nil, kidAttendees: nil, adultAttendees: nil, aulaDescription: nil, aulaName: nil, daysOfTheWeek: nil, instructor: nil, ownerInstructor: nil, location: nil, students: nil, time: time, timeCode: timeCode, classGroups: nil)
//        print("update class time and timeCode: \(String(describing: AulaModelController.shared.aulas[0].time)) \n\(String(describing: AulaModelController.shared.aulas[0].timeCode)))")
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else { return }
        
        // unwrap the timeCode value for conversion to Int16
        if let timeCodeForUpdate = timeCode {
            // convert timeCode: Int property to Int16 type
            let timeCodeInt16 = Int16(exactly: timeCodeForUpdate)
            // update with the timeCodeInt16 value if not nil
            AulaCDModelController.shared.update(aula: aulaCDToEdit, active: nil, aulaName: nil, aulaDescription: nil, timeCode: timeCodeInt16, time: time)
            
        } else {
            // update with the time property - this is not likely to happen so we'll add a print statement to warn the developer
            print(("ERROR: nil value for timeCode in ClassTimeViewController.swift -> updateAulaInfo() - line 211"))
        }
        // save to CoreData
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    func enterEditingMode(inEditingMode: Bool?) {
        
        guard let inEditingMode = inEditingMode else { return }
        
        if inEditingMode {
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = saveButtonItem
            
            aulaEditingSetup()
        }
        
        print("ClassLocationAndTimeVC -> inEditingMode: \(inEditingMode)")
    }
    
    // owner setup for editing mode
    func aulaEditingSetup() {
        
//        guard let aulaToEdit = aulaToEdit else {
//            return
//        }
//
//        addClassTimeLabelOutlet.text = "\(aulaToEdit.aulaName)"
//
//        daysOfTheWeek = aulaToEdit.daysOfTheWeek
//        time = aulaToEdit.time ?? ""
//        timeCode = aulaToEdit.timeCode
//        timeCodeReader(timeCode: aulaToEdit.timeCode)
//
//        print("time: \(time ?? "ERROR: unexpected nil value for time property in ClassTimeVC.swift -> aulaEditingSetup() - line 204")")
//
//        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
        
        // CoreData version
        guard let aulaCDToEdit = aulaCDToEdit else {
            return
        }
        
        addClassTimeLabelOutlet.text = "\(aulaCDToEdit.aulaName ?? "")"
        
        time = aulaCDToEdit.time ?? ""
        // convert the CoreData Int16 value to regular Int where necessary
        timeCode = Int(aulaCDToEdit.timeCode)
        let timeCodeToEdit = Int(aulaCDToEdit.timeCode)
        
        timeCodeReader(timeCode: timeCodeToEdit)
        
        print("time: \(time ?? "ERROR: unexpected nil value for time property in ClassTimeVC.swift -> aulaEditingSetup() - line 262")")
        
        // check the aulaCDToEdit.daysOfTheWeek NSSet to see which days are present in its contents
        guard let daysOfTheWeekExistingCD = aulaCDToEdit.daysOfTheWeek else { return }
        
        let daySort = NSSortDescriptor(key: "day", ascending: true)
        
        let daysExistingCDArray = daysOfTheWeekExistingCD.sortedArray(using: [daySort]) as! [AulaDaysOfTheWeekCD]
        
        for day in daysExistingCDArray {
            
            switch day.day {
                
            case ClassTimeComponents.Weekdays.Sunday.rawValue:
                
                if let dayEnum = ClassTimeComponents.Weekdays(rawValue: day.day ?? "") {
                    daysOfTheWeek?.append(dayEnum)
                }
                
            case ClassTimeComponents.Weekdays.Monday.rawValue:
                
                if let dayEnum = ClassTimeComponents.Weekdays(rawValue: day.day ?? "") {
                    daysOfTheWeek?.append(dayEnum)
                }
                
            case ClassTimeComponents.Weekdays.Tuesday.rawValue:
                
                if let dayEnum = ClassTimeComponents.Weekdays(rawValue: day.day ?? "") {
                    daysOfTheWeek?.append(dayEnum)
                }
                
            case ClassTimeComponents.Weekdays.Wednesday.rawValue:
                
                if let dayEnum = ClassTimeComponents.Weekdays(rawValue: day.day ?? "") {
                    daysOfTheWeek?.append(dayEnum)
                }
                
            case ClassTimeComponents.Weekdays.Thursday.rawValue:
                
                if let dayEnum = ClassTimeComponents.Weekdays(rawValue: day.day ?? "") {
                    daysOfTheWeek?.append(dayEnum)
                }
                
            case ClassTimeComponents.Weekdays.Friday.rawValue:
                
                if let dayEnum = ClassTimeComponents.Weekdays(rawValue: day.day ?? "") {
                    daysOfTheWeek?.append(dayEnum)
                }
                
            case ClassTimeComponents.Weekdays.Saturday.rawValue:
                
                if let dayEnum = ClassTimeComponents.Weekdays(rawValue: day.day ?? "") {
                    daysOfTheWeek?.append(dayEnum)
                }
                
            default:
                print("ERROR: somehow found a value outside of the days of the week in ClassDayViewController.swift -> aulaEditingSetup() - line 345.")
            }
        }
        
        print("the VC's aula timeOfDay, location, and daysOfTheWeek have been set to the existing aula's coresponding details to be edited and the collection views have reloaded their data")
    }
}


// MARK: - UIPickerView Protocol Conformance & Methods
extension ClassTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // hours component
        if component == 0 {
            return classTimeComponents.hoursStandardArray.count
            
        // minutes component
        } else if component == 1 {
            return classTimeComponents.minuteStringsArray.count
            
        // AM/PM component
        } else if component == 2 {
            return classTimeComponents.amPmArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // TODO: add in the creation of time code across the pickerView selection process
        
        // hours component
        if component == 0 {
            return "\(classTimeComponents.hoursStandardArray[row].rawValue)"
            
            // minutes component
        } else if component == 1 {
            
            let minutes = classTimeComponents.minuteStringsArray[row]
            
            switch minutes {
            case .zero: return ": \(minutes.rawValue)"
            case .five: return ": \(minutes.rawValue)"
            case .ten: return ": \(minutes.rawValue)"
            case .fifteen: return ": \(minutes.rawValue)"
            case .twenty: return ": \(minutes.rawValue)"
            case .twentyfive: return ": \(minutes.rawValue)"
            case .thirty: return ": \(minutes.rawValue)"
            case .thirtyfive: return ": \(minutes.rawValue)"
            case .forty: return ": \(minutes.rawValue)"
            case .fortyfive: return ": \(minutes.rawValue)"
            case .fifty: return ": \(minutes.rawValue)"
            case .fiftyfive: return ": \(minutes.rawValue)"
            }
            
            // AM/PM component
        } else if component == 2 {
            return "\(classTimeComponents.amPmArray[row].rawValue)"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.selectedRow(inComponent: 0) == 23  {
            pickerView.selectRow(0, inComponent: 2, animated: true)
        } else if pickerView.selectedRow(inComponent: 0) >= 11  {
            pickerView.selectRow(1, inComponent: 2, animated: true)
        } else if pickerView.selectedRow(inComponent: 0) < 11  {
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }
        
        let hourSelected = classTimeComponents.hoursStandardArray[pickerView.selectedRow(inComponent: 0)]
        
        let minutesSelected = classTimeComponents.minuteStringsArray[pickerView.selectedRow(inComponent: 1)]
        
        let amPmSelected = classTimeComponents.amPmArray[pickerView.selectedRow(inComponent: 2)]
        
        time = "\(hourSelected.rawValue):\(minutesSelected.rawValue) \(amPmSelected.rawValue)"
        
        timeCode = timeCodeBuilder(hourStandard: hourSelected, minutes: minutesSelected, amPmChoice: amPmSelected)
        
        if let time = time {
            print("time property: \(time)")
        }
        if let timeCode = timeCode {
            print("timeCode property: \(timeCode)")
        }
    }
    
    // MARK: - timeCodeBuilder()
    // the timeCode property is generated to give a sortable value to the aula object that can and will be used to display the various aula objects in OwnerClassListTVC.swift as the class schedule for a given owner's academy(ies)
    func timeCodeBuilder(hourStandard: ClassTimeComponents.HoursStandard, minutes: ClassTimeComponents.MinuteStrings, amPmChoice: ClassTimeComponents.AMPMStrings) -> Int {
        
        var timeCode = 0
        
        switch amPmChoice {
            
        case ClassTimeComponents.AMPMStrings.am:
            timeCode += ClassTimeComponents.AMPMCode.am.rawValue
            
        case ClassTimeComponents.AMPMStrings.pm:
            timeCode += ClassTimeComponents.AMPMCode.pm.rawValue
        }
        
        print("****** AMPM portion of timecode: \(timeCode)")
        
        switch minutes {
            
        case ClassTimeComponents.MinuteStrings.zero:
            timeCode += ClassTimeComponents.MinuteCodes.zero.rawValue
            
        case ClassTimeComponents.MinuteStrings.five :
            timeCode += ClassTimeComponents.MinuteCodes.five.rawValue
            
        case ClassTimeComponents.MinuteStrings.ten :
            timeCode += ClassTimeComponents.MinuteCodes.ten.rawValue
            
        case ClassTimeComponents.MinuteStrings.fifteen :
            timeCode += ClassTimeComponents.MinuteCodes.fifteen.rawValue
            
        case ClassTimeComponents.MinuteStrings.twenty :
            timeCode += ClassTimeComponents.MinuteCodes.twenty.rawValue
            
        case ClassTimeComponents.MinuteStrings.twentyfive :
            timeCode += ClassTimeComponents.MinuteCodes.twentyfive.rawValue
            
        case ClassTimeComponents.MinuteStrings.thirty :
            timeCode += ClassTimeComponents.MinuteCodes.thirty.rawValue
            
        case ClassTimeComponents.MinuteStrings.thirtyfive :
            timeCode += ClassTimeComponents.MinuteCodes.thirtyfive.rawValue
            
        case ClassTimeComponents.MinuteStrings.forty :
            timeCode += ClassTimeComponents.MinuteCodes.forty.rawValue
            
        case ClassTimeComponents.MinuteStrings.fortyfive :
            timeCode += ClassTimeComponents.MinuteCodes.fortyfive.rawValue
            
        case ClassTimeComponents.MinuteStrings.fifty :
            timeCode += ClassTimeComponents.MinuteCodes.fifty.rawValue
            
        case ClassTimeComponents.MinuteStrings.fiftyfive :
            timeCode += ClassTimeComponents.MinuteCodes.fiftyfive.rawValue
        }
        
        print("****** minutes portion + AMPM portion of timecode: \(timeCode)")
        
        switch hourStandard {
        case ClassTimeComponents.HoursStandard.twelve:
            timeCode += ClassTimeComponents.HourCodes.twelve.rawValue
        case ClassTimeComponents.HoursStandard.one:
            timeCode += ClassTimeComponents.HourCodes.one.rawValue
        case ClassTimeComponents.HoursStandard.two:
            timeCode += ClassTimeComponents.HourCodes.two.rawValue
        case ClassTimeComponents.HoursStandard.three:
            timeCode += ClassTimeComponents.HourCodes.three.rawValue
        case ClassTimeComponents.HoursStandard.four:
            timeCode += ClassTimeComponents.HourCodes.four.rawValue
        case ClassTimeComponents.HoursStandard.five:
            timeCode += ClassTimeComponents.HourCodes.five.rawValue
        case ClassTimeComponents.HoursStandard.six:
            timeCode += ClassTimeComponents.HourCodes.six.rawValue
        case ClassTimeComponents.HoursStandard.seven:
            timeCode += ClassTimeComponents.HourCodes.seven.rawValue
        case ClassTimeComponents.HoursStandard.eight:
            timeCode += ClassTimeComponents.HourCodes.eight.rawValue
        case ClassTimeComponents.HoursStandard.nine:
            timeCode += ClassTimeComponents.HourCodes.nine.rawValue
        case ClassTimeComponents.HoursStandard.ten:
            timeCode += ClassTimeComponents.HourCodes.ten.rawValue
        case ClassTimeComponents.HoursStandard.eleven:
            timeCode += ClassTimeComponents.HourCodes.eleven.rawValue
        }
        
        print("****** hour portion + minutes portion + AMPM portion  of timecode: \(timeCode)")
        
        return timeCode
    }
    
    
    // MARK: - timeCodeReader()
    // the timeCode property can be used to determine the various values needed to set the classTimePickerView to allow the user to edit the time and timeCode properties efficiently
    func timeCodeReader(timeCode: Int?) {
        
        guard let timeCode = timeCode else {
            
            print("ERROR: unexpected nil value for aulaToEdit.timeCode in ClassTimeViewController.swift -> timeCodeReader(timeCode:) - line 391")
            
            return
        }
        
        // this value will allow me to parse the original timeCode without it
        var parsedTimeCode = 0
        
        // set the AM/PM value in the pickerView
        if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
            classTimePickerView.selectRow(1, inComponent: 2, animated: true)
            
            parsedTimeCode = timeCode - ClassTimeComponents.AMPMCode.pm.rawValue
        } else {
            classTimePickerView.selectRow(0, inComponent: 2, animated: true)
        }
        
        // set the hour value in the pickerView
        if parsedTimeCode < ClassTimeComponents.HourCodes.one.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 12PM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.twelve.rawValue - 1), inComponent: 0, animated: true)
                
            } else {
                // for 12AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.twelve.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.twelve.rawValue
            
        
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.two.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 1PM
                classTimePickerView.selectRow(((12 + ClassTimeComponents.HoursStandard.one.rawValue) - 1), inComponent: 0, animated: true)
                
            } else {
                // for 1AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.one.rawValue - 1), inComponent: 0, animated: true)
            }

            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.one.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.three.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 2PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.two.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 2AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.two.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.two.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.four.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 3PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.three.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 3AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.three.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.three.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.five.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 4PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.four.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 4AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.four.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.four.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.six.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 5PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.five.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 5AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.five.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.five.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.seven.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 6PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.six.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 6AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.six.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.six.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.eight.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 7PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.seven.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 7AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.seven.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.seven.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.nine.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 8PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.eight.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 8AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.eight.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.eight.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.ten.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 9PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.nine.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 9AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.nine.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.nine.rawValue
            
        } else if parsedTimeCode < ClassTimeComponents.HourCodes.eleven.rawValue {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 10PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.ten.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 10AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.ten.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.ten.rawValue
            
        } else {
            
            if timeCode > ClassTimeComponents.AMPMCode.pm.rawValue {
                // for 11PM
                classTimePickerView.selectRow((12 + (ClassTimeComponents.HoursStandard.eleven.rawValue - 1)), inComponent: 0, animated: true)
                
            } else {
                // for 11AM
                classTimePickerView.selectRow((ClassTimeComponents.HoursStandard.eleven.rawValue - 1), inComponent: 0, animated: true)
            }
            
            parsedTimeCode = parsedTimeCode - ClassTimeComponents.HourCodes.eleven.rawValue
            
        }
        
        switch parsedTimeCode {
        case 1:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.zero.rawValue - 1), inComponent: 1, animated: true)
        case 2:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.five.rawValue - 1), inComponent: 1, animated: true)
        case 3:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.ten.rawValue - 1), inComponent: 1, animated: true)
        case 4:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.fifteen.rawValue - 1), inComponent: 1, animated: true)
        case 5:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.twenty.rawValue - 1), inComponent: 1, animated: true)
        case 6:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.twentyfive.rawValue - 1), inComponent: 1, animated: true)
        case 7:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.thirty.rawValue - 1), inComponent: 1, animated: true)
        case 8:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.thirtyfive.rawValue - 1), inComponent: 1, animated: true)
        case 9:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.forty.rawValue - 1), inComponent: 1, animated: true)
        case 10:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.fortyfive.rawValue - 1), inComponent: 1, animated: true)
        case 11:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.fifty.rawValue - 1), inComponent: 1, animated: true)
        case 12:
            classTimePickerView.selectRow((ClassTimeComponents.MinuteCodes.fiftyfive.rawValue - 1), inComponent: 1, animated: true)
        default:
            print("ERROR: unexpected value for MinutesCode in ClassTimeViewController.swift -> timeCodeReader(timeCode:) - line 573")
        }
        
        
    }

    
}
