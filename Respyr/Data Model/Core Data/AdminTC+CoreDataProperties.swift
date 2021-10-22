//
//  AdminTC+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension AdminTC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdminTC> {
        return NSFetchRequest<AdminTC>(entityName: "AdminTC")
    }

    @NSManaged public var id: String?
    @NSManaged public var userAccount: UserAccount?

}

extension AdminTC : Identifiable {

}
