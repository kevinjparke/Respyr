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
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var instructorID: String = ""
    @Published var memberSince: String = ""
    @Published var lastSignedIn: String = ""
    @Published var sentRequests: [String] = []
    @Published var trainingCenters: [String] = []
    @Published var sessionReservations: [String] = []
    @Published var userDocument: User?
    
    //View Publishers
    @Published var dismissOnboardingScreen: Bool = false
    @Published var showOnboardingView: Bool = false
    
    //Publishers for nested collection
    @Published var userCertificationViewModel = CertificationViewModel()
    @Published var certifications: [Certification] = []
    
    //Firebase
//    @Published var isSignedIn: Bool = false
    @Published var currentUserID: String = ""
    public var authRef = Auth.auth()
    private var db = FirebaseFirestore.Firestore.firestore()
    
    //Alert view
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var alertToggle: Bool = false
    
    //Dependency Injection
    var sessionStore: SessionStore
    
    //Cancel bag
    private var cancelables = Set<AnyCancellable>()
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        self.sessionStore.$user
            .sink { user in
                if let user = user {
                    var userDoc = user
                    userDoc.lastSignedIn = self.updateUserLastSignIn()
                    self.userDocument = userDoc
                    self.populateFields(user: userDoc)
                    self.showOnboarding(firstName: userDoc.firstName, lastName: userDoc.lastName)
                    self.fetchUserCertifications()
                }
            }
            .store(in: &cancelables)
        
        self.sessionStore.$userCertificates
            .sink { cert in
                self.certifications = cert
            }
            .store(in: &cancelables)
    }
    
    func signIn() {
        self.sessionStore.signIn(email: email, password: password)
    }
    
    func signUp() {
        self.sessionStore.signUp(email: email, password: password)
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
    
    func updateUserEmail(email: String) {
        self.sessionStore.authRef.currentUser?.updateEmail(to: email) { error in
            if error != nil {
                self.alertTitle = "Error updating email"
                self.alertMessage = error?.localizedDescription ?? ""
                self.alertToggle.toggle()
            } else  {
                self.alertTitle = "Success"
                self.alertMessage = "Your email address was successfully updated"
                self.alertToggle.toggle()
            }
        }
    }
    
    func reauthenticateUser(oldPassword: String, newPassword: String) {
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: self.email, password: oldPassword)
        self.sessionStore.authRef.currentUser?.reauthenticate(with: credential, completion: { auth, error in
            if let error = error {
                // An error happened.
                self.alertTitle = "Something went wrong"
                self.alertMessage = error.localizedDescription
                self.alertToggle.toggle()
              } else {
                // User re-authenticated.
                  self.updatePassword(newPassword: newPassword)
              }
        })
    }
    
    func updatePassword(newPassword: String) {
        self.sessionStore.authRef.currentUser?.updatePassword(to: newPassword) { error in
            if error != nil {
                self.alertTitle = "Error updating password"
                self.alertMessage = error?.localizedDescription ?? ""
                self.alertToggle.toggle()
            } else {
                self.alertTitle = "Success"
                self.alertMessage = "Your pasword was successfully changed"
                self.alertToggle.toggle()
            }
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
    
    //TODO: - Update user document instead of creating an entire user to pass
    func updateUser() {
        let updatedUser = User(id: currentUserID, firstName: firstName, lastName: lastName, email: email, instructorID: instructorID, memberSince: memberSince, lastSignedIn: lastSignedIn, sentRequests: sentRequests, trainingCenters: trainingCenters, sessionReservations: sessionReservations)
        
        do {
            let _ = try self.db.collection("users").document(currentUserID).setData(from: updatedUser)
        } catch let error {
            self.alertTitle = "Error updating user"
            self.alertMessage = error.localizedDescription
            self.alertToggle.toggle()
        }
    }
    
    private func populateFields(user: User) {
        self.currentUserID = user.id ?? ""
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.email = user.email
        self.instructorID = user.instructorID
        self.memberSince = user.memberSince
        self.lastSignedIn = user.lastSignedIn
        self.trainingCenters = user.trainingCenters
        self.sentRequests = user.sentRequests
        self.sessionReservations = user.sessionReservations
    }
    
    func showOnboarding(firstName: String, lastName: String){
        //A user is fully register when there is a firstName, lastName, and email address filled out in their user document
        if firstName.isEmpty || lastName.isEmpty {
            self.showOnboardingView = true
        } else {
            self.showOnboardingView = false
        }
    }
    
    func registerTrainingCenterRequest(with id: String) {
        
    }
    
    func updateUserLastSignIn() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        
        let now = Date()
        return formatter.string(from: now)
    }
}

//MARK: - Update Certifications
extension UserViewModel {
    func fetchUserCertifications() {
        self.userCertificationViewModel.fetchUserCertifications(userID: currentUserID)
    }
    
    func updateUserCertification(certification: Certification) {
        self.sessionStore.updateUserCertification(userCertification: certification)
    }
}

//MARK: - Validation checks
extension UserViewModel {
    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isSignupComplete() -> Bool {
        if isEmpty(_field: self.firstName) || isEmpty(_field: self.lastName) {
            return false
        }
        return true
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
//    func test_createUser() {
//        let test = test_User(id: self.currentUserID, fullName: self.fullName, email: self.email, instructorID: self.instructorID, memberSince: self.memberSince, lastSignedIn: self.lastSignedIn, studentRequest: self.sentStudentRequest, instructorRequest: self.sentInstructorRequest, instructorTrainingCenters: self.instructorTC, studentTrainingCenters: self.trainingCenters, sessionReservations: self.sessionReservations)
//
//        do {
//            let _ =  try self.db.collection("users").document(authRef.currentUser?.uid ?? "").setData(from: test)
//
//            //Add user to core data here?
//
//        } catch let error {
//            self.alertTitle = "Trouble adding user details"
//            self.alertMessage = error.localizedDescription
//            self.alertToggle.toggle()
//        }
//    }
}
