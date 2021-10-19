//
//  User.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var fullName: String
    var email: String
    var instructorID: String
    var memberSince: String
    var trainingCenters: [String]
    var sessionIDs: [String]
    var sentRequests: [String]
    var adminTC: [String]
    var instructorTC: [String]
    var sessionReservations: [String]
    var checklists: [String]
    
//    init() {
//        self.firstName = ""
//        self.lastName = ""
//        self.email = ""
//        self.instructorID = ""
//        self.memberSince = ""
//        self.sessionIDs = []
//        self.trainingCenters = []
//        self.sessionIDs = []
//        self.adminTC = []
//        self.instructorTC = []
//        self.sessionReservations = []
//        self.checklists = []
//    }
}
