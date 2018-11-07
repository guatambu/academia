//
//  ThingsToDoList.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 10/3/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation


// THINGS TO DO

    // UI
        // update fields with data collection to include actual labels rather than allow placeholder text to be the label... asking too much of user - *** COMPLETE

        // redo UI for to allow for multiple screen intake AND NO MORE NIBS!!!
            // owner
                // username password - ***** COMPLETE
                // first & last name + belt - ***** COMPLETE
                // profile pic
                // address - ***** COMPLETE
                // contact info
            // kid student
                // username password
                // first & last name + belt
                // profile pic
                // address
                // contact + emergency contact info
            // adult student
                // username password
                // first & last name + belt
                // profile pic
                // address
                // contact + emergency contact info
            // location:
                // profile pic
                // address
                // contact info

        // wire up all scenes to corresponding cocoa touch files


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
        // create models specifically for persistance
        // refactor existing models
        // set up Core Data structure to support the immediate collection and storage of data
        // on owner side - the data is then sent to cloud backup via batches or individual user granted action
        // on student side - the student does not need to use CoreData, only the owner does, so all student ineractions will be with cloud server ( Firebase Firestore )
        // the flow would be... an action sheet or allert popup that gives the option to save and upload later to cloud, or save and upload to cloud at same time
        // owner would have the option to choose in settings whether they want to save and upload a batch or save and upload a batch later... batch later - this would be for quick response on the mat... batch same time if you are confident in your wifi

    // Picker Wheels
        // Owner New Payment Program
        // Owner Add class
        // Belt Creation?

    // Add new Students to group Button fucntionality
        // collection view add

    // Stripe integration for monthly payments per agreement terms
    // Stripe integration for in house product sales

    // Firebase integration
        // hopefully quick and easy

    // messaging
        // push notifications from owner to students re: events/opportunities
        // actual messaging between owner and instructors
        // limited two way communication between owner and students/parents... ownercan say a lot, and get aggregate canned responses back from audience limiting their responses to just the necessary details
        // text and limited response first... add in pics, vids, gifs etc. later
        // all communications have a 10 shelf life and then dissappear
        // message kit on ray wenderlich tutorial to be ported in

    // Localizaiton
        // Portuguese (BR)




