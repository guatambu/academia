//
//  ThingsToDoList.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 10/3/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation


// THINGS TO DO

    // for OwnerClassListTVC... need to craete sort function to allow for the classes time to have a numeric value that i can sort by.  sorting the dataSource for each day of the week section will then allow the schedule to be displayed properly

    // for ClassInfoDetailsTVC... need to format the raw date value output in last changed for desired time and day format to be displayed



    // more than likely will need to build in a way for owner to report and block users that post inappropriate content (especially around the kids)
        // especially cuz, ya know... MESSAGING!!!!


    // REGARDING CLASS CREATION:  allow user to first choose time of day, then days of the week... user may choose as many days of the week as they wish for that time, the days go into an array that is later looped through to create each individual class object for all tracking of attendance purposes, time of day will be the limitin actor in that an owner needs to go through the aula creation workflow for each time of day

            // in the future perhaps it might be useful to create week/day (depending which is better UI/UX -wise) at a glance visual/graphical interface with 15 minute blocks that the owner can select and highlight and then create all the classes they want of a given type at once and schedulethem accordingly, this could be handled by creating a temporary holding dictionary where the key is day and the valus is the time for that respective day, then this would be looped through to create individual class objects
        // KEY TAKEAWAY RE: CLASS CREATION... KISS -> the class object itself, each individual one should be simple with one day of the week and one time of day associated with it
        // for multipe locations... go through workflow for each location because want to give the granular control to the owner for each location,
            // possible to allow to add all at once, in other words, multiple locations at once, and follow the workflow as is with location set after day, time by creating temporary array to loop through for each locstion... this would be predicated on the idea that the weekly schedule for a type of class would be identical across locations in this scenRIO


    // User Account Deletion
        // for code reusability... will want to make a check when delting a student account to determine whether it is from the student or user side of the app

            // if owner, then need to simply delete the student user account and return to the previous VC whether the macro student list, a group list, or wherever
            // also owner has the final say over the decision to delete a student user account
            // a student user can't delete their account at any given moment becasue they will have the payment obligation to meet.
            // if and when a student wishes to delete an account, a notificaiton will be sent to the owner
            // then owner can make a student user account available for deletion by the student
            // if student, then, only with owner approval, if only one student user account, then the app is being "reset" to the beginning... no account saved

    // Belt class
        // add property for promotion elligibilty so owner can set that up, make it variable
        // add method so owner can set the elligibility property

    // UI
        // update fields with data collection to include actual labels rather than allow placeholder text to be the label... asking too much of user - *** COMPLETE

        // redo UI for to allow for multiple screen intake AND NO MORE NIBS!!!
            // owner
                // username password - ***** COMPLETE
                // first & last name + belt - ***** COMPLETE
                // profile pic - ***** COMPLETE
                // address - ***** COMPLETE
                // contact info
            // kid student
                // username password - ***** COMPLETE
                // first & last name + belt - ***** COMPLETE
                // profile pic - ***** COMPLETE
                // address - ***** COMPLETE
                // contact + emergency contact info - ***** COMPLETE
            // adult student
                // username password - ***** COMPLETE
                // first & last name + belt - ***** COMPLETE
                // profile pic - ***** COMPLETE
                // address - ***** COMPLETE
                // contact + emergency contact info - ***** COMPLETE
            // location:
                // profile pic
                // address
                // contact info

        // wire up all scenes to corresponding cocoa touch files

        // create belts via code rather than nib
            // create funciton that takes inputs for isKid, belt level, number of white stripes, red stripes, black stripes, white degrees and produces appropriate belt level visually in UI. - ***** COMPLETE

    // Models
        // Add UID String properties to all relevant Models - *** COMPLETE

        // all models need to conform to Equatable Protocol -  *** COMPLETE

        // create curriculum model?  would it need persistence -  *** COMPLETE
            // could create technique data model, then a curriculum class would be a one to many realtionship with techniques
            // curriculum itself would be one to many curriculum classes
            // likely have more than 1 curriculum (eg. adults, kids, beginners, intermediate, advanced)


    // Model Controllers
        // User Model Controllers
            // Adult Student Model Controller  -  *** COMPLETE?
                // CRUD Functions
            // Kid Student Model Controller  -  *** COMPLETE?
                // CRUD Functions
            // Owner Model Controller  -  *** COMPLETE?
                // CRUD Functions
        // Location Model Controller  -  *** COMPLETE?
            // CRUD Functions
        // Adult Basic Belt Model Controller  -  *** COMPLETE??
            // CRUD Functions
        // Adult Black Belt Model Controller  -  *** COMPLETE??
            // CRUD Functions
        // Kids Belt Model Controller  -  *** COMPLETE??
            // CRUD Functions
        // Aula Model Controller  -  *** COMPLETE?
            // CRUD Functions
        // Payemnt Program Model Controller  -  *** COMPLETE?
            // CRUD Functions
        // Group Model Controller  -  *** COMPLETE?
            // CRUD Functions
        // OnBoarding Task Model Controller  -  *** COMPLETE?
            // CRUD Functions
        // Technique Model Controller
            // CRUD Functions
        // CurriculumModule Model Controller
            // CRUD Functions
        // Curriculum Model Controller
            // CRUD Functions

    // Core Data
        // create models specifically for persistance **** COMPLETE
        // refactor existing models **** COMPLETE
        // set up Core Data structure to support the immediate collection and storage of data **** COMPLETE
        // on owner side - the data is then sent to cloud backup via batches or individual user granted action
        // on student side - the student does not need to use CoreData, only the owner does, so all student ineractions will be with cloud server ( Firebase Firestore )
        // the flow would be... an action sheet or allert popup that gives the option to save and upload later to cloud, or save and upload to cloud at same time
        // owner would have the option to choose in settings whether they want to save and upload a batch or save and upload a batch later... batch later - this would be for quick response on the mat... batch same time if you are confident in your wifi

    // Picker Wheels
        // Owner New Payment Program - ***** COMPLETE
        // Owner Add class - ***** COMPLETE
        // Belt Creation?  - ***** COMPLETE

    // Add Students to group Button functionality
        // collection view add

    // Stripe integration for monthly payments per agreement terms
    // Stripe integration for in house product sales

    // Looking seriously at PayPal rather than Stripe becuase PayPal appears to be in more countries with different payment strategies

    // Firebase integration
        // hopefully quick and easy
        // install FireBase CocoaPod **** COMPLETE
        // setup Firebase in AppDelegate **** COMPLETE
        // create FirebaseFireStore github branch **** COMPLETE
        // starting basic testing


    // messaging
        // push notifications from owner to students re: events/opportunities
        // actual messaging between owner and instructors
        // limited two way communication between owner and students/parents... ownercan say a lot, and get aggregate canned responses back from audience limiting their responses to just the necessary details
        // text and limited response first... add in pics, vids, gifs etc. later
        // all communications have a 10 shelf life and then dissappear
        // message kit on ray wenderlich tutorial to be ported in

    // Localizaiton
        // Portuguese (BR)


// BUGS:
    // going from coral belts to lower belts, the stripes do not reset to the proper width.  not terrible.  rare use case.  but let's fix it.  thi is after having saved the belt, and making this change in the edit profile workflow. **** Complete ****
    // reducing the number of stripes in a belt may result in too many stripes added in the editing workflow after having clicked save. **** COMPLETE ****


