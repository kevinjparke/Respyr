//
//  SentRequests+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension SentRequests {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SentRequests> {
        return NSFetchRequest<SentRequests>(entityName: "SentRequests")
    }

    @NSManaged public var id: String?
    @NSManaged public var userAccount: UserAccount?

}

extension SentRequests : Identifiable {

}
