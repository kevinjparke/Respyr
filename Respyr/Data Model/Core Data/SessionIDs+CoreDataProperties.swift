//
//  SessionIDs+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension SessionIDs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessionIDs> {
        return NSFetchRequest<SessionIDs>(entityName: "SessionIDs")
    }

    @NSManaged public var id: String?
    @NSManaged public var userAccount: UserAccount?

}

extension SessionIDs : Identifiable {

}
