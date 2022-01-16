//
//  TrainingCenter.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation
import FirebaseFirestoreSwift

struct TrainingCenter: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
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


let test_trainingCenter = TrainingCenter(title: "Trinidad & Tobago AHA ITC", location: "Port of Spain, Trinidad", administrators: [], trainingCenterID: "2341Q1VH", sessionsConducted: 0, instructors: [], students: [], membershipDate: "January 1, 2021", studentRequests: [], instructorRequests: [], sessions: [])

let test_trainingCenters = [
    TrainingCenter(title: "Barbados AHA ITC", location: "Bridgetown, Barbados", administrators: [], trainingCenterID: "3423FEWRF2", sessionsConducted: 0, instructors: [], students: [], membershipDate: "January 2, 2021", studentRequests: [], instructorRequests: [], sessions: []),
    
    TrainingCenter(title: "AHA Training Center of Puerto Rico", location: "San Juan, Puerto Rico", administrators: [], trainingCenterID: "2342341RF12", sessionsConducted: 0, instructors: [], students: [], membershipDate: "January 3, 2021", studentRequests: [], instructorRequests: [], sessions: [])
]
