//
//  TrainingCenterViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 10/29/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class TrainingCenterViewModel: ObservableObject {
    @Published var userTrainingCenters: [TrainingCenter] = []
    @Published var allTrainingCenters: [TrainingCenter] = []
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
    
    //Training center creator name
    @Published var admin: String = "N/A"
    
    //Firebase
    public var authRef = Auth.auth()
    private var db = FirebaseFirestore.Firestore.firestore()
    
    //Dependency Injection
    let sessionStore: SessionStore
    
    //Combine cancel bag
    var cancellables = Set<AnyCancellable>()
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        self.fetchAllTrainingCenters()
    }
    
    func addTrainingCenter() {
        let tcDocument = TrainingCenter(title: title, location: location, administrators: administrators, trainingCenterID: trainingCenterID, sessionsConducted: sessionsConducted, instructors: instructors, students: students, membershipDate: membershipDate, studentRequests: studentRequests, instructorRequests: instructorRequests, sessions: sessions)
        
        //Core data information saved in UserViewModel
        do {
            let _ =  try self.db.collection("trainingCenters").addDocument(from: tcDocument)
        } catch let error {
            //TODO: Handle errors
            print("An error occured: ", error.localizedDescription)
        }
    }
    
    func updateTrainingCenter(_ tc: TrainingCenter) {
        do {
            try db.collection("trainingCenters").document(tc.id!).setData(from: tc)
        } catch let error {
            print(error)
        }
    }
    
    func removeTrainingCenter() {
        
    }
    
    func fetchUserTrainingCenters(with userID: String) {
        
    }
    
    func createTrainingCenterRequest(userID: String, trainingCenterID: String, isInstructor: Bool = false) {
        for center in allTrainingCenters {
            if isInstructor && center.id == trainingCenterID {
                var updatedCenter = center
                updatedCenter.instructorRequests.append(userID)
                self.updateTrainingCenter(updatedCenter)
            } else {
                var updatedCenter = center
                updatedCenter.studentRequests.append(userID)
                self.updateTrainingCenter(updatedCenter)
            }
        }
    }
    
    func fetchAllTrainingCenters() {
        self.db.collection("trainingCenters").getDocuments { snapshot, error in
            if error != nil {
                //TODO: Handle error
            }
            
            //Update UI on main thread
            DispatchQueue.main.async {
                if let snapshot = snapshot {
                    self.allTrainingCenters = snapshot.documents.map { document in
                        return TrainingCenter(
                            id: document.documentID,
                            title: document["title"] as? String ?? "",
                            location: document["location"] as? String ?? "",
                            administrators: document["administrators"] as? [String] ?? [],
                            trainingCenterID: document["trainingCenterID"] as? String ?? "",
                            sessionsConducted: document["sessionsConducted"] as? Int ?? 0,
                            instructors: document["instructors"] as? [String] ?? [],
                            students: document["students"] as? [String] ?? [],
                            membershipDate: document["membershipDate"] as? String ?? "",
                            studentRequests: document["studentRequests"] as? [String] ?? [],
                            instructorRequests: document["instructorRequests"] as? [String] ?? [],
                            sessions: document["sessions"] as? [String] ?? [])
                    }
                }
            }
        }
    }
    
    func fetchTrainingCenterAdministrator(id: String) {
        self.sessionStore.fetchUserOnce(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { user in
                self.admin = "\(user.firstName) \(user.lastName)"
            }
            .store(in: &cancellables)

    }
}
