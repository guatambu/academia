//
//  FirestoreTestModel.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 5/22/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation


protocol DocumentTestModelSerializable {
    init?(dictionary: [String : Any])
}


struct TestModel {
    
    var username: String
    var password: String
    
    var dictionary: [String : Any] {
        return [
            "username" : username,
            "password" : password
        
        ]
    }
    
}


extension TestModel: DocumentTestModelSerializable {
    
    init?(dictionary: [String : Any]) {
        
        guard let username = dictionary["username"] as? String else {
            
            print("ERROR: nil value found for username in firestore dictionary in TestModel.swift -> init(dictionary:) - line 38.")
            return nil
        }
        
        guard let password = dictionary["password"] as? String else {
            
            print("ERROR: nil value found for password in firestore dictionary in TestModel.swift -> init(dictionary:) - line 45.")
            return nil
        }
        
        self.init(username: username, password: password)
    }
}
