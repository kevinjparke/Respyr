//
//  SessionStore.swift
//  Respyr
//
//  Created by Kevin Parke on 11/17/21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class SessionStore: ObservableObject {
//    private let alertManager: AlertViewModel
    
    //Get all users from Firebase
    @Published var users: [User] = []
    @Published var user: User?
    @Published var currentUserID: String = ""
    @Published var isSignedIn: Bool = false
    @Published var userCertificates: [Certification] = []
    @Published var coreDataViewModel = CoreDataViewModel()
    private var db = FirebaseFirestore.Firestore.firestore()
    public var authRef = Auth.auth()
    
    init() {
        self.listen()
    }
    
    func listen() {
        self.authRef.addStateDidChangeListener { auth, user in
            if user != nil {
                self.updateValidation(success: true)
                
                //The listener is the only function that fetches user
                //Can safely unwrap in this scope
                self.fetchUser(with: user!.uid)
                self.fetchCertificates(userID: user!.uid)
            } else {
                self.updateValidation(success: false)
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            self.isSignedIn = success
        }
    }
    
    //Singleton
    static let shared = SessionStore()
    
    //Firebase Auth sign up
    func signUp(email: String, password: String) {
        self.authRef.createUser(withEmail: email, password: password) { result, error in
            //Handle error if it returns not nil
            guard error == nil else {
                return
            }
            //Set current userID
            self.currentUserID = result?.user.uid ?? ""
            //Add user to users collection on FirebaseFirestore
            self.createUser(uid: self.currentUserID, email: email)
        }
    }
    
    func signIn(email: String, password: String) {
        self.authRef.signIn(withEmail: email, password: password) { user, error in
            //Handle error if it returns not nil
            guard error == nil else {
                return
            }
            //Set current userID
            self.currentUserID = user?.user.uid ?? ""
        }
    }
    
    //Create user
    func createUser(uid: String, email: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        let memberSince = formatter.string(from: date)
        
        self.user = User(id: uid, firstName: "", lastName: "", email: email, instructorID: "", memberSince: memberSince, lastSignedIn: memberSince, sentRequests: [], trainingCenters: [], sessionReservations: [])
        
        do {
            let _ = try self.db.collection("users").document(uid).setData(from: user)
            //User has sessions and certifications
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Fetches user and listens for changes
    private func fetchAllUsers() {
        self.db.collection("users").addSnapshotListener { snapshot, error in
            if error != nil {
                //TODO: Handle error
            }
            
            if let snapshot = snapshot {
                self.users = snapshot.documents.map { document in
                    User(id: document.documentID,
                         firstName: document["firstName"] as? String ?? "",
                         lastName: document["lastName"] as? String ?? "",
                         email: document["email"] as? String ?? "",
                         instructorID: document["instructorID"] as? String ?? "",
                         memberSince: document["memberSince"] as? String ?? "",
                         lastSignedIn: document["lastSignedIn"] as? String ?? "",
                         sentRequests: document["sentRequests"] as? [String] ?? [],
                         trainingCenters: document["trainingCenters"] as? [String] ?? [],
                         sessionReservations: document["sessionReservations"] as? [String] ?? [])
                }
            }
        }
    }
    
    //Fetches a user and listens for changes
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
            //No need for a snapshot
            self.db.collection("users").document(id).getDocument { snapshot, error in
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
    
    func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        self.authRef.currentUser?.reauthenticate(with: credential, completion: { (result, error) in
            if let error = error {
                completion(error)
            }
            else {
                Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                    completion(error)
                })
            }
        })
    }
    
    
    
    //TODO: Fetch all training centers
    //Funtion that fetches all training centers with the current userID
    
    //TODO: Fetch all training sessions
    
    //TODO: Fetch all Checklists
}

//MARK: - Certificates
extension SessionStore {
    func fetchCertificates(userID: String) {
        self.db.collection("users").document(userID).collection("certificates").addSnapshotListener { snapshot, error in
            guard error == nil else {
                //TODO: Handle errors
                return
            }
            
            if let snapshot = snapshot {
                self.userCertificates = snapshot.documents.map { document in
                    Certification(id: document.documentID,
                                  userCertificationType: document["userCertificationType"] as? String ?? "",
                                  trainingCenter: document["trainingCenter"] as? String ?? "",
                                  dateIssued: document["dateIssued"] as? String ?? "",
                                  expiration: document["expiration"] as? String ?? "")
                }
            }
        }
    }
    
    func addUserCertification(userCertification: Certification) {
        do {
            print("Document ID: \(self.currentUserID)")
            try self.db.collection("users").document(self.authRef.currentUser?.uid ?? "").collection("certificates").document().setData(from: userCertification)
        } catch let error {
            //TODO: Handle Errors
            print("addUserCertification() error: \(error.localizedDescription)")
        }
    }
    
    func removeUserCertification(userCertificationID: String) {
        self.db.collection("users").document(self.authRef.currentUser?.uid ?? "").collection("certificates").document(userCertificationID).delete()
    }
    
    func updateUserCertification(userCertification: Certification) {
        do {
            try self.db.collection("users").document(self.authRef.currentUser?.uid ?? "").collection("certificates").document(userCertification.id!).setData(from: userCertification)
        } catch let error {
            //TODO: Handle Errors
            print("addUserCertification() error: \(error.localizedDescription)")
        }
    }
}
