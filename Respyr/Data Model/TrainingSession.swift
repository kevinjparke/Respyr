//
//  TrainingSession.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation
import FirebaseFirestoreSwift

enum TrainingSessionType: String {
    case BLSProvider
    case BLSProviderRecertification
    case HeartSaverFirstAid
    case PALSProvider
    case PALSProviderRecertification
    case ACLSProvider
    case ACLSProviderRecertification
}

struct TrainingSession: Identifiable, Decodable {
    var id: String
    var trainingCenterID: String
    var sessionType: String
    var title: String //Should default to the type of course selected
    var date: String
    var startTime: String
    var endTime: String
    var location: String //Should default to the location of training center
    var seatsAvailable: Int
    var allowMultipleReservations: Bool //Allow students who have pending session reservations for the same type of session to reserve a seat?
    var gradingProgress: Int
    var sessionStatus: Bool
    var assessmentCategories: [String] //Choose from adult, infant or child checklist.
    var instructors: [String]
    var students: [String]
}

struct publicTrainingSessionProfile: Identifiable, Decodable {
    @DocumentID var id: String?
    var trainingCenterID: String
    var sessionType: String
    var title: String
    var date: String
    var startTime: String
    var endTime: String
    var location: String
    var seatsAvailable: String
}
