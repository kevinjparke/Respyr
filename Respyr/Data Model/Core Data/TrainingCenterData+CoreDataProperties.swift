//
//  TrainingCenterData+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension TrainingCenterData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingCenterData> {
        return NSFetchRequest<TrainingCenterData>(entityName: "TrainingCenterData")
    }

    @NSManaged public var id: String?
    @NSManaged public var userAccount: UserAccount?

}

extension TrainingCenterData : Identifiable {

}
