//
//  SessionReservations+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension SessionReservations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessionReservations> {
        return NSFetchRequest<SessionReservations>(entityName: "SessionReservations")
    }

    @NSManaged public var id: String?
    @NSManaged public var userAccount: UserAccount?

}

extension SessionReservations : Identifiable {

}
