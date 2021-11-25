//
//  User.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Hashable{
    @DocumentID var id: String?
    var fullName: String
    var email: String
    var instructorID: String
    var memberSince: String
    var trainingCenters: [String]
    var sessionIDs: [String]
    var sentRequests: [String]
    var sentInstructorRequest: [String]
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
        self.sentInstructorRequest = []
        self.adminTC = []
        self.instructorTC = []
        self.sessionReservations = []
        self.checklists = []
    }
    
    init(userID: String, fullName: String, email: String, instructorID: String, memberSince: String, sessionIDs: [String], trainingCenters: [String], sentRequests: [String], sentInstructorRequest: [String], adminTC: [String], instructorTC: [String], sessionReservations: [String], checklists: [String]) {
        self.id = userID
        self.fullName = fullName
        self.email = email
        self.instructorID = instructorID
        self.memberSince = memberSince
        self.trainingCenters = trainingCenters
        self.sessionIDs = sessionIDs
        self.sentRequests = sentRequests
        self.sentInstructorRequest = sentInstructorRequest
        self.adminTC = adminTC
        self.instructorTC = instructorTC
        self.sessionReservations = sessionReservations
        self.checklists = checklists
    }
    
    init() {
        self.fullName = ""
        self.email = ""
        self.instructorID = ""
        self.memberSince = ""
        self.trainingCenters = []
        self.sessionIDs = []
        self.sentRequests = []
        self.sentInstructorRequest = []
        self.adminTC = []
        self.instructorTC = []
        self.sessionReservations = []
        self.checklists = []
    }
}

enum UserCertification: String {
    case HeartSaverProvider
    case BLSProvider
    case BLSProviderInstructor
    case ACLSProvider
    case ACLSProviderInstructor
    case PALSProvider
    case PALSProviderInstructor
}

struct test_User {
    @DocumentID var id: String?
    var fullName: String
    var email: String
    var instructorID: String
    var memberSince: String
    var lastSignedIn: String
//    var sessions: [String] //Unbound for students but maybe plentiful for instructors over a long period of time
    var studentRequest: [String]//0...5
    var instructorRequest: [String]//0...5
    var instructorTrainingCenters: [String]//0...5 - At no point can an instructor of student be a part of more that 5 training centers in total
//    var certifications: [String] //Students can add their certifications to the settings
    var studentTrainingCenters: [String]//0...5
    var sessionReservations: [String]
}

struct test_UserPublicProfile: Codable {
    @DocumentID var id: String?
    var fullName: String
    var email: String
    var instructorTrainingCenter: String
    var studentTrainingCenter: String
    //Public profile has sessions collections
}
