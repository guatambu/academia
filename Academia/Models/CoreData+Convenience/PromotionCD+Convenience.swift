//
//  PromotionCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/18/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

extension BeltPromotionCD {
    
    // convenience initializer to allow creation of an PromotionCD object via Academia CoreDataStack's managedObjectContext
    convenience init(promotionDate: Date = Date(), // do i want to manually set the date?
                     numberOfStripes: Int16,
                     beltLevel: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.numberOfStripes = numberOfStripes
        self.beltLevel = beltLevel
    }
    
}
