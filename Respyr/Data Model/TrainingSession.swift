//
//  TrainingSession.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation

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
    var title: String // Should default to the type of course selected
    var date: String
    var startTime: String
    var endTime: String
    var location: String // Should default to the location of training center
    var seatsAvailable: Int
    var allowMultipleReservations: Bool
    var gradingProgress: Int
    var sessionStatus: Bool
    var assessmentCategories: String
    var instructors: [String]
    var students: [String]
}
