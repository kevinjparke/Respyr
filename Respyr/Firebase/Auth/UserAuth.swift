////
////  UserAuth.swift
////  Respyr
////
////  Created by Kevin Parke on 10/1/21.
////
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import Combine
//
//
//class UserAuth: ObservableObject {
//    private var authRef = Auth.auth()
//    private var db = FirebaseFirestore.Firestore.firestore()
//    public var currentUserId: String = ""
//    
//    @Published var isSignedIn: Bool = false
//    @Published var handle: AuthStateDidChangeListenerHandle?
//    
//    init() { self.listen() }
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    func listen() {
//        handle = authRef.addStateDidChangeListener {(auth, user) in
//            if let user = user {
//                self.currentUserId = user.uid
//                self.isSignedIn = true
//            } else {
//                self.isSignedIn = false
//            }
//        }
//    }
//    
//    func signIn(email: String, password: String) -> Future<User?, Never> {
//        return Future<User?, Never> { promise in
//            self.authRef.signIn(withEmail: email, password: password) { user, error in
//                if error != nil {
//                    let _ = self.fetchUser(uid: user!.user.uid)
//                        .sink {promise(.success($0))}
//                        .store(in: &self.cancellables)
//                }
//            }
//        }
//    }
//    
//    func signUp(email: String, password: String) -> Future<User?, Never> {
//        return Future<User?, Never> {promise in
//            self.authRef.createUser(withEmail: email, password: password) { result, error in
//                if error != nil {
//                    let newUser = User(firstName: "", lastName: "", email: email, instructorID: "", memberSince: "", trainingCenters: [""], sessionIDs: [], sentRequests: [], adminTC: [], instructorTC: [], sessionReservations: [], checklists: [])
//                    
//                    guard let result = result else { return }
//                    let userID = result.user.uid
//                    
//                    let _ = self.createUser(newUser, with: userID)
//                        .receive(on: DispatchQueue.main)
//                        .sink {promise(.success($0))}
//                        .store(in: &self.cancellables)
//                    
//                }
//            }
//        }
//    }
//    
//    func fetchUser(uid: String) -> Future<User?, Never> {
//        return Future<User?, Never> {promise in
//            self.db.collection("users").document(uid).getDocument { document, error in
//                let result = Result{
//                    try? document?.data(as: User.self)
//                }
//                
//                switch result {
//                    case .success(let user):
//                        if let user = user {
//                            promise(.success(user))
//                        } else {
//                            print("Document does not exist")
//                        }
//                    case .failure(let error):
//                        promise(.success(nil))
//                        print("Error decoding user: \(error)")
//                    }
//            }
//        }
//    }
//    
//    func createUser(_ user: User, with uid: String) -> Future<User?, Never> {
//        return Future<User?, Never> { promise in
//            do {
//                let _ =  try self.db.collection("users").document(uid).setData(from: user)
//                promise(.success(user))
//            } catch {
//                print("something went wrong")
//            }
//        }
//    }
//    
//    func signOut() {
//        do{
//            try self.authRef.signOut()
//        } catch {
//            print("We ran into an error trying to sign you out")
//        }
//    }
//}
