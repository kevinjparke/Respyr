//
//  TrainingCenter.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation

struct TrainingCenter: Identifiable, Codable {
    var id: String
    var title: String
    var location: String
    var administrators: [String]
    var trainingCenterID: String
    var sessionsConducted: Int
    var instructors: [String]
    var students: [String]
    var membershipDate: String
    var studentRequests: [String]
    var instructorRequests: [String]
    var sessions: [String]
}
