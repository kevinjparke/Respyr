//
//  Checklists+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension Checklists {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Checklists> {
        return NSFetchRequest<Checklists>(entityName: "Checklists")
    }

    @NSManaged public var id: String?
    @NSManaged public var userAccount: UserAccount?

}

extension Checklists : Identifiable {

}
