//
//  UserAccount+CoreDataProperties.swift
//  Respyr
//
//  Created by Kevin Parke on 10/22/21.
//
//

import Foundation
import CoreData


extension UserAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAccount> {
        return NSFetchRequest<UserAccount>(entityName: "UserAccount")
    }

    @NSManaged public var email: String?
    @NSManaged public var fullName: String?
    @NSManaged public var instrutorID: String?
    @NSManaged public var memberSince: Date?
    @NSManaged public var profileImage: Data?
    @NSManaged public var userID: String?
    @NSManaged public var trainingCenters: NSSet?
    @NSManaged public var sessionIDs: NSSet?
    @NSManaged public var sentRequest: NSSet?
    @NSManaged public var adminTC: NSSet?
    @NSManaged public var instructorTC: NSSet?
    @NSManaged public var sessionReservations: NSSet?
    @NSManaged public var checklists: NSSet?

}

// MARK: Generated accessors for trainingCenters
extension UserAccount {

    @objc(addTrainingCentersObject:)
    @NSManaged public func addToTrainingCenters(_ value: TrainingCenterData)

    @objc(removeTrainingCentersObject:)
    @NSManaged public func removeFromTrainingCenters(_ value: TrainingCenterData)

    @objc(addTrainingCenters:)
    @NSManaged public func addToTrainingCenters(_ values: NSSet)

    @objc(removeTrainingCenters:)
    @NSManaged public func removeFromTrainingCenters(_ values: NSSet)

}

// MARK: Generated accessors for sessionIDs
extension UserAccount {

    @objc(addSessionIDsObject:)
    @NSManaged public func addToSessionIDs(_ value: SessionIDs)

    @objc(removeSessionIDsObject:)
    @NSManaged public func removeFromSessionIDs(_ value: SessionIDs)

    @objc(addSessionIDs:)
    @NSManaged public func addToSessionIDs(_ values: NSSet)

    @objc(removeSessionIDs:)
    @NSManaged public func removeFromSessionIDs(_ values: NSSet)

}

// MARK: Generated accessors for sentRequest
extension UserAccount {

    @objc(addSentRequestObject:)
    @NSManaged public func addToSentRequest(_ value: SentRequests)

    @objc(removeSentRequestObject:)
    @NSManaged public func removeFromSentRequest(_ value: SentRequests)

    @objc(addSentRequest:)
    @NSManaged public func addToSentRequest(_ values: NSSet)

    @objc(removeSentRequest:)
    @NSManaged public func removeFromSentRequest(_ values: NSSet)

}

// MARK: Generated accessors for adminTC
extension UserAccount {

    @objc(addAdminTCObject:)
    @NSManaged public func addToAdminTC(_ value: AdminTC)

    @objc(removeAdminTCObject:)
    @NSManaged public func removeFromAdminTC(_ value: AdminTC)

    @objc(addAdminTC:)
    @NSManaged public func addToAdminTC(_ values: NSSet)

    @objc(removeAdminTC:)
    @NSManaged public func removeFromAdminTC(_ values: NSSet)

}

// MARK: Generated accessors for instructorTC
extension UserAccount {

    @objc(addInstructorTCObject:)
    @NSManaged public func addToInstructorTC(_ value: InstructorTC)

    @objc(removeInstructorTCObject:)
    @NSManaged public func removeFromInstructorTC(_ value: InstructorTC)

    @objc(addInstructorTC:)
    @NSManaged public func addToInstructorTC(_ values: NSSet)

    @objc(removeInstructorTC:)
    @NSManaged public func removeFromInstructorTC(_ values: NSSet)

}

// MARK: Generated accessors for sessionReservations
extension UserAccount {

    @objc(addSessionReservationsObject:)
    @NSManaged public func addToSessionReservations(_ value: SessionReservations)

    @objc(removeSessionReservationsObject:)
    @NSManaged public func removeFromSessionReservations(_ value: SessionReservations)

    @objc(addSessionReservations:)
    @NSManaged public func addToSessionReservations(_ values: NSSet)

    @objc(removeSessionReservations:)
    @NSManaged public func removeFromSessionReservations(_ values: NSSet)

}

// MARK: Generated accessors for checklists
extension UserAccount {

    @objc(addChecklistsObject:)
    @NSManaged public func addToChecklists(_ value: Checklists)

    @objc(removeChecklistsObject:)
    @NSManaged public func removeFromChecklists(_ value: Checklists)

    @objc(addChecklists:)
    @NSManaged public func addToChecklists(_ values: NSSet)

    @objc(removeChecklists:)
    @NSManaged public func removeFromChecklists(_ values: NSSet)

}

extension UserAccount : Identifiable {

}
