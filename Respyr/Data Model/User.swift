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
    
    
    //Initializer for new users
    init(userID: String, fullName: String, email: String) {
        self.id = userID
        self.fullName = fullName
        self.email = email
        self.instructorID = ""
        self.memberSince = ""
        self.trainingCenters = []
        self.sessionIDs = []
        self.sentRequests = []
        self.adminTC = []
        self.instructorTC = []
        self.sessionReservations = []
        self.checklists = []
    }
    
    init(userID: String, fullName: String, email: String, instructorID: String, memberSince: String, sessionIDs: [String], trainingCenters: [String], sentRequests: [String], adminTC: [String], instructorTC: [String], sessionReservations: [String], checklists: [String]) {
        self.id = userID
        self.fullName = ""
        self.email = email
        self.instructorID = ""
        self.memberSince = ""
        self.trainingCenters = []
        self.sessionIDs = []
        self.sentRequests = []
        self.adminTC = []
        self.instructorTC = []
        self.sessionReservations = []
        self.checklists = []
    }
    
    init() {
        self.fullName = ""
        self.email = ""
        self.instructorID = ""
        self.memberSince = ""
        self.trainingCenters = []
        self.sessionIDs = []
        self.sentRequests = []
        self.adminTC = []
        self.instructorTC = []
        self.sessionReservations = []
        self.checklists = []
    }
}
