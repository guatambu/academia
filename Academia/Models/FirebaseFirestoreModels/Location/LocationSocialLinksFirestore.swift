//
//  LocationSocialLinksFirestore.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 7/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

protocol LocationSocialLinksFirestoreModelSerializable {
    init?(dictionary: [String : Any])
}


struct LocationSocialLinksFirestore {
    
    var socialLink1: String?
    var socialLink2: String?
    var socialLink3: String?
    var dateCreated: Date
    var dateEdited: Date
    
    
    var dictionary: [String : Any] {
        return [
            "socialLink1" : socialLink1 ?? "",
            "socialLink2" : socialLink2 ?? "",
            "socialLink3" : socialLink3 ?? "",
            "dateCreated" : dateCreated,
            "dateEdited" : dateEdited,
        ]
    }
    
    
    // initializer to allow creation of a LocationSocialLinks object
    init(socialLink1: String?,
         socialLink2: String?,
         socialLink3: String?,
         dateCreated: Date = Date(),
         dateEdited: Date = Date()
        ) {
        
        self.socialLink1 = socialLink1
        self.socialLink2 = socialLink2
        self.socialLink3 = socialLink3
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
    }
}


extension LocationSocialLinksFirestore: LocationSocialLinksFirestoreModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        
        guard let socialLink1 = dictionary["socialLink1"] as? String else {
            
            print("ERROR: nil value found for socialLink1 in firestore dictionary in TestModel.swift -> init(dictionary:) - line 118.")
            return nil
        }
        
        guard let socialLink2 = dictionary["socialLink3"] as? String else {
            
            print("ERROR: nil value found for socialLink2 in firestore dictionary in TestModel.swift -> init(dictionary:) - line 130.")
            return nil
        }
        
        guard let socialLink3 = dictionary["socialLink3"] as? String else {
            
            print("ERROR: nil value found for socialLink3 in firestore dictionary in TestModel.swift -> init(dictionary:) - line 136.")
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            
            print("ERROR: nil value found for dateCreated in firestore dictionary in TestModel.swift -> init(dictionary:) - line 142.")
            return nil
        }
        
        guard let dateEdited = dictionary["dateEdited"] as? Date else {
            
            print("ERROR: nil value found dateEdited in firestore dictionary in TestModel.swift -> init(dictionary:) - line 160.")
            return nil
        }
        
        self.init(socialLink1: socialLink1, socialLink2: socialLink2, socialLink3: socialLink3, dateCreated: dateCreated, dateEdited: dateEdited)
    }
}
