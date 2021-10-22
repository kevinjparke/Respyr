//
//  InstructorTC+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension InstructorTC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InstructorTC> {
        return NSFetchRequest<InstructorTC>(entityName: "InstructorTC")
    }

    @NSManaged public var id: String?
    @NSManaged public var userAccount: UserAccount?

}

extension InstructorTC : Identifiable {

}
