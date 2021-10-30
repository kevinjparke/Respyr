//
//  TrainingCenterViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 10/29/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class TrainingCenterViewModel: ObservableObject {
    @Published var userTrainingCenters: [TrainingCenter] = []
    @Published var id: String = ""
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var administrators: [String] = []
    @Published var trainingCenterID: String = ""
    @Published var sessionsConducted: Int = 0
    @Published var instructors: [String] = []
    @Published var students: [String] = []
    @Published var membershipDate: String = ""
    @Published var studentRequests: [String] = []
    @Published var instructorRequests: [String] = []
    @Published var sessions: [String] = []
    
    //Firebase
    public var authRef = Auth.auth()
    private var db = FirebaseFirestore.Firestore.firestore()
    
    func addTrainingCenter() {
        let tcDocument = TrainingCenter(id: id, title: title, location: location, administrators: administrators, trainingCenterID: trainingCenterID, sessionsConducted: sessionsConducted, instructors: instructors, students: students, membershipDate: membershipDate, studentRequests: studentRequests, instructorRequests: instructorRequests, sessions: sessions)
        
        //Core data information saved in UserViewModel
        
        do {
            let _ =  try self.db.collection("trainingCenters").addDocument(from: tcDocument)
        } catch let error {
            print("An error occured: ", error.localizedDescription)
        }
    }
    
    func updateTrainingCenter() {
        //Update training center
    }
    
    func removeTrainingCenter() {
        
    }
    
    func fetchTrainingCenters(with userID: String) {
        
    }
}
