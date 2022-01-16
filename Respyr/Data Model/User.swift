//
//  User.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation
import FirebaseFirestoreSwift
//import UIKit

//struct User: Identifiable, Codable, Hashable{
//    @DocumentID var id: String?
//    var fullName: String
//    var email: String
//    var instructorID: String
//    var memberSince: String
//    var trainingCenters: [String]
//    var sessionIDs: [String]
//    var sentRequests: [String]
//    var sentInstructorRequest: [String]
//    var adminTC: [String]
//    var instructorTC: [String]
//    var sessionReservations: [String]
//    var checklists: [String]
//    
//    
//    //Initializer for new users
//    init(userID: String, fullName: String, email: String) {
//        self.id = userID
//        self.fullName = fullName
//        self.email = email
//        self.instructorID = ""
//        self.memberSince = ""
//        self.trainingCenters = []
//        self.sessionIDs = []
//        self.sentRequests = []
//        self.sentInstructorRequest = []
//        self.adminTC = []
//        self.instructorTC = []
//        self.sessionReservations = []
//        self.checklists = []
//    }
//    
//    init(userID: String, fullName: String, email: String, instructorID: String, memberSince: String, sessionIDs: [String], trainingCenters: [String], sentRequests: [String], sentInstructorRequest: [String], adminTC: [String], instructorTC: [String], sessionReservations: [String], checklists: [String]) {
//        self.id = userID
//        self.fullName = fullName
//        self.email = email
//        self.instructorID = instructorID
//        self.memberSince = memberSince
//        self.trainingCenters = trainingCenters
//        self.sessionIDs = sessionIDs
//        self.sentRequests = sentRequests
//        self.sentInstructorRequest = sentInstructorRequest
//        self.adminTC = adminTC
//        self.instructorTC = instructorTC
//        self.sessionReservations = sessionReservations
//        self.checklists = checklists
//    }
//    
//    init() {
//        self.fullName = ""
//        self.email = ""
//        self.instructorID = ""
//        self.memberSince = ""
//        self.trainingCenters = []
//        self.sessionIDs = []
//        self.sentRequests = []
//        self.sentInstructorRequest = []
//        self.adminTC = []
//        self.instructorTC = []
//        self.sessionReservations = []
//        self.checklists = []
//    }
//}

enum UserCertification: String, CaseIterable {
    case HeartSaverProvider = "Heart Saver Provider"
    case BLSProvider = "Basic Life Support Provider"
    case BLSProviderInstructor = "Basic Life Support Instructor"
    case ACLSProvider = "Advanced Cardiovascular Life Support Provider"
    case ACLSProviderInstructor = "Advanced Cardiovascular Life Support Instructor"
    case PALSProvider = "Pediatric Advanced Life Support Provider"
    case PALSProviderInstructor = "Pediatric Advanced Life Support Instructor"
}

struct User: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var email: String
    var instructorID: String
    var memberSince: String
    var lastSignedIn: String
    var sentRequests: [String] //Students or instructor view will depend on the certifications uploaded by the user.
    var trainingCenters: [String]//0...5 - At no point can an instructor of student be a part of more that 5 training centers in total
    var sessionReservations: [String]
    
    //Default initializer
    init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.instructorID = ""
        self.memberSince = ""
        self.lastSignedIn = ""
        self.sentRequests = []
        self.trainingCenters = []
        self.sessionReservations = []
    }
    
    //Initializer for new users in Core Data
    init(id: String, email: String) {
        self.id = id
        self.firstName = ""
        self.lastName = ""
        self.email = email
        self.instructorID = ""
        self.memberSince = ""
        self.lastSignedIn = ""
        self.sentRequests = []
        self.trainingCenters = []
        self.sessionReservations = []
    }
    
    init(id: String, firstName: String, lastName: String, email: String, instructorID: String, memberSince: String, lastSignedIn: String, sentRequests: [String], trainingCenters: [String], sessionReservations: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.instructorID = instructorID
        self.memberSince = memberSince
        self.lastSignedIn = lastSignedIn
        self.sentRequests = sentRequests
        self.trainingCenters = trainingCenters
        self.sessionReservations = sessionReservations
    }
}

struct UserPublicProfile: Codable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var email: String
    var instructorID: String?
    var sessionReservations: [String]
    //Certifications Collection
    //Checklists Collection
}

//Closely related to the user hence the proximity of this struct.
struct Certification: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var userCertificationType: String
    var trainingCenter: String
    var dateIssued: String
    var expiration: String
    
    static func getCertificateImage(certificate: Self?) -> String {
        if let certificate = certificate {
            if certificate.userCertificationType.contains(UserCertification.BLSProvider.rawValue) {
                return "blsimg"
            } else if certificate.userCertificationType.contains(UserCertification.BLSProviderInstructor.rawValue) {
                return "blsimg"
            } else if certificate.userCertificationType.contains(UserCertification.ACLSProvider.rawValue) {
                return "aclsimg"
            } else if certificate.userCertificationType.contains(UserCertification.ACLSProviderInstructor.rawValue){
                return "aclsimg"
            } else if certificate.userCertificationType.contains(UserCertification.PALSProvider.rawValue) {
                return "palsimg"
            } else if certificate.userCertificationType.contains(UserCertification.HeartSaverProvider.rawValue) {
                return "heartsaverimg"
            } else {
                return "palsimg"
            }
        }
        return "nocert"
    }
}

var test_certificate = Certification(userCertificationType: "Pediatric Advanced Life Support Provider", trainingCenter: "St. George's University", dateIssued: "January 1, 2021", expiration: "January 1, 2024")
