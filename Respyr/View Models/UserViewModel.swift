//
//  UserViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 10/6/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import CoreData
import Combine

class UserViewModel: ObservableObject {
    
    //User document attributes
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var profileImage: UIImage?
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var instructorID: String = ""
    @Published var memberSince: String = ""
    @Published var trainingCenters: [String] = []
    @Published var sessionIDs: [String] = []
    @Published var sentRequests: [String] = []
    @Published var sentInstructorRequest: [String] = []
    @Published var adminTC: [String] = []
    @Published var instructorTC: [String] = []
    @Published var sessionReservations: [String] = []
    @Published var checklists: [String] = []
    
    //Firebase
    @Published var isSignedIn: Bool = false
    @Published var currentUserID: String = ""
    public var authRef = Auth.auth()
    private var db = FirebaseFirestore.Firestore.firestore()
    
    //Alert view
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var alertToggle: Bool = false
    
    //Instantiated in fetchUser()
    @Published var userDocument: User?
    @Published var allUsers: [User] = []
    @Published var singleFetchUser: User?
    
    //Test properties
    @Published var sentStudentRequest: [String] = ""
    @Published var asentInstructorRequests: [String] = ""
    @Published var lastSignedIn: String = ""
    
    var sessionStore = SessionStore()
    private var cancelables = Set<AnyCancellable>()
    
    public var userTitle: String {
        if !instructorTC.isEmpty {
            return "Instructor at"
        } else if !trainingCenters.isEmpty{
            return "Student at"
        }
        return "No affiliated training centers yet"
    }
    
    init() {
        self.listen()
    }
    
    func listen() {
        authRef.addStateDidChangeListener { auth, user in
            if user != nil {
                self.isSignedIn = true
                self.currentUserID = auth.currentUser?.uid ?? ""
            } else {
                self.isSignedIn = false
            }
        }
    }
    
    func signIn() {
        //Automatically sign in once there is a user found in Core Data?
        //How will we handle multiple users using the same app?
        
        self.authRef.signIn(withEmail: email, password: password) { auth, error in
            guard error == nil else {
                self.alertTitle = "Uh-oh!"
                self.alertMessage = error?.localizedDescription ?? ""
                self.alertToggle.toggle()
                return
            }
            self.currentUserID = auth?.user.uid ?? ""
            self.test_fetchUser()
        }
    }
    
    func signUp() {
        self.authRef.createUser(withEmail: self.email, password: self.password) { result, error in
            guard error == nil else {
                self.alertTitle = "Sign up error"
                self.alertMessage = error?.localizedDescription ?? "Unknown error"
                self.alertToggle.toggle()
                
                return
            }
            self.currentUserID = result?.user.uid ?? ""
            self.createUser()
        }
    }
    
    func signOut() {
        do {
            try authRef.signOut()
        } catch let error {
            self.alertTitle = "Error signing out"
            self.alertMessage = error.localizedDescription
            self.alertToggle.toggle()
        }
    }
    
    func sendPasswordResetEmail() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                self.alertTitle = "Oops!"
                self.alertMessage = error?.localizedDescription ?? ""
                self.alertToggle.toggle()
                return
            }
            
            self.alertTitle = "Reset password sent!"
            self.alertMessage = "Check you inbox for an email to reset your password"
            self.alertToggle.toggle()
        }
    }
    
    func createUser() {
        self.userDocument = User (userID: self.currentUserID, fullName: fullName, email: email, instructorID: instructorID, memberSince: memberSince, sessionIDs: trainingCenters, trainingCenters: sessionIDs, sentRequests: sentRequests, sentInstructorRequest: sentInstructorRequest, adminTC: adminTC, instructorTC: instructorTC, sessionReservations: sessionReservations, checklists: checklists)
        
        do {
            let _ =  try self.db.collection("users").document(authRef.currentUser?.uid ?? "").setData(from: userDocument)
            
            //Add user to core data here?
            
        } catch let error {
            self.alertTitle = "Trouble adding user details"
            self.alertMessage = error.localizedDescription
            self.alertToggle.toggle()
        }
    }
    
    func updateUser() {
        let updatedUser = User(userID: self.currentUserID, fullName: fullName, email: email, instructorID: instructorID, memberSince: memberSince, sessionIDs: sessionIDs, trainingCenters: trainingCenters, sentRequests: sentRequests, sentInstructorRequest: sentInstructorRequest, adminTC: adminTC, instructorTC: instructorTC, sessionReservations: sessionReservations, checklists: checklists)
        
        do {
            let _ = try self.db.collection("users").document(authRef.currentUser?.uid ?? "").setData(from: updatedUser)
        } catch let error {
            self.alertTitle = "Error updating user"
            self.alertMessage = error.localizedDescription
            self.alertToggle.toggle()
        }
    }
    
    func test_fetchAllUsers() {
        sessionStore.$users
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { users in
                self.allUsers = users
            }
            .store(in: &cancelables)
    }
    
    func test_fetchUser() {
        self.sessionStore.fetchUser(with: currentUserID)
        sessionStore.$user
            .receive(on: DispatchQueue.main)
            .sink {completion in
                print("completion")
            } receiveValue: { user in
                self.userDocument = user
                if let user = user {
                    self.fullName = user.fullName
                    self.email = user.email
                    self.instructorID = user.instructorID
                    self.memberSince = user.memberSince
                    self.trainingCenters = user.trainingCenters
                    self.sentRequests = user.sentRequests
                    self.sentInstructorRequest = user.sentInstructorRequest
                    self.adminTC = user.adminTC
                    self.instructorTC = user.instructorTC
                    self.sessionReservations = user.sessionReservations
                    self.checklists = user.checklists
                }
            }
            .store(in: &cancelables)
    }
    
    func fetchUser() {
        let docRef = self.db.collection("users").document(authRef.currentUser!.uid )
        docRef.addSnapshotListener { (document, err) in
            let result = Result{
                try? document?.data(as: User.self)
            }
            
            switch result {
            case .success(let user):
                self.userDocument = user
                if let user = user {
                    self.fullName = user.fullName
                    self.email = user.email
                    self.instructorID = user.instructorID
                    self.memberSince = user.memberSince
                    self.trainingCenters = user.trainingCenters
                    self.sentRequests = user.sentRequests
                    self.sentInstructorRequest = user.sentInstructorRequest
                    self.adminTC = user.adminTC
                    self.instructorTC = user.instructorTC
                    self.sessionReservations = user.sessionReservations
                    self.checklists = user.checklists
                } else {
                    print("Couldn't fetch user")
                }
            case .failure(let error):
                self.alertTitle = "Trouble fetching user"
                self.alertMessage = error.localizedDescription
                self.alertToggle.toggle()
            }
        }
    }
    
    func fetchAllUsers() {
        self.db.collection("users").addSnapshotListener { snapshot, error in
            if error != nil {
                //TODO: Handle error
            }
            
            //Update UI on main thread
            DispatchQueue.main.async {
                if let snapshot = snapshot {
                    self.allUsers = snapshot.documents.map { document in
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
    }
    
    func registerTrainingCenterRequest(with id: String) {
        
    }
    
    func generateArray(of values: [String]) -> [String] {
        var arrayValues = [String]()
        for value in values {
            arrayValues.append(value)
        }
        
        return arrayValues
    }
}

//MARK: - Updating training centers
extension UserViewModel {
//    
//    //TODO: Inject session store dependency into UserViewModel and TrainingCenterViewModel
//    func fetchAdmin(with id: String) -> String {
//        sessionStore.fetchUserOnce(id: id)
//            .receive(on: DispatchQueue.main)
//            .sink { user in
//                if let user = user {
//                    return user.fullName
//                }
//            }
//            .store(in: &cancelables)
//    }
//    
//    func fetchTrainingCenters() -> [TrainingCenter]{
//        tc.fetchUserTrainingCenters(with: currentUserID)
//        return tc.userTrainingCenters
//    }
}

//MARK: - Tests
extension UserViewModel {
    func test_createUser() {
        let test = test_User(id: self.currentUserID, fullName: self.fullName, email: self.email, instructorID: self.instructorID, memberSince: self.memberSince, lastSignedIn: self.lastSignedIn, studentRequest: self.sentStudentRequest, instructorRequest: self.sentInstructorRequest, instructorTrainingCenters: self.instructorTC, studentTrainingCenters: self.trainingCenters, sessionReservations: self.sessionReservations)
        
        do {
            let _ =  try self.db.collection("users").document(authRef.currentUser?.uid ?? "").setData(from: test)
            
            //Add user to core data here?
            
        } catch let error {
            self.alertTitle = "Trouble adding user details"
            self.alertMessage = error.localizedDescription
            self.alertToggle.toggle()
        }
    }
}
