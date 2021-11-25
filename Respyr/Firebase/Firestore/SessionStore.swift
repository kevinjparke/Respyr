//
//  SessionStore.swift
//  Respyr
//
//  Created by Kevin Parke on 11/17/21.
//

import Foundation
import Combine
import FirebaseFirestore

class SessionStore {
    //Get all users from Firebase
    @Published var users: [User] = []
    @Published var user: User?
    
    private var db = FirebaseFirestore.Firestore.firestore()
    
    init() {
        self.fetchAllUsers()
        print(self.users)
    }
    
    private func fetchAllUsers() {
        self.db.collection("users").addSnapshotListener { snapshot, error in
            if error != nil {
                //TODO: Handle error
            }
            
            if let snapshot = snapshot {
                self.users = snapshot.documents.map { document in
                    User(userID: document.documentID,
                        fullName: document["fullName"] as? String ?? "",
                        email: document["email"] as? String ?? "",
                        instructorID: document["instructorID"] as? String ?? "",
                        memberSince: document["memberSince"] as? String ?? "",
                        sessionIDs: document["sessionIDs"] as? [String] ?? [],
                        trainingCenters: document["trainingCenters"] as? [String] ?? [],
                        sentRequests: document["sentRequests"] as? [String] ?? [],
                        sentInstructorRequest: document["sentInstructorRequest"] as? [String] ?? [],
                        adminTC: document["adminTC"] as? [String] ?? [],
                        instructorTC: document["instructorTC"] as? [String] ?? [],
                        sessionReservations: document["sessionReservations"] as? [String] ?? [],
                        checklists: document["checklists"] as? [String] ?? [])
                }
            }
        }
    }
    
    func fetchUser(with id: String) {
        self.db.collection("users").document(id).addSnapshotListener { snapshot, error in
            let result = Result{
                try? snapshot?.data(as: User.self)
            }
            
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                //TODO: Handle error
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUserOnce(id: String) -> Future<User, Never> {
        return Future<User, Never> { promise in
            self.db.collection("users").document(id).addSnapshotListener { snapshot, error in
                let result = Result{
                    try? snapshot?.data(as: User.self)
                }
                
                switch result {
                case .success(let user):
                    if let user = user {
                        promise(.success(user))
                    }
                case .failure(let error):
                    //TODO: Handle error
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //TODO: Fetch all training centers
    
    //TODO: Fetch all training sessions
    
    //TODO: Fetch all Checklists
}
