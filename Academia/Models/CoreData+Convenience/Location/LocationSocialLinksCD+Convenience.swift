//
//  LocationSocialLinksCD+Convenience.swift
//  Academia
//
import CoreData

extension LocationSocialLinksCD {
    
    // convenience initializer to allow creation of a LocationSocialLinksCD object via Academia CoreDataStack's managedObjectContext
    convenience init(socialLink1: String?,
                     socialLink2: String?,
                     socialLink3: String?,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.socialLink1 = socialLink1
        self.socialLink2 = socialLink2
        self.socialLink3 = socialLink3
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
    }
}
