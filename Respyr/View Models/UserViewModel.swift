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
    @Published var userDocument: User?
    
    public var userTitle: String {
        if !instructorTC.isEmpty {
            return "Instructor at"
        } else if !trainingCenters.isEmpty{
            return "Student at"
        }
        return "No affiliated training centers yet"
    }
    
    init(){ self.listen() }
    
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
        self.authRef.signIn(withEmail: email, password: password) { auth, error in
            guard error == nil else {
                self.alertTitle = "Uh-oh!"
                self.alertMessage = error?.localizedDescription ?? ""
                self.alertToggle.toggle()
                return
            }
            self.fetchUser()
            self.currentUserID = auth?.user.uid ?? ""
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
        self.userDocument = User (fullName: fullName, email: email, instructorID: instructorID, memberSince: memberSince, trainingCenters: trainingCenters, sessionIDs: sessionIDs, sentRequests: sentRequests, adminTC: adminTC, instructorTC: instructorTC, sessionReservations: sessionReservations, checklists: checklists)
        
        do {
            let _ =  try self.db.collection("users").document(authRef.currentUser?.uid ?? "").setData(from: userDocument)
        } catch let error {
            self.alertTitle = "Trouble adding user details"
            self.alertMessage = error.localizedDescription
            self.alertToggle.toggle()
        }
    }
    
    func fetchUser() {
        let docRef = self.db.collection("users").document(authRef.currentUser?.uid ?? "")
        docRef.getDocument { (document, err) in
            let result = Result{
                try? document?.data(as: User.self)
            }
            
            switch result {
                case .success(let user):
                    if let user = user {
                        self.userDocument = user
                    } else {
                        print("Something went wrong")
                    }
                case .failure(let error):
                    self.alertTitle = "Trouble fetching user"
                    self.alertMessage = error.localizedDescription
                    self.alertToggle.toggle()
                }
        }
    }
}
